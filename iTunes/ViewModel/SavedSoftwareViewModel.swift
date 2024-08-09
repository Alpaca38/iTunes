//
//  SavedSoftwareViewModel.swift
//  iTunesSearch
//
//  Created by 조규연 on 8/9/24.
//

import UIKit
import RxSwift

final class SavedSoftwareViewModel: ViewModel {
    private let repository = SavedSoftwareRepository()
    
    private let list = PublishSubject<[SavedSoftware]>()
    
    func transform(input: Input) -> Output {
        return Output(list: list)
    }
    
    init() {
        setNotification()
    }
}

extension SavedSoftwareViewModel {
    struct Input {
        
    }
    
    struct Output {
        let list: Observable<[SavedSoftware]>
    }
    
    func setNotification() {
        repository.setNotification { [weak self] changes in
            guard let self else { return }
            switch changes {
            case .initial(_):
                list.onNext(repository.fetchAll())
            case .update(_, deletions: _, insertions: _, modifications: _):
                list.onNext(repository.fetchAll())
            case .error(let error):
                print(error)
            }
        }
    }
}
