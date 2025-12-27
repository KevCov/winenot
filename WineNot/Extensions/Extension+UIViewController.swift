import UIKit

extension UIViewController {
    func showErrorMessage(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    func showWarningAlert(message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: "Atención", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Entendido", style: .default) { _ in
            completion?()
        }
        
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func showSuccessMessage(title: String = "¡Éxito!", message: String, buttonText: String = "Genial", completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonText, style: .default) { _ in
            completion?()
        }
        
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}
