//
//  OrderItemResponse.swift
//  WineNot
//
//  Created by Kevin Cordova Aquije on 7/12/25.
//
import Foundation

struct OrderItemResponse: Codable {
    let id: String
    let name: String
    let description: String
    let quantity: String
    let urlImage: String
    let unitPrice: String
}
