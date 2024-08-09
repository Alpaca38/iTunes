//
//  SearchDetailViewModel.swift
//  iTunesSearch
//
//  Created by 조규연 on 8/9/24.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchDetailViewModel: ViewModel {
    let softwareData: SoftwareResult
    
    init(softwareData: SoftwareResult) {
        self.softwareData = softwareData
    }
    
    func transform(input: Input) -> Output {
        Output()
    }
}

extension SearchDetailViewModel {
    struct Input {
        
    }
    
    struct Output {
        
    }
}
