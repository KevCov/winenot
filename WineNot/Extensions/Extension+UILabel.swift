import UIKit

extension UILabel {
    func configure(text: String, color: UIColor, size: CGFloat, weight: UIFont.Weight = .regular) {
        self.text = text
        self.textColor = color
        self.font = UIFont.systemFont(ofSize: size, weight: weight)
    }
}
