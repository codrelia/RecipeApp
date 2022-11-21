import Foundation
import UIKit

protocol MainModuleRouterInput: AnyObject {
    func pushDetailScreen(data: (Data?, UIImage?))
    func pushSearchScreen()
}
