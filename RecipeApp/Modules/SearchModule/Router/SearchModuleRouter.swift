import Foundation

class SearchModuleRouter {
    var view: SearchModuleViewController?
    var presenter: SearchModulePresenter?
    
    // MARK: - Initialization
    
    init() {
        self.view = SearchModuleViewController()
        self.presenter = SearchModulePresenter()
        self.presenter?.setRouterInput(self)
        self.presenter?.setViewInput(view!)
    }
}

// MARK: - SearchModuleRouterInput

extension SearchModuleRouter: SearchModuleRouterInput {
    func tapOnBackButton() {
        view!.navigationController?.popViewController(animated: true)
    }
}
