import Foundation

final class LoginModulePresenter: UserDefaultsService {
    // MARK: - VIPERs elements
    var interactorInput: LoginModuleInteractorInput?
    weak var viewInput: LoginModuleViewInput?
    weak var routerInput: LoginModuleRouterInput?
    
    // MARK: - Initialization
    
    override init() {
        super.init()
        self.interactorInput = LoginModuleInteractor(interactorOutput: self)
    }
    
    // MARK: - Methods
    func setRouterInput(_ routerInput: LoginModuleRouterInput) {
        self.routerInput = routerInput
    }
    
    func setViewInput(_ viewInput: LoginModuleViewInput) {
        self.viewInput = viewInput
        self.viewInput?.setOutput(viewOutput: self)
    }
}

// MARK: - LoginModuleViewInput

extension LoginModulePresenter: LoginModuleViewOutput {
    
}

// MARK: - LoginModuleInteractorInput

extension LoginModulePresenter: LoginModuleInteractorOutput {
    
}
