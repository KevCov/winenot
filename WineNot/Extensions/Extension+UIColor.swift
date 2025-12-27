//
//  Extension+UIColor.swift
//  WineNot
//
//  Created by Kevin Cordova Aquije on 20/12/25.
//
import UIKit

extension UIColor {
    static var appBackground: UIColor {
        return UIColor(named: "color-background") ?? .systemGreen
    }
    
    static var appTextPrimary: UIColor {
        return UIColor(named: "text-primary") ?? .white
    }
}
