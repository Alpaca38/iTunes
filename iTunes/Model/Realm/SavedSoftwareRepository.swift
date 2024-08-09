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
    private var notificationToken: NotificationToken?
    
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
    
    func setNotification(completion: @escaping (RealmCollectionChange<Any>) -> Void) {
        notificationToken = realm.objects(SavedSoftware.self).observe({ (changes: RealmCollectionChange) in
            switch changes {
            case .initial(_):
                completion(.initial(Any.self))
            case .update(_, deletions: let deletions, insertions: let insertions, modifications: let modifications):
                completion(.update(Any.self, deletions: [], insertions: [], modifications: []))
            case .error(let error):
                completion(.error(error))
            }
        })
    }
    
    func printRealmURL() {
        print(realm.configuration.fileURL!)
    }
}
