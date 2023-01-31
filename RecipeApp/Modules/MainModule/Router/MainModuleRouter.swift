import Foundation
import UIKit

class MainModuleRouter {
    var view: MainViewController?
    var presenter: MainModulePresenter?
    var detailRouter: DetailModuleRouter?
    var searchRouter: SearchModuleRouter?
    var loginRouter: LoginModuleRouter?
    
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
        detailRouter = DetailModuleRouter(data: (data.0!, data.1!))
        guard let detailRouter = detailRouter else { return }
        self.view?.navigationController?.pushViewController(detailRouter.view!, animated: true)
        
    }
    
    func pushSearchScreen() {
        searchRouter = SearchModuleRouter()
        guard let searchRouter = searchRouter else { return }
        self.view?.navigationController?.pushViewController(searchRouter.view!, animated: true)
    }
    
    func pushProfileScreen() {
        loginRouter = LoginModuleRouter()
        guard let loginRouter = loginRouter else { return }
        self.view?.navigationController?.pushViewController(loginRouter.view!, animated: true)
    }
}
