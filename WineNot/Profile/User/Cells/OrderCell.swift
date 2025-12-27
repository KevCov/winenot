import UIKit

class OrderCell: UITableViewCell {
    static let identifier = "OrderCell"
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var cantidad: UILabel!
    @IBOutlet weak var numberOrder: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.setBackgroundColor(color: .appBackground)
        viewContainer.setBackgroundColor(color: .white)
        viewContainer.rounded(radius: 10)
        viewContainer.setShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateCell(model: OrderCellModel) {
        totalAmount.configure(text: "Total: S/. \(model.total)", color: .black, size: FontSize.regular, weight: .bold)
        numberOrder.configure(text: "Orden N° \(model.numberOrder)", color: .black, size: FontSize.regular, weight: .bold)
        cantidad.configure(text: "Cant. \(model.quantity)", color: .black, size: FontSize.regular, weight: .bold)
    }
}
