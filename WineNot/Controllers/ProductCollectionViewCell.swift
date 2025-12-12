//
//  ProductCollectionViewCell.swift
//  WineNot
//
//  Created by Kevin Cordova Aquije on 9/12/25.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCellStyle()
        addButton.setText(text: "Agregar", color: .white, size: 12, weight: .bold)
        addButton.setBackgroundColor(color: .blue)
        addButton.setRadius(radius: 10)
    }
    
    func setupCellStyle() {
        self.layer.cornerRadius = 12
        self.backgroundColor = .white
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.1
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 4
        
        self.layer.masksToBounds = false
    }
    
    func updateCell(model: ProductCellViewModel) {
        productImageView.setImage(name: model.imageName)
        productNameLabel.configure(text: model.name, color: .black, size: 14, weight: .bold)
        productDescriptionLabel.configure(text: model.description, color: .black, size: 12)
        productPriceLabel.configure(text: "S/. \(model.price)", color: .black, size: 14, weight: .bold)
    }
}

struct ProductCellViewModel {
    let name: String
    let price: String
    let description: String
    let imageName: String
}
