import Foundation

protocol IngredientsOutput: AnyObject {
    func getRequest() -> DetailModuleProductsEntity.Item?
    func getCountOfCells() -> Int
}
