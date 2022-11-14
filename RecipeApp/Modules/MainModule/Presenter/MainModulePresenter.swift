import Foundation

class MainModulePresenter: UserDefaultsService {
    // MARK: - VIPERs elements
    
    var interactorInput: MainModuleInteractorInput?
    var view: MainViewController?
    weak var viewInput: MainViewInput?
    weak var routerInput: MainModuleRouterInput?
    
    
    // MARK: - Initialization
    
    init(view: MainViewController) {
        super.init()
        
        self.interactorInput = MainModuleInteractor(interactorOutput: self)
        self.view = view
        self.viewInput = view
        
        self.view?.setOutput(mainViewOutput: self)
    }
    
    func setRouter(_ routerInput: MainModuleRouterInput) {
        self.routerInput = routerInput
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
    func getPopularData() -> MainModuleEntity.Recipes? {
        var results: MainModuleEntity.Recipes?
        if interactorInput?.getCountOfPopularRecipes() == 0 {
            interactorInput?.getRequestPopularRecipes(completion: { [weak self] recipes, error in
                guard let self = self else {
                    return
                }
                results = recipes
                if error != nil {
                    DispatchQueue.main.async {
                        self.viewInput!.showErrorMessage()
                    }
                }
            })
        } else {
            return nil
        }
        return results
    }
    
    func getPopularData(_ row: Int) -> MainModuleEntity.Item? {
        guard let result = interactorInput?.getPopularData() else {
            return nil
        }
        return result.items[row]
    }
    
    
    func getCountPopular() -> Int {
        return interactorInput!.getCountOfPopularRecipes()
    }
    
    func getActionsWithRecipe(_ id: Int) {
        if isInUserDefaults(id) {
            deleteRecipeInUserDefaults(id)
        } else {
            addRecipeInUserDefaults(id)
        }
    }
    
    func getFavoritesRecipes() -> [Int] {
        reloadData()
        return favoritesRecipes
    }
    
    func pushDetailScreen(id: Int) {
        guard let result = interactorInput?.getGeneralInfoInData(id: id) else {
            return
        }
        guard result.0 != nil else {
            return
        }
        routerInput?.pushDetailScreen(data: result)
    }
}
