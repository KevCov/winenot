//
//  OrderResponse.swift
//  WineNot
//
//  Created by Kevin Cordova Aquije on 7/12/25.
//
import Foundation

struct OrderResponse: Codable {
    let id: String
    let totalAmount: Double
    let orderDate: String
    let paymentMethod: PaymentMethod
    let cardLast4: String
    let shipping: ShippingResponse
    let customerId: Int
    let products: [OrderItemResponse]
}
