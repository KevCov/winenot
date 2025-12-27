import Foundation

class StoreService {
    init() {}
    
    func getProducts(completion: @escaping (Result<[ProductCellViewModel], Error>) -> Void) {
        let url = API.Endpoints.products
        
        APICaller.shared.request(url: url, method: .GET, body: nil as String?) { (result: Result<Pageable, Error>) in
            switch result {
            case .success(let pageableResponse):
                let mappedModels = pageableResponse.content.map { product in
                    return ProductCellViewModel(
                        id: Int(product.id) ?? 0,
                        name: product.name,
                        price: String(format: "%.2f", product.unitPrice),
                        description: product.description,
                        imageName: product.urlImage
                    )
                }
                completion(.success(mappedModels))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
