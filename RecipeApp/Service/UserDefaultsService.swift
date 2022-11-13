import Foundation

class UserDefaultsService {
    // MARK: - Properties
    
    let defaults = UserDefaults.standard
    var favoritesRecipes: [Int]
    
    init() {
        let recipes = UserDefaultsService.getDataFromUserDefaults(UserDefaultsKeys.idRecipes.rawValue) as? [Int]
        favoritesRecipes = (recipes == nil ? [] : recipes!)
    }
    
    // MARK: - Methods
    
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
    
    static func getDataFromUserDefaults(_ key: String) -> Any? {
        return UserDefaults.standard.array(forKey: key)
    }
}
