import UIKit

extension UIImageView {
    func setImage(name: String) {
        guard let url = URL(string: name) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("Error descargando imagen: \(error.localizedDescription)")
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                print("No se pudo convertir data a imagen")
                return
            }
            
            DispatchQueue.main.async {
                self?.image = image
            }
        }.resume()
    }
}
