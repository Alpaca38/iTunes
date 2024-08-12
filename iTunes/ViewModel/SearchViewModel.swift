//
//  SearchViewModel.swift
//  iTunes
//
//  Created by 조규연 on 8/8/24.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchViewModel: ViewModel {
    private var searchList: [String] {
        get { return UserDefaultsManager.searchList }
        set { UserDefaultsManager.searchList = newValue }
    }
    
    private let repository = SavedSoftwareRepository()
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        let appList = PublishSubject<[SoftwareResult]>()
        let searchList = BehaviorSubject<[String]>(value: searchList)
        
        let searchTap = input.searchTap
            .throttle(.seconds(1), latest: false, scheduler: MainScheduler.instance)
            .withLatestFrom(input.searchText)
            .distinctUntilChanged()
        
        searchTap
            .flatMap {
                NetworkManager.shared.callAppStoreData(query: $0)
            }
            .asDriver(onErrorJustReturn: (.failure(APIError.invalidURL)))
            .debug("button tap")
            .drive(with: self) { owner, result in
                switch result {
                case .success(let success):
                    appList.onNext(success.results)
                case .failure(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
        
        searchTap
            .bind(with: self) { owner, value in
                if !UserDefaultsManager.searchList.contains(value) {
                    owner.searchList.append(value)
                    searchList.onNext(owner.searchList)
                }
            }
            .disposed(by: disposeBag)
        
        input.downloadButtonTap
            .bind(with: self) { owner, softwareResult in
                let data = SavedSoftware(from: softwareResult)
                if owner.repository.itemExists(id: data.trackName) == false {
                    owner.repository.createItem(data: data)
                } else {
                    print("이미 저장된 앱 입니다.")
                }
            }
            .disposed(by: disposeBag)
        
        repository.printRealmURL()
        
        return Output(
            list: appList,
            searchList: searchList
        )
    }
}

extension SearchViewModel {
    struct Input {
        let searchTap: ControlEvent<Void>
        let searchText: ControlProperty<String>
        let downloadButtonTap: PublishRelay<SoftwareResult>
    }
    
    struct Output {
        let list: Observable<[SoftwareResult]>
        let searchList: Observable<[String]>
    }
}
