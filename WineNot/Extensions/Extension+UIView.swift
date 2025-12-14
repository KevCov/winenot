//
//  Extension+UIView.swift
//  WineNot
//
//  Created by Kevin Cordova Aquije on 14/12/25.
//
import UIKit

extension UIView {
    func rounded(radius: Double){
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    func setBackgroundColor(color: UIColor){
        self.backgroundColor = color
    }
    
    func setBorder(width: Double, color: UIColor) {
        self.layer.borderWidth = CGFloat(width)
        self.layer.borderColor = color.cgColor
    }
    
    func setShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.25
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = self.layer.cornerRadius
    }
}
