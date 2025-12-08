//
//  UserResponse.swift
//  WineNot
//
//  Created by Kevin Cordova Aquije on 7/12/25.
//
import Foundation

struct AuthResponse: Codable {
    let accessToken: String
    let refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}
