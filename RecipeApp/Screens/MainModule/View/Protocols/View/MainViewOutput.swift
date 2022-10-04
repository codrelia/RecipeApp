import Foundation
import UIKit

protocol MainViewOutput: AnyObject {
    func getPopularData() -> Recipes?
    func getPopularData(_ row: Int) -> Item?
    
    func getCountPopular() -> Int
    
    func getActionsWithRecipe(_ id: Int)
    func getFavoritesRecipes() -> [Int]
}
