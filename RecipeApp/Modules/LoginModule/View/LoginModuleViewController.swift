import UIKit

class LoginModuleViewController: UIViewController {
    // MARK: - UIViews
    
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var confirmPasswordTextField: UITextField!
    @IBOutlet private weak var confirmButton: UIButton!
    @IBOutlet private weak var forgotPasswordButton: UIButton!
    @IBOutlet private weak var changeFormButton: UIButton!
    @IBOutlet private weak var confirmPasswordLabel: UILabel!
    @IBOutlet private weak var heightConstraint: NSLayoutConstraint!
    // MARK: - VIPER's elements
    
    private weak var viewOutput: LoginModuleViewOutput?
    
    // MARK: - Properties
    
    private enum Mode {
        case Login
        case SignIn
    }
    
    private var currentMode: Mode = .Login

    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        makeAnEntrance()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - Actions
    
    
    @IBAction func changeSignInMode(_ sender: Any) {
        if currentMode == .Login {
            makeSignIn()
        } else {
            makeAnEntrance()
        }
    }
    
    @IBAction func tapSignInAccount(_ sender: Any) {
        
    }
    
    func setGradientBottom() {
        let colorTop =  UIColor(red: 0.58, green: 0.651, blue: 0.812, alpha: 1).cgColor
        let colorBottom = UIColor(red: 0.698, green: 0.902, blue: 0.902, alpha: 1).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = confirmButton.bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        confirmButton.layer.insertSublayer(gradientLayer, at:0)
        confirmButton.clipsToBounds = true
    }
    
    
}

// MARK: - Private methods

private extension LoginModuleViewController {
    func configureView() {
        confirmButton.layer.cornerRadius = 10.0
        changeFormButton.titleLabel?.font = .systemFont(ofSize: 12.0, weight: .regular)
        changeFormButton.setTitleColor(loginTextColor, for: .normal)
        forgotPasswordButton.setTitleColor(loginTextColor, for: .normal)
        setGradientBottom()
        
        forgotPasswordButton.isHidden = true
    }
    
    func makeAnEntrance() {
        UIView.transition(with: confirmPasswordTextField, duration: 0.4,
                          options: .transitionCrossDissolve,
                          animations: {
            self.confirmPasswordTextField.isHidden = true
        })
        UIView.transition(with: confirmPasswordLabel, duration: 0.4,
                          options: .transitionCrossDissolve,
                          animations: {
            self.confirmPasswordLabel.isHidden = true
        })
        UIView.transition(with: confirmButton, duration: 0.4,
                          options: .transitionCrossDissolve,
                          animations: {
            self.confirmButton.setTitle("Войти", for: .normal)
        })
        UIView.transition(with: changeFormButton, duration: 0.4,
                          options: .transitionCrossDissolve,
                          animations: {
            self.changeFormButton.setTitle("У Вас нет аккаунта?", for: .normal)
        })
        currentMode = .Login
        
    }
    
    func makeSignIn() {
        UIView.transition(with: confirmPasswordTextField, duration: 0.4,
                          options: .transitionCrossDissolve,
                          animations: {
            self.confirmPasswordTextField.isHidden = false
        })
        UIView.transition(with: confirmPasswordLabel, duration: 0.4,
                          options: .transitionCrossDissolve,
                          animations: {
            self.confirmPasswordLabel.isHidden = false
        })
        UIView.transition(with: confirmButton, duration: 0.4,
                          options: .transitionCrossDissolve,
                          animations: {
            self.confirmButton.setTitle("Зарегистрироваться", for: .normal)
        })
        UIView.transition(with: changeFormButton, duration: 0.4,
                          options: .transitionCrossDissolve,
                          animations: {
            self.changeFormButton.setTitle("У Вас уже есть аккаунт?", for: .normal)
        })
        currentMode = .SignIn
    }
}

// MARK: - LoginModuleViewInput

extension LoginModuleViewController: LoginModuleViewInput {
    func setOutput(viewOutput: LoginModuleViewOutput) {
        self.viewOutput = viewOutput
    }
}
