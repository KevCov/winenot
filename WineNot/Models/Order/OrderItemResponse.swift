import Foundation

struct OrderItemResponse: Codable {
    let id: String
    let name: String
    let description: String
    let quantity: String
    let urlImage: String
    let unitPrice: String
}
