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
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        let appList = PublishSubject<[SoftwareResult]>()
        
        input.searchTap
            .throttle(.seconds(1), latest: false, scheduler: MainScheduler.instance)
            .withLatestFrom(input.searchText)
            .distinctUntilChanged()
            .flatMap {
                NetworkManager.shared.callAppStoreData(query: $0)
            }
            .subscribe(with: self) { owner, value in
                appList.onNext(value.results)
            } onError: { owner, error in
                print("error - \(error)")
            } onCompleted: { value in
                print("completed")
            } onDisposed: { value in
                print("disposed")
            }
            .disposed(by: disposeBag)
        
        return Output(list: appList)
    }
}

extension SearchViewModel {
    struct Input {
        let searchTap: ControlEvent<Void>
        let searchText: ControlProperty<String>
    }
    
    struct Output {
        let list: Observable<[SoftwareResult]>
    }
}
