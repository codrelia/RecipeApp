import Foundation

class SearchModulePresenter: UserDefaultsService {
    // MARK: - VIPERs elements
    var interactorInput: SearchModuleInteractorInput?
    weak var viewInput: SearchModuleViewInput?
    weak var routerInput: SearchModuleRouterInput?
    
    
    // MARK: - Initialization
    
    override init() {
        super.init()
        self.interactorInput = SearchModuleInteractor(interactorOutput: self)
    }
    
    // MARK: - Methods
    func setRouterInput(_ routerInput: SearchModuleRouterInput) {
        self.routerInput = routerInput
    }
    
    func setViewInput(_ viewInput: SearchModuleViewInput) {
        self.viewInput = viewInput
        self.viewInput?.setOutput(viewOutput: self)
    }
    
}

// MARK: - SearchModuleViewOutput

extension SearchModulePresenter: SearchModuleViewOutput {
    
    func countOfRecipes(searchText: String) -> Int? {
        guard let interactorInput = interactorInput else {
            return nil
        }
        guard let count = interactorInput.countOfRecipes(searchText: searchText) else {
            return nil
        }
        return count
    }
    
    func tapOnBackButton() {
        routerInput?.tapOnBackButton()
    }
    
    func getRequestSearch() -> SearchModuleEntity.Recipes? {
        var resultRecipes: SearchModuleEntity.Recipes?
        interactorInput?.getRequestSearch(completion: { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let recipes):
                resultRecipes = recipes
            case .failure(_):
                self.viewInput?.showErrorMessage()
            }
        })
        return resultRecipes
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

// MARK: - SearchModuleInteractorOutput

extension SearchModulePresenter: SearchModuleInteractorOutput {
    func reloadTable() {
        viewInput?.reloadData()
    }
}
