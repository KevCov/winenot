import UIKit

class StoreHeaderView: UICollectionReusableView {
    static let identifier = "StoreHeaderView"
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var headerTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setBackgroundColor(color: .appBackground)
        headerTitle.configure(text: "Bienvenido a WineNot", color: .appTextPrimary, size: FontSize.title, weight: .bold)
        bannerImage.setContenMode()
        bannerImage.setRoundCorners(radius: 10)
        bannerImage.setImageName(name: "banner")
    }
    
}
