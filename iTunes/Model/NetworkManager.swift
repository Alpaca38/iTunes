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
    
    func callAppStoreData(query: String) -> Observable<Software> {
        let url = "https://itunes.apple.com/search?term=\(query)&country=kr&entity=software"
        
        let result = Observable<Software>.create { observer in
            guard let url = URL(string: url) else {
                observer.onError(APIError.invalidURL)
                return Disposables.create()
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error {
                    observer.onError(error)
                }
                
                guard let response = response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode) else {
                    observer.onError(APIError.statusError)
                    return
                }
                
                guard let data else {
                    observer.onError(APIError.noData)
                    return
                }
                
                guard let appData = try? JSONDecoder().decode(Software.self, from: data) else {
                    observer.onError(APIError.decodingError)
                    return
                }
                
                observer.onNext(appData)
                observer.onCompleted()
            }
            .resume()
            
            return Disposables.create()
        }
        
        return result
    }
}
