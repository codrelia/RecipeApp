import Foundation
import UIKit

protocol MainViewOutput: AnyObject {
    func getPopularData() -> MainModuleEntity.Recipes?
    func getPopularData(_ row: Int) -> MainModuleEntity.Item?
    
    func getCountPopular() -> Int
    
    func getActionsWithRecipe(_ id: Int)
    func getFavoritesRecipes() -> [Int]
    
    func pushDetailScreen(id: Int)
    func pushSearchScreen()
    func pushProfileScreen()
    
    func getReloadUserDefaults()
}
