enum API {
    static let baseURL = "http://18.232.55.138:8050"
    
    struct Endpoints {
        static let login = "\(API.baseURL)/auth/login"
        static let orders = "\(API.baseURL)/api/v1/orders"
        static let products = "\(API.baseURL)/api/v1/products"
        static let customers = "\(API.baseURL)/api/v1/customers"
    }
}
