import Foundation
import UIKit

protocol DetailModuleInteractorInput: AnyObject {
    func getDetailInfo() -> DetailModuleEntity.Info?
    func setGeneralInfo(data: Data, image: UIImage)
    func getGeneralInfo() -> DetailModuleGeneralInfoEntity.Item?
    func getRequestDescriptionInfo(completion: @escaping (Result<DetailModuleDescriptionEntity.Item, Error>) -> ())
    func getRequestIngredientsInfo(completion: @escaping (Result<DetailModuleProductsEntity.Item, Error>) -> ())
    func getRequestPreparationInfo(completion: @escaping (Result<DetailModulePreparationEntity.Item, Error>) -> ())
}
