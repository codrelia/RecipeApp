import UIKit

class TabBarController: UITabBarController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let tabBarWidth = UIScreen.main.bounds.width
        static let tabBarHeight = UIScreen.main.bounds.height * 0.089
    }
    
    // MARK: - UIViews
    
    private let indicator: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.frame.size = CGSize(width: 40, height: 6)
        view.layer.cornerRadius = 3
        
        return view
    }()

    // MARK: - Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tabBar.frame.size.height = Constants.tabBarHeight
        tabBar.frame.origin.y = view.frame.height - Constants.tabBarHeight
        
        //tabBar.itemPositioning = .fill
        tabBar.addSubview(indicator)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        indicator.center.x = tabBar.subviews[1].center.x
        indicator.center.y = 0
        
        let buttons = tabBar.subviews.filter { String(describing: type(of: $0)) == "UITabBarButton" }
        buttons.forEach {
            if ($0.superview?.frame.height) != nil {
                $0.center = CGPoint(x: $0.frame.midX, y: Constants.tabBarHeight / 2.0)
            }
        }
    }
    
}

// MARK: - Private methods

private extension TabBarController {
    
    func configureTabBar() {
        delegate = self
        
        viewControllers = [
            generateViewController(
                viewController: MainViewController(),
                title: nil,
                image: mainIconImages),
            generateViewController(
                viewController: FavoriteViewController(),
                title: nil,
                image: favoriteIconImages),
            generateViewController(
                viewController: SettingsViewController(),
                title: nil,
                image: settingsIconImages)
        ]
        
        tabBar.backgroundColor = mainColor
        tabBar.unselectedItemTintColor = textColor
        tabBar.tintColor = .white
        
        let path = UIBezierPath(roundedRect:CGRect(x: 0, y: 0, width: Constants.tabBarWidth, height: Constants.tabBarHeight),
                                byRoundingCorners:[.topRight, .topLeft],
                                cornerRadii: CGSize(width: 30, height:  30))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        tabBar.layer.mask = maskLayer
    }
    
    func generateViewController(viewController: UIViewController, title: String?, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
    
    func changePositionOfInducator(_ item: UITabBarItem) {
        var viewOfButton: UIView? = nil
        for i in tabBar.subviews {
            if i == item.value(forKey: "view") as? UIView {
                viewOfButton = i
                break;
            }
        }
        guard let viewOfButton = viewOfButton else {
            return
        }
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseInOut]) {
            self.indicator.center.x = viewOfButton.center.x
        } completion: { _ in
            
        }
    }
    
    func animationOfTabBarButton(_ view: UIView) {
        UIView.animate(withDuration: 0.1, delay: 0.0, options: [.curveEaseInOut]) {
            view.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        } completion: { _ in
            UIView.animate(withDuration: 0.25, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 3.0, options: .curveEaseInOut, animations: {
                view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: {_ in
                
            })
        }

    }
}

// MARK: - UITabBarControllerDelegate

extension TabBarController: UITabBarControllerDelegate {
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        changePositionOfInducator(item)
        
    }
    
}
