import Foundation

enum APIError: Error {
    case failedToGetData
    case badUrl
    case badResponse(statusCode: Int)
}
