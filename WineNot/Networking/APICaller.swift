//
//  APICaller.swift
//  WineNot
//
//  Created by Kevin Cordova Aquije on 6/12/25.
//
import Foundation

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
}

class APICaller {
    static let shared = APICaller()
    private let decoder = JSONDecoder()
    
    private init() {}
    
    func postRequest<T: Codable, R: Codable>(
        url: String,
        method: String,
        body: T,
        completion: @escaping (Result<R, Error>) -> Void
    ) {
        guard let endpoint = URL(string: url) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        var request = URLRequest(url: endpoint)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONEncoder().encode(body)
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let http = response as? HTTPURLResponse,
                  (200..<300).contains(http.statusCode) else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            guard let data = data else {
                completion(.failure(URLError(.cannotDecodeRawData)))
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(R.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func getRequest<R: Codable>(
        url: String,
        completion: @escaping (Result<R, Error>) -> Void
    ) {
        guard let endpoint = URL(string: url) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        var request = URLRequest(url: endpoint)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let http = response as? HTTPURLResponse,
                  (200..<300).contains(http.statusCode) else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            guard let data = data else {
                completion(.failure(URLError(.cannotDecodeRawData)))
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(R.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
}
