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
            // ¡YA EXISTE! Solo aumentamos la cantidad
            items[index].quantity += 1
            print("Cantidad actualizada: \(items[index].name) ahora tiene \(items[index].quantity)")
        } else {
            // ¡ES NUEVO! Lo agregamos con cantidad 1
            var newProduct = product
            newProduct.quantity = 1
            items.append(newProduct)
            print("Nuevo producto agregado: \(product.name)")
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("CartUpdated"), object: nil)
    }
    
    func increaseQuantity(at index: Int) {
        guard index < items.count else { return }
        items[index].quantity += 1
    }
    
    // 3. DISMINUIR CANTIDAD (-)
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
