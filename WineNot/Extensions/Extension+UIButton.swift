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
    
    func setRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}
