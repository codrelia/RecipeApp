import Foundation

protocol PreparationOutput: AnyObject {
    func getRequest() -> DetailModulePreparationEntity.Item?
    func getCount() -> Int
}
