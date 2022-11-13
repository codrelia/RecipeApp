import Foundation

class FavoriteModulePresenter {
    //var interactorInput: MainModuleInteractorInput?
    var view: FavoriteViewController?
    weak var viewInput: FavoriteViewInput?
    
    init(view: FavoriteViewController) {
        self.view = view
        self.viewInput = view
        
        self.view?.setOutput(viewOutput: self)
    }
}

// MARK: - FavoriteViewOutput

extension FavoriteModulePresenter: FavoriteViewOutput {
    
}
