import Foundation

protocol SearchModuleViewOutput: AnyObject {
    func tapOnBackButton()
    func getRequestSearch() -> SearchModuleEntity.Recipes?
    func countOfRecipes(searchText: String) -> Int?
    func getActionsWithRecipe(_ id: Int)
    func getFavoritesRecipes() -> [Int]
    func pushDetailScreen(id: Int)
}
