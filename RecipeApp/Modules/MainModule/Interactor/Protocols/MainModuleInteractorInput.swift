import Foundation
import UIKit

protocol MainModuleInteractorInput: AnyObject {
    func getRequestPopularRecipes(completion: @escaping (MainModuleEntity.Recipes?, Error?) -> ())
    func getCountOfPopularRecipes() -> Int
    func getPopularData() -> MainModuleEntity.Recipes?
    func getGeneralInfoInData(id: Int) -> (Data?, UIImage?)
}
