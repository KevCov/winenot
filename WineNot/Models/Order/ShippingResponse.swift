import Foundation

struct ShippingResponse: Codable {
    let id: Int?
    let customerId: String
    let department: String
    let province: String
    let district: String
    let street: String
    let houseNumber: Int
    let zipCode: Int
}
