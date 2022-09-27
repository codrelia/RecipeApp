import Foundation
import UIKit

protocol PopularOutput: AnyObject {
    func getCountOfPopular() -> Int?
    func getCurrentPopularItem(_ row: Int) -> Item?
}