//
//  Extension+UIField.swift
//  WineNot
//
//  Created by Kevin Cordova Aquije on 20/12/25.
//
import UIKit

extension UITextField {
    func setPlaceholder(text: String, color: UIColor = .lightGray) {
        self.attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [NSAttributedString.Key.foregroundColor: color]
        )
    }
    
    func asPassword() {
        self.isSecureTextEntry = true
        self.autocapitalizationType = .none
        self.autocorrectionType = .no
        self.smartDashesType = .no
        self.smartInsertDeleteType = .no
        self.textContentType = .password
    }
}
