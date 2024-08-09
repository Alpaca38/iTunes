//
//  RealmModel.swift
//  iTunesSearch
//
//  Created by 조규연 on 8/9/24.
//

import Foundation
import RealmSwift

final class SavedSoftware: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var artworkURL: String
    @Persisted var trackName: String
    @Persisted var regDate: Date
    
    var regDateLabel: String {
        return regDate.formatted(.dateTime.month(.abbreviated).day(.defaultDigits).year(.twoDigits))
    }
    
    convenience init(from softwareResult: SoftwareResult) {
        self.init()
        self.artworkURL = softwareResult.artworkUrl100
        self.trackName = softwareResult.trackName
        self.regDate = Date()
    }
}
