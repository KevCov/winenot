//
//  Extension+UIViewController.swift
//  WineNot
//
//  Created by Kevin Cordova Aquije on 14/12/25.
//
import UIKit

extension UIViewController {
    func showErrorMessage(message: String) {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
}
