import Foundation

struct OrderRequest: Codable {
    let totalAmount: Double
    let paymentMethod: PaymentMethod
    let customerId: Int
    let cardLast4: String
    let shipping: ShippingResponse
    let products: [ProductPurchaseRequest]
}
