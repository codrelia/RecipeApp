import Foundation

protocol MainModuleInteractorInput: AnyObject {
    func getRequestPopularRecipes(completion: @escaping (Recipes?, Error?) -> ())
    func getCountOfPopularRecipes() -> Int
    func getPopularData() -> Recipes?
}
