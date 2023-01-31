import Foundation
import UIKit

protocol PopularOutput: AnyObject {
    func getCountOfPopular() -> Int?
    func getCurrentPopularItem(_ row: Int) -> MainModuleEntity.Item?
    func getActionWithRecipe(_ id: Int)
    func getFavoriteRecipes() -> [Int]
    func pushDetailScreen(id: Int)
}
