import Foundation

class FavoriteModuleRouter {
    var view: FavoriteViewController?
    var presenter: FavoriteModulePresenter?
    
    init() {
        self.view = FavoriteViewController()
        self.presenter = FavoriteModulePresenter(view: view!)
    }
}
