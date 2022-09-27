import Foundation

class MainModulePresenter {
    // MARK: - VIPERs elements
    
    var interactorInput: MainModuleInteractorInput?
    var view: MainViewController?
    weak var viewInput: MainViewInput?
    
    // MARK: - Initialization
    
    init(view: MainViewController) {
        self.interactorInput = MainModuleInteractor(interactorOutput: self)
        self.view = view
        self.viewInput = view
        
        self.view?.setOutput(mainViewOutput: self)
    }
    
}

// MARK: - MainModuleInteractorOutput

extension MainModulePresenter: MainModuleInteractorOutput {
    func changingData() {
        viewInput?.reloadData()
    }
}

// MARK: - MainViewOutput

extension MainModulePresenter: MainViewOutput {
    func getPopularData() -> Recipes? {
        var results: Recipes?
        if interactorInput?.getCountOfPopularRecipes() == 0 {
            interactorInput?.getRequestPopularRecipes(completion: { recipes, error in
                results = recipes
            })
        } else {
            return nil
        }
        return results
    }
    
    func getPopularData(_ row: Int) -> Item? {
        guard let result = interactorInput?.getPopularData() else {
            return nil
        }
        return result.items[row]
    }
    
    
    func getCountPopular() -> Int {
        return interactorInput!.getCountOfPopularRecipes()
    }
}
