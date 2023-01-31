import Foundation
import UIKit

class SearchModuleRouter {
    var view: SearchModuleViewController?
    var presenter: SearchModulePresenter?
    var detailRouter: DetailModuleRouter?
    
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
    
    func pushDetailScreen(data: (Data?, UIImage?)) {
        guard data.0 != nil && data.1 != nil else {
            return
        }
        detailRouter = DetailModuleRouter(data: (data.0!, data.1!))
        guard let detailRouter = detailRouter else { return }
        self.view?.navigationController?.pushViewController(detailRouter.view!, animated: true)
    }
}
