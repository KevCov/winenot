import UIKit

class CartController: UIViewController {
    
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var subtotalAmount: UILabel!
    @IBOutlet weak var igvLabel: UILabel!
    @IBOutlet weak var igvAmount: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var generateOrderButton: UIButton!
    @IBOutlet weak var productCartTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundColor(color: .appBackground)
        
        subtotalLabel.configure(text: "Subtotal", color: .appTextPrimary, size: FontSize.medium, weight: .bold)
        igvLabel.configure(text: "Impuesto", color: .appTextPrimary, size: FontSize.medium, weight: .bold)
        totalLabel.configure(text: "A Pagar", color: .appTextPrimary, size: FontSize.medium, weight: .bold)
        
        generateOrderButton.setText(text: "Generar Orden", color: .appBackground, size: FontSize.regular, weight: .bold)
        generateOrderButton.setBackgroundColor(color: .appTextPrimary)
        generateOrderButton.setRadius(radius: 10)
        
        productCartTableView.setDelegate(vc: self)
        productCartTableView.setBackgroundColor(color: .clear)
        productCartTableView.setCell(uinibName: ProductCartCell.identifier, cellIdentifier: ProductCartCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        productCartTableView.reloadData()
        updateTotals()
    }
    
    private func reloadCartData() {
        productCartTableView.reloadData()
        updateTotals()
    }
    
    private func updateTotals() {
        let total = CartManager.shared.getTotal()
        let subtotal = total / 1.18
        let igv = total - subtotal
        
        subtotalAmount.configure(text: String(format: "S/. %.2f", subtotal), color: .appTextPrimary, size: FontSize.medium)
        igvAmount.configure(text: String(format: "S/. %.2f", igv), color: .appTextPrimary, size: FontSize.medium)
        totalAmount.configure(text: String(format: "S/. %.2f", total), color: .appTextPrimary, size: FontSize.medium)
    }
    
    @IBAction func sendOrder(_ sender: Any) {
        if CartManager.shared.items.isEmpty {
            self.showWarningAlert(message: "Tu carrito está vacío. Agrega algunos vinos antes de generar una orden.") { [weak self] in
                self?.tabBarController?.selectedIndex = 0
            }
            return
        }
        
        guard let _ = UserManager.shared.currentUser else {
            self.showWarningAlert(message: "Debes iniciar sesión para poder completar tu compra.") { [weak self] in
                self?.tabBarController?.selectedIndex = 1
            }
            return
        }
        
        generateOrderButton.isEnabled = false
        generateOrderButton.setTitle("Procesando...", for: .normal)
        
        CartManager.shared.checkout { [weak self] result in
            DispatchQueue.main.async {
                self?.generateOrderButton.isEnabled = true
                self?.generateOrderButton.setTitle("Generar Orden", for: .normal)
                
                switch result {
                case .success:
                    self?.showSuccessMessage(message: "Tu orden ha sido generada correctamente.") {
                        self?.tabBarController?.selectedIndex = 0
                    }
                case .failure(let error):
                    self?.showErrorMessage(message: "Algo salio mal al generar tu orden. Intenta nuevamente.")
                }
            }
        }
    }
}

extension CartController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CartManager.shared.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductCartCell.identifier, for: indexPath) as? ProductCartCell else {
            return UITableViewCell()
        }
        
        let product = CartManager.shared.items[indexPath.row]
        cell.updateCell(model: product)
        
        cell.onMinusTapped = { [weak self] in
            CartManager.shared.decreaseQuantity(at: indexPath.row)
            self?.reloadCartData()
        }
        
        cell.onPlusTapped = { [weak self] in
            CartManager.shared.increaseQuantity(at: indexPath.row)
            self?.reloadCartData()
        }
        
        return cell
    }
}
