//
//  HTTPMethod.swift
//  WineNot
//
//  Created by Kevin Cordova Aquije on 7/12/25.
//
import Foundation

enum APIError: Error {
    case failedToGetData
    case badUrl
    case badResponse(statusCode: Int)
}
