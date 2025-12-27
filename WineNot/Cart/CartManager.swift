import Foundation

class CartManager {
    static let shared = CartManager()
    
    private(set) var items: [ProductCartCellModel] = []
    private let service = OrderService()
    
    private init() {}
    
    func add(product: ProductCartCellModel) {
        if let index = items.firstIndex(where: { $0.name == product.name }) {
            items[index].quantity += 1
        } else {
            var newProduct = product
            newProduct.quantity = 1
            items.append(newProduct)
        }
    }
    
    func increaseQuantity(at index: Int) {
        guard index < items.count else { return }
        items[index].quantity += 1
    }
    
    func decreaseQuantity(at index: Int) {
        guard index < items.count else { return }
        
        if items[index].quantity > 1 {
            items[index].quantity -= 1
        } else {
            items.remove(at: index)
        }
    }
    
    func removeItem(at index: Int) {
        guard index < items.count else { return }
        items.remove(at: index)
    }
    
    func clearCart() {
        items.removeAll()
    }
    
    func getTotal() -> Double {
        return items.reduce(0) { total, product in
            return total + (product.unitPrice * Double(product.quantity))
        }
    }
    
    func checkout(completion: @escaping (Result<Void, Error>) -> Void) {
        guard let user = UserManager.shared.currentUser else {
            let error = NSError(domain: "Cart", code: 401, userInfo: [NSLocalizedDescriptionKey: "Usuario no logueado"])
            completion(.failure(error))
            return
        }
        
        guard !items.isEmpty else {
            let error = NSError(domain: "Cart", code: 400, userInfo: [NSLocalizedDescriptionKey: "El carrito está vacío"])
            completion(.failure(error))
            return
        }
        
        let productRequests = items.map { item in
            return ProductPurchaseRequest(id: item.id, quantity: item.quantity)
        }
        
        let shipping = ShippingResponse(
            id: nil,
            customerId: String(user.id),
            department: user.address.department,
            province: user.address.province,
            district: user.address.district,
            street: user.address.street,
            houseNumber: user.address.houseNumber,
            zipCode: user.address.zipCode
        )
        
        let orderRequest = OrderRequest(
            totalAmount: getTotal(),
            paymentMethod: .visa,
            customerId: Int(user.id) ?? 0,
            cardLast4: "4242",
            shipping: shipping,
            products: productRequests
        )
        
        service.createOrder(request: orderRequest) { [weak self] result in
            switch result {
            case .success:
                self?.clearCart()
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
