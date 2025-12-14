//
//  StoreService.swift
//  WineNot
//
//  Created by Kevin Cordova Aquije on 14/12/25.
//
import Foundation

class StoreService {
    static let shared = StoreService()
    
    func getProducts(completion: @escaping (Result<[ProductResponse], Error>) -> Void) {
        let url = "http://localhost:8050/api/v1/products"
        
        APICaller.shared.request(url: url, method: .GET, body: nil as String?) { (result: Result<Pageable, Error>) in
            
            switch result {
            case .success(let pageableResponse):
                completion(.success(pageableResponse.content))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
