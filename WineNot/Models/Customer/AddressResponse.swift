import Foundation

struct AddressResponse: Codable {
    let department: String
    let province: String
    let district: String
    let street: String
    let houseNumber: Int
    let zipCode: Int
}
