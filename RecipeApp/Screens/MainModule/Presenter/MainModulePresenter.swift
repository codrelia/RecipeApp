import Foundation

class MainModulePresenter {
    // MARK: - VIPERs elements
    
    var interactorInput: MainModuleInteractorInput?
    var view: MainViewController?
    weak var viewInput: MainViewInput?
    
    // MARK: - Properties
    
    let defaults = UserDefaults.standard
    
    private var favoritesRecipes = [Int]()
    
    // MARK: - Initialization
    
    init(view: MainViewController) {
        self.interactorInput = MainModuleInteractor(interactorOutput: self)
        self.view = view
        self.viewInput = view
        
        self.view?.setOutput(mainViewOutput: self)
        
        let recipes = getDataFromUserDefaults(UserDefaultsKeys.idRecipes.rawValue) as? [Int]
        favoritesRecipes = (recipes == nil ? [] : recipes!)
    }
    
}

// MARK: - Private methods

private extension MainModulePresenter {
    
    func isInUserDefaults (_ id: Int) -> Bool {
        guard let recipes = defaults.array(forKey: UserDefaultsKeys.idRecipes.rawValue) as? [Int] else {
            return false
        }
        if !recipes.contains(id) {
            return false
        }
        return true
    }
    
    func addRecipeInUserDefaults(_ id: Int) {
        favoritesRecipes.append(id)
        defaults.set(favoritesRecipes, forKey: UserDefaultsKeys.idRecipes.rawValue)
    }
    
    func deleteRecipeInUserDefaults(_ id: Int) {
        for i in 0..<favoritesRecipes.count {
            if favoritesRecipes[i] == id {
                favoritesRecipes.remove(at: i)
                break
            }
        }
        defaults.set(favoritesRecipes == [] ? nil : favoritesRecipes, forKey: UserDefaultsKeys.idRecipes.rawValue)
    }
    
    func getDataFromUserDefaults(_ key: String) -> Any? {
        return defaults.array(forKey: key)
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
    
    func getPopularData(_ row: Int) -> Item? {
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
        return favoritesRecipes
    }
}
