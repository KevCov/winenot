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
        
        subtotalLabel.configure(text: "Subtotal", color: .appTextPrimary, size: 14, weight: .bold)
        igvLabel.configure(text: "Impuesto", color: .appTextPrimary, size: 14, weight: .bold)
        totalLabel.configure(text: "A Pagar", color: .appTextPrimary, size: 14, weight: .bold)
        
        generateOrderButton.setText(text: "Generar Orden", color: .appBackground, size: 16, weight: .bold)
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
        
        subtotalAmount.configure(text: String(format: "S/. %.2f", subtotal), color: .appTextPrimary, size: 14)
        igvAmount.configure(text: String(format: "S/. %.2f", igv), color: .appTextPrimary, size: 14)
        totalAmount.configure(text: String(format: "S/. %.2f", total), color: .appTextPrimary, size: 14)
    }
    @IBAction func sendOrder(_ sender: Any) {
        if CartManager.shared.items.isEmpty {
            showWarningAlert(message: "Tu carrito está vacío. Agrega algunos vinos antes de generar una orden.")
            return
        }
        
        guard let _ = UserSession.shared.currentUser else {
            showWarningAlert(message: "Debes iniciar sesión para poder completar tu compra.")
            
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
                    let alert = UIAlertController(title: "¡Éxito!", message: "Tu orden ha sido generada correctamente.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Genial", style: .default, handler: { _ in
                        self?.tabBarController?.selectedIndex = 0 // Volver al inicio
                    }))
                    self?.present(alert, animated: true)
                    
                case .failure(let error):
                    // ERROR
                    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
                    self?.present(alert, animated: true)
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
