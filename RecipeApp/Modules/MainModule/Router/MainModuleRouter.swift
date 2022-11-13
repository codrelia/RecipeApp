import Foundation
import UIKit

class MainModuleRouter {
    var view: MainViewController?
    var presenter: MainModulePresenter?
    
    init() {
        self.view = MainViewController()
        self.presenter = MainModulePresenter(view: view!)
        self.presenter?.setRouter(self)
    }
}

// MARK: - MainModuleRouterInput

extension MainModuleRouter: MainModuleRouterInput {
    func pushDetailScreen(data: (Data?, UIImage?)) {
        guard data.0 != nil && data.1 != nil else {
            return
        }
        let router = DetailModuleRouter(data: (data.0!, data.1!))
        self.view?.navigationController?.pushViewController(router.view!, animated: true)
        
    }
}
