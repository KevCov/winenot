//
//  ProductCartCell.swift
//  WineNot
//
//  Created by Kevin Cordova Aquije on 14/12/25.
//

import UIKit

class ProductCartCell: UITableViewCell {
    static let identifier = "ProductCartCell"
    @IBOutlet weak var productCartName: UILabel!
    @IBOutlet weak var productCartPrice: UILabel!
    @IBOutlet weak var productCartQuantity: UILabel!
    @IBOutlet weak var productCartImage: UIImageView!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    var onPlusTapped: (() -> Void)?
    var onMinusTapped: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateCell(model: ProductCartCellModel) {
        productCartImage.setImage(name: model.urlImage)
        productCartName.configure(text: model.name, color: .black, size: 14, weight: .bold)
        let price = String(format: "%.2f", model.unitPrice)
        productCartPrice.configure(text: "S/. \(price)", color: .black, size: 14, weight: .bold)
        productCartQuantity.configure(text: "\(model.quantity)", color: .black, size: 12)
    }
    
    @IBAction func addQuantity(_ sender: Any) {
        onPlusTapped?()
    }
    
    @IBAction func minusQuantity(_ sender: Any) {
        onMinusTapped?()
    }
}
