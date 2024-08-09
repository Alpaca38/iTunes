//
//  SavedSoftwareRepository.swift
//  iTunesSearch
//
//  Created by 조규연 on 8/9/24.
//

import Foundation
import RealmSwift

final class SavedSoftwareRepository {
    private let realm = try! Realm()
    
    func itemExists(id: String) -> Bool {
        return !realm.objects(SavedSoftware.self).where { $0.trackName == id }.isEmpty
    }
    
    func createItem(data: SavedSoftware) {
        do {
            try realm.write {
                realm.add(data)
            }
        } catch {
            print("CreateItem Error")
        }
    }
    
    func fetchAll() -> [SavedSoftware] {
        let results = realm.objects(SavedSoftware.self)
        return Array(results)
    }
    
    func printRealmURL() {
        print(realm.configuration.fileURL!)
    }
}
