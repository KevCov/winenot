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
    
    func request<T: Codable, R: Codable>(
            url: String,
            method: HTTPMethod,
            body: T? = nil,
            expecting: R.Type,
            completion: @escaping (Result<R, Error>) -> Void
        ) {
            guard let endpoint = URL(string: url) else {
                completion(.failure(APIError.badUrl))
                return
            }
            
            var request = URLRequest(url: endpoint)
            request.httpMethod = method.rawValue
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            if let token = UserDefaults.standard.string(forKey: "accessToken") {
                 request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
            
            if let body = body {
                do {
                    request.httpBody = try JSONEncoder().encode(body)
                } catch {
                    completion(.failure(error))
                    return
                }
            }
            
            URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                guard let self = self else { return }
                
                if let error = error {
                    DispatchQueue.main.async { completion(.failure(error)) }
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    let code = (response as? HTTPURLResponse)?.statusCode ?? 0
                    DispatchQueue.main.async { completion(.failure(APIError.badResponse(statusCode: code))) }
                    return
                }
                
                guard let data = data else {
                    DispatchQueue.main.async { completion(.failure(APIError.failedToGetData)) }
                    return
                }
                
                do {
                    let result = try self.decoder.decode(R.self, from: data)
                    DispatchQueue.main.async { completion(.success(result)) }
                } catch {
                    DispatchQueue.main.async { completion(.failure(error)) }
                }
                
            }.resume()
        }
}
