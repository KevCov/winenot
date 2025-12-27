import UIKit

class UserProfileViewController: UIViewController {
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var dniLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var dniValue: UILabel!
    @IBOutlet weak var emailValue: UILabel!
    @IBOutlet weak var phoneNumberValue: UILabel!
    @IBOutlet weak var addressValue: UILabel!
    @IBOutlet weak var viewContainerInfo: UIStackView!
    @IBOutlet weak var orderTableView: UITableView!
    private let service = OrderService()
    var orders: [OrderCellModel] = []
    var user: CustomerResponse?
    var onLogout: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundColor(color: .appBackground)
        viewContainerInfo.setBackgroundColor(color: .clear)
        
        orderTableView.setDelegate(vc: self)
        orderTableView.setCell(uinibName: OrderCell.identifier, cellIdentifier: OrderCell.identifier)
        orderTableView.setBackgroundColor(color: .clear)
        
        let fullname = "\(user?.firstName ?? "Usuario") \(user?.lastName ?? "Anonimo")"
        fullNameLabel.configure(text: fullname, color: .appTextPrimary, size: 15, weight: .bold)
        
        dniLabel.configure(text: "DNI", color: .appTextPrimary, size: 14, weight: .bold)
        dniValue.configure(text: user?.dni ?? "N/A", color: .appTextPrimary, size: 13, weight: .bold)
        
        emailLabel.configure(text: "Correo Electrónico", color: .appTextPrimary, size: 14, weight: .bold)
        emailValue.configure(text: user?.email ?? "N/A", color: .appTextPrimary, size: 13, weight: .bold)
        
        phoneNumberLabel.configure(text: "Celular", color: .appTextPrimary, size: 14, weight: .bold)
        phoneNumberValue.configure(text: user?.phoneNumber ?? "N/A", color: .appTextPrimary, size: 13, weight: .bold)
        
        let addressComplete = "\(user?.address.district ?? "N/A") - \(user?.address.street ?? "N/A"), \(user?.address.houseNumber.description ?? "N/A")"
        
        addressLabel.configure(text: "Dirección", color: .appTextPrimary, size: 14, weight: .bold)
        addressValue.configure(text: addressComplete, color: .appTextPrimary, size: 13, weight: .bold)
        
        logoutButton.setText(text: "Cerrar Sesión", color: .appBackground, size: 16, weight: .bold)
        logoutButton.setBackgroundColor(color: .appTextPrimary)
        loadOrders(customerId: user?.id ?? "0")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadOrders(customerId: user?.id ?? "0")
    }
    
    @IBAction func logoutProfile(_ sender: Any) {
        UserSession.shared.logout()
        onLogout?()
    }
    
    func loadOrders(customerId: String) {
        service.getOrders(id: customerId) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let viewModels):
                    self.orders = viewModels
                    self.orderTableView.reloadData()
                case .failure(let error):
                    self.showErrorMessage(message: error.localizedDescription)
                }
            }
        }
    }
}

extension UserProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OrderCell.identifier, for: indexPath) as? OrderCell else {
            return UITableViewCell()
        }
        
        let order = orders[indexPath.row]
        cell.updateCell(model: order)
        
        return cell
    }
}
