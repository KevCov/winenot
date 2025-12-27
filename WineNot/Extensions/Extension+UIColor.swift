import UIKit

extension UIColor {
    static var appBackground: UIColor {
        return UIColor(named: "color-background") ?? .systemGreen
    }
    
    static var appTextPrimary: UIColor {
        return UIColor(named: "text-primary") ?? .white
    }
}
