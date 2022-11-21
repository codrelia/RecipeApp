import Foundation
import UIKit

@objc protocol AnimationSearchProtocol {
    var view: UIView! { get set }
    
    func buttonToAnimate() -> [UIView]
    
    func copyButton(_ subView: UIView) -> UIView
    
    @objc optional func frameForView(_ subView: UIView) -> CGRect
}
