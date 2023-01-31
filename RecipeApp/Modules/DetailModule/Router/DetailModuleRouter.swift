import Foundation
import UIKit

class DetailModuleRouter {
    var view: DetailViewController?
    var presenter: DetailModulePresenter?
    
    init(data: (Data, UIImage)) {
        self.view = DetailViewController()
        self.presenter = DetailModulePresenter(datas: data)
        self.presenter?.setViewInput(view!)
        self.presenter?.setRouterInput(self)
    }
}

extension DetailModuleRouter: DetailRouterInput {
    func returnToBackScreen() {
        view!.navigationController?.popViewController(animated: true)
    }
}
