//
//  CartManager.swift
//  WineNot
//
//  Created by Kevin Cordova Aquije on 20/12/25.
//
import Foundation

class CartManager {
    static let shared = CartManager()
    
    private(set) var items: [ProductCartCellModel] = []
    
    private init() {}
    
    func add(product: ProductCartCellModel) {
        if let index = items.firstIndex(where: { $0.name == product.name }) {
            items[index].quantity += 1
        } else {
            var newProduct = product
            newProduct.quantity = 1
            items.append(newProduct)
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("CartUpdated"), object: nil)
    }
    
    func increaseQuantity(at index: Int) {
        guard index < items.count else { return }
        items[index].quantity += 1
    }
    
    func decreaseQuantity(at index: Int) {
        guard index < items.count else { return }
        
        if items[index].quantity > 1 {
            items[index].quantity -= 1
        } else {
            items.remove(at: index)
        }
    }
    
    func removeItem(at index: Int) {
        guard index < items.count else { return }
        items.remove(at: index)
    }
    
    func clearCart() {
        items.removeAll()
    }
    
    func getTotal() -> Double {
        return items.reduce(0) { total, product in
            return total + (product.unitPrice * Double(product.quantity))
        }
    }
}
