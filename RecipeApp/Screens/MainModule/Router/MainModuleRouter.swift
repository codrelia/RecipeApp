import Foundation

class MainModuleRouter {
    var view: MainViewController?
    var presenter: MainModulePresenter?
    
    init() {
        self.view = MainViewController()
        self.presenter = MainModulePresenter(view: view!)
    }
}
