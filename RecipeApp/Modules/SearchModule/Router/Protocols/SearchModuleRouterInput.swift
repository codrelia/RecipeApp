import Foundation
import UIKit

protocol SearchModuleRouterInput: AnyObject {
    func tapOnBackButton()
    func pushDetailScreen(data: (Data?, UIImage?))
}
