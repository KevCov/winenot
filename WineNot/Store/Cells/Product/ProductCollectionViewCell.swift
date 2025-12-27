import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    static let identifier = "ProductCollectionViewCell"
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    var onAddButtonTapped: (() -> Void)?
    private var currentProduct: ProductCellViewModel?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCellStyle()
        addButton.setText(text: "Agregar", color: .appTextPrimary, size: FontSize.small, weight: .bold)
        addButton.setBackgroundColor(color: .appBackground)
        addButton.setRadius(radius: 10)
    }
    
    @IBAction func didTapAddButton(_ sender: Any) {
        animateAddButtonEffect()
        onAddButtonTapped?()
    }
    
    func setupCellStyle() {
        self.setBackgroundColor(color: .white)
        self.rounded(radius: 12)
        self.setShadow()
    }
    
    func updateCell(model: ProductCellViewModel) {
        self.currentProduct = model
        productImageView.setImage(name: model.imageName)
        productNameLabel.configure(text: model.name, color: .black, size: FontSize.medium, weight: .bold)
        productDescriptionLabel.configure(text: model.description, color: .black, size: FontSize.small)
        productPriceLabel.configure(text: "S/. \(model.price)", color: .black, size: FontSize.medium, weight: .bold)
    }
    
    func animateAddButtonEffect() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        UIView.animate(withDuration: 0.1,
                       animations: {
            self.addButton.transform = CGAffineTransform(scaleX: 0.90, y: 0.90)
        }) { _ in
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 6.0,
                           options: .allowUserInteraction,
                           animations: {
                self.addButton.transform = .identity
            }, completion: nil)
        }
    }
}
