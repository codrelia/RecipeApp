import Foundation

class LoginModuleRouter {
    var view: LoginModuleViewController?
    var presenter: LoginModulePresenter?
    
    // MARK: - Initialization
    
    init() {
        self.view = LoginModuleViewController()
        self.presenter = LoginModulePresenter()
        self.presenter?.setRouterInput(self)
        self.presenter?.setViewInput(view!)
    }
}

// MARK: - LoginModuleRouterInput

extension LoginModuleRouter: LoginModuleRouterInput {
    func tapOnBackButton() {
        view!.navigationController?.popViewController(animated: true)
    }
}
