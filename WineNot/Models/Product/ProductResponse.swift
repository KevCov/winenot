import Foundation

struct ProductResponse: Codable {
    let id: String
    let name: String
    let description: String
    let largeDescription: String
    let countryOrigin: String
    let unitPrice: Double
    let uom: Uom
    let stock: Int
    let urlImage: String
    let brand: BrandResponse
    let category: CategoryResponse
}
