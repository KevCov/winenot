//
//  Extension+UIButton.swift
//  WineNot
//
//  Created by Kevin Cordova Aquije on 7/12/25.
//

import UIKit

extension UIButton {
    func setText(text: String, color: UIColor, size: CGFloat, weight: UIFont.Weight) {
        self.setTitle(text, for: .normal)
        self.setTitleColor(color, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: size, weight: weight)
    }
    
    func setBorder(color: UIColor, width: CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    
    func setBackgroundColor(color: UIColor) {
        self.backgroundColor = color
    }
    
    func setRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}
