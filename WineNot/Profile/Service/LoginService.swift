import Foundation

class LoginService {
    init() {}
    
    func loginUser(email: String, password: String, completion: @escaping (Result<AuthResponse, Error>) -> Void) {
        let url = API.Endpoints.login
        let body = UserRequest(email: email, password: password)
        
        APICaller.shared.request(url: url, method: .POST, body: body) { (result: Result<AuthResponse, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getCustomerProfile(email: String, completion: @escaping (Result<CustomerResponse, Error>) -> Void) {
        let url = "\(API.Endpoints.customers)/profile/\(email)"
        APICaller.shared.request(url: url, method: .GET, body: nil as String?) { (result: Result<CustomerResponse, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
