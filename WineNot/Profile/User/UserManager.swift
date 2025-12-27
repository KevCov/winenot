import Foundation

class UserManager {
    static let shared = UserManager()
    
    private(set) var isLoggedIn: Bool = false
    private(set) var currentUser: CustomerResponse?
    private let service = LoginService()
    
    private init() {}
    
    func login(email: String, pass: String, completion: @escaping (Result<Void, Error>) -> Void) {
        service.loginUser(email: email, password: pass) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(_):
                self.fetchCustomerData(email: email, completion: completion)
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func fetchCustomerData(email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        service.getCustomerProfile(email: email) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let customerResponse):
                self.currentUser = customerResponse
                self.isLoggedIn = true
                
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func logout() {
        self.currentUser = nil
        self.isLoggedIn = false
        print("Sesión cerrada")
    }
}
