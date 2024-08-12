//
//  NetworkManager.swift
//  iTunes
//
//  Created by 조규연 on 8/8/24.
//

import Foundation
import RxSwift

final class NetworkManager {
    private init() {}
    static let shared = NetworkManager()
    
    func callAppStoreData(query: String) -> Single<Result<Software, APIError>> {
        let url = "https://itunes.apple.com/search?term=\(query)&country=kr&entity=software"
        
        return Single.create { observer in
            guard let url = URL(string: url) else {
                observer(.failure(APIError.invalidURL))
                return Disposables.create()
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if error != nil {
                    observer(.success(.failure(APIError.unknownResponse)))
                }
                
                guard let response = response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode) else {
                    observer(.success(.failure(APIError.statusError)))
                    return
                }
                
                guard let data else {
                    observer(.success(.failure(APIError.noData)))
                    return
                }
                
                guard let appData = try? JSONDecoder().decode(Software.self, from: data) else {
                    observer(.success(.failure(APIError.decodingError)))
                    return
                }
                
                observer(.success(.success(appData)))
            }
            .resume()
            
            return Disposables.create()
        }
    }
}
