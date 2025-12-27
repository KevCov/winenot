import UIKit

class ProfileController: UIViewController {
    
    @IBOutlet weak var loginImage: UIImageView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginTitle: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginTitle.configure(text: "Inicia Sesión", color: .appBackground, size: 28, weight: .bold)
        loginImage.setImageName(name: "login-image")
        emailField.setPlaceholder(text: "Ingrese su correo electrónico")
        passwordField.setPlaceholder(text: "Ingrese su clave secreta")
        passwordField.asPassword()
        loginButton.setText(text: "Iniciar Sesión", color: .appTextPrimary, size: 16, weight: .bold)
        loginButton.setBackgroundColor(color: .appBackground)
        loginImage.setRoundCorners(radius: 10)
        
        if UserSession.shared.isLoggedIn {
            showUserProfileView()
        }
        
        setupHideKeyboardOnTap()
    }
    
    @IBAction func checkCredentials(_ sender: Any) {
        let email = emailField.text ?? ""
        let pass = passwordField.text ?? ""
        loginButton.isEnabled = false
        
        UserSession.shared.login(email: email, pass: pass) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.loginButton.isEnabled = true
                
                switch result {
                case .success:
                    self.showUserProfileView()
                    
                case .failure(let error):
                    print("Error login: \(error.localizedDescription)")
                    let alert = UIAlertController(title: "Error", message: "Credenciales incorrectas o error de red", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    func showUserProfileView() {
        let profileVC = UserProfileViewController(nibName: "UserProfileViewController", bundle: nil)
        profileVC.user = UserSession.shared.currentUser
        
        profileVC.onLogout = { [weak self] in
            self?.removeChildVC(profileVC)
        }
        
        addChild(profileVC)
        view.addSubview(profileVC.view)
        
        profileVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileVC.view.topAnchor.constraint(equalTo: view.topAnchor),
            profileVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            profileVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        profileVC.didMove(toParent: self)
    }
    
    func removeChildVC(_ child: UIViewController) {
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
    
    private func setupHideKeyboardOnTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
