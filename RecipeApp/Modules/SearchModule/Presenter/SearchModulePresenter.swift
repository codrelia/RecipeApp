import Foundation

class SearchModulePresenter {
    // MARK: - VIPERs elements
    var interactorInput: SearchModuleInteractorInput?
    weak var viewInput: SearchModuleViewInput?
    weak var routerInput: SearchModuleRouterInput?
    
    
    // MARK: - Initialization
    
    init() {
        self.interactorInput = SearchModuleInteractor(interactorOutput: self)
    }
    
    // MARK: - Methods
    func setRouterInput(_ routerInput: SearchModuleRouterInput) {
        self.routerInput = routerInput
    }
    
    func setViewInput(_ viewInput: SearchModuleViewInput) {
        self.viewInput = viewInput
        self.viewInput?.setOutput(viewOutput: self)
    }
    
}

// MARK: - SearchModuleViewOutput

extension SearchModulePresenter: SearchModuleViewOutput {
    func tapOnBackButton() {
        routerInput?.tapOnBackButton()
    }
}

// MARK: - SearchModuleInteractorOutput

extension SearchModulePresenter: SearchModuleInteractorOutput {
    
}
