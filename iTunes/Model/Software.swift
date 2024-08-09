//
//  Software.swift
//  iTunes
//
//  Created by 조규연 on 8/8/24.
//

import Foundation

struct Software: Decodable {
    let resultCount: Int
    let results: [SoftwareResult]
}

struct SoftwareResult: Decodable, Hashable {
    let trackName: String
    let screenshotUrls: [String]
    let averageUserRating: Double
    let sellerName: String
    let genres: [String]
    let description: String
    let artworkUrl60, artworkUrl100: String
    let artworkUrl512: String?
    let version: String
    let releaseNotes: String
    
    var rating: String {
        return averageUserRating.formatted(.number.precision(.fractionLength(1)))
    }
    
    var versionLabel: String {
        return "버전 \(version)"
    }
}
