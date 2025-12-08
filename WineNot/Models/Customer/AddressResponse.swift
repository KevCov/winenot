//
//  AddressResponse.swift
//  WineNot
//
//  Created by Kevin Cordova Aquije on 7/12/25.
//
import Foundation

struct AddressResponse: Codable {
    let department: String
    let province: String
    let district: String
    let streer: String
    let houseNumber: Int
    let zipCode: Int
}
