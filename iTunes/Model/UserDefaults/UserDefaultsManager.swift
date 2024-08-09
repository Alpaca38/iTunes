//
//  UserDefaultsManager.swift
//  iTunesSearch
//
//  Created by 조규연 on 8/9/24.
//

import Foundation

struct UserDefaultsManager {
    private init() { }
    
    @UserDefault(key: .searchList, defaultValue: [], isCustomObject: false)
    static var searchList: [String]
}
