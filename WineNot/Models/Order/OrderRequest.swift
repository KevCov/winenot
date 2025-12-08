//
//  OrderRequest.swift
//  WineNot
//
//  Created by Kevin Cordova Aquije on 7/12/25.
//
import Foundation

struct OrderRequest: Codable {
    let totalAmount: Double
    let paymentMethod: PaymentMethod
    let customerId: Int
    let cardLast4: String
    let shipping: ShippingResponse
    let products: [ProductPurchaseRequest]
}
