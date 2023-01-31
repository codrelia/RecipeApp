import Foundation
import UIKit

protocol SearchModuleInteractorInput: AnyObject {
    func getRequestSearch(completion: @escaping (Result<SearchModuleEntity.Recipes?, Error>) -> ())
    func countOfRecipes(searchText: String) -> Int?
    func getGeneralInfoInData(id: Int) -> (Data?, UIImage?)
}
