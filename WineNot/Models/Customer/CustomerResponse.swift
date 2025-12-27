import Foundation

struct CustomerResponse: Codable {
    let id: String
    let firstName: String
    let lastName: String
    let dni: String
    let phoneNumber: String
    let email: String
    let address: AddressResponse
}
