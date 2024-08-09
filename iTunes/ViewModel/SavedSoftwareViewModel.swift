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
    
    func transform(input: Input) -> Output {
        let list = BehaviorSubject<[SavedSoftware]>(value: repository.fetchAll())
        
        return Output(list: list)
    }
}

extension SavedSoftwareViewModel {
    struct Input {
        
    }
    
    struct Output {
        let list: Observable<[SavedSoftware]>
    }
}
