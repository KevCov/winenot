//
//  CartController.swift
//  WineNot
//
//  Created by Kevin Cordova Aquije on 9/12/25.
//

import UIKit

class CartController: UIViewController {
    
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var subtotalAmount: UILabel!
    @IBOutlet weak var igvLabel: UILabel!
    @IBOutlet weak var igvAmount: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var generateOrderButton: UIButton!
    @IBOutlet weak var productCartTableView: UITableView!
    let colorText = UIColor(named: "text-primary") ?? .white
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundColor(color: UIColor(named: "color-background") ?? .green)
        
        subtotalLabel.configure(text: "Subtotal", color: colorText, size: 14, weight: .bold)
        igvLabel.configure(text: "Impuesto", color: colorText, size: 14, weight: .bold)
        totalLabel.configure(text: "A Pagar", color: colorText, size: 14, weight: .bold)
        
        generateOrderButton.setText(text: "Generar Orden", color: UIColor(named: "color-background") ?? .green, size: 16, weight: .bold)
        generateOrderButton.setBackgroundColor(color: colorText)
        generateOrderButton.setRadius(radius: 10)
        
        productCartTableView.dataSource = self
        productCartTableView.delegate = self
        productCartTableView.setBackgroundColor(color: .clear)
        productCartTableView.register(UINib(nibName: "ProductCartCell", bundle: nil), forCellReuseIdentifier: ProductCartCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        productCartTableView.reloadData()
        updateTotals()
    }
    
    func reloadCartData() {
        productCartTableView.reloadData()
        updateTotals()
    }
    
    func updateTotals() {
        let total = CartManager.shared.getTotal()
        let subtotal = total / 1.18
        let igv = total - subtotal
        
        subtotalAmount.configure(text: String(format: "S/. %.2f", subtotal), color: colorText, size: 14)
        igvAmount.configure(text: String(format: "S/. %.2f", igv), color: colorText, size: 14)
        totalAmount.configure(text: String(format: "S/. %.2f", total), color: colorText, size: 14)
    }
    
}

extension CartController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CartManager.shared.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductCartCell.identifier, for: indexPath) as? ProductCartCell else {
            return UITableViewCell()
        }
        
        let product = CartManager.shared.items[indexPath.row]
        cell.updateCell(model: product)
        
        cell.onMinusTapped = { [weak self] in
            CartManager.shared.decreaseQuantity(at: indexPath.row)
            self?.reloadCartData()
        }
        
        cell.onPlusTapped = { [weak self] in
            CartManager.shared.increaseQuantity(at: indexPath.row)
            self?.reloadCartData()
        }
        
        return cell
        
    }
}
