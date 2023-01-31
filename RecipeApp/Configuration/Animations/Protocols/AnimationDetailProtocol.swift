import Foundation
import UIKit

@objc protocol AnimationDetailProtocol {
    var view: UIView! { get set }
    
    func viewsToAnimate() -> [UIView]
    
    func copyForView(_ subView: UIView) -> UIView
    
    func takeViewsHigher() -> [[UIView]]
    
    func takeViewsBelow() -> [[UIView]]
    
    func copyAnotherView(_ subView: UIView) -> UIView
    
    @objc optional func frameForView(_ subView: UIView) -> CGRect
}
