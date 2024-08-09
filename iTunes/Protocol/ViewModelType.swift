//
//  ViewModelType.swift
//  iTunes
//
//  Created by 조규연 on 8/9/24.
//

import Foundation

protocol ViewModel {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
