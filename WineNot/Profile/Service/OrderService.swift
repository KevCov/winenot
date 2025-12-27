import Foundation

class OrderService {
    init() {}
    
    func createOrder(request: OrderRequest, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = "\(API.Endpoints.orders)/create"
        APICaller.shared.request(url: url, method: .POST, body: request) { (result: Result<Int, Error>) in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getOrders(id: String, completion: @escaping (Result<[OrderCellModel], Error>) -> Void) {
        let url = "\(API.Endpoints.orders)/by-user/\(id)"
        APICaller.shared.request(url: url, method: .GET, body: nil as String?) { (result: Result<[OrderResponse], Error>) in
            switch result {
            case .success(let response):
                let mappedModels = response.map { order in
                    let totalQuantity = order.products.reduce(0) { partialResult, product in
                        let quantityInt = Int(product.quantity) ?? 0
                        return partialResult + quantityInt
                    }
                    return OrderCellModel(
                        numberOrder: order.id,
                        quantity: totalQuantity,
                        total: order.totalAmount
                    )
                }
                completion(.success(mappedModels))
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
}
