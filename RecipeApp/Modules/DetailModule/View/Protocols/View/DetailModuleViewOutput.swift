import Foundation

protocol DetailModuleViewOutput: AnyObject {
    func returnToBackScreen()
    func getRequestDescriptionInfo() -> DetailModuleDescriptionEntity.Item?
    func getRequestIngredientsInfo() -> DetailModuleProductsEntity.Item?
    func getRequestPreparationInfo() -> DetailModulePreparationEntity.Item?
    func getFullRecipe() -> DetailModuleEntity.Info?
    func getGeneralInfo() -> DetailModuleGeneralInfoEntity.Item?
    func getFavoritesRecipes() -> [Int]
    func actionsWithRecipe()
}
