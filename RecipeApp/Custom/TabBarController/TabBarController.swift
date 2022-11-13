import UIKit

class TabBarController: UITabBarController {
    
    // MARK: - Routers
    
    var mainRouter: MainModuleRouter = MainModuleRouter()
    var favoriteRouter: FavoriteModuleRouter = FavoriteModuleRouter()
    
    // MARK: - Constants
    
    private enum Constants {
        static let tabBarWidth = UIScreen.main.bounds.width
        static let currentTabBarHeight: Double = {
            let height = UIScreen.main.bounds.height
            if height <= 700 {
                return UIScreen.main.bounds.height * 0.1
            } else {
                return UIScreen.main.bounds.height * 0.11
            }
        }()
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
        
        tabBar.frame.size.height = Constants.currentTabBarHeight
        tabBar.frame.origin.y = view.frame.height - Constants.currentTabBarHeight / 1.1
        tabBar.addSubview(indicator)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        indicator.center.x = tabBar.subviews[1].center.x
        indicator.center.y = 0
    }
    
}

// MARK: - Private methods

private extension TabBarController {
    
    func configureTabBar() {
        delegate = self
        
        viewControllers = [
            generateViewController(
                viewController: mainRouter.view!,
                title: nil,
                image: mainIconImages),
            generateViewController(
                viewController: favoriteRouter.view!,
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
        
        let path = UIBezierPath(roundedRect:CGRect(x: 0, y: 0, width: Constants.tabBarWidth, height: Constants.currentTabBarHeight),
                                byRoundingCorners:[.topRight, .topLeft],
                                cornerRadii: CGSize(width: 30, height:  30))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        tabBar.layer.mask = maskLayer
        
        tabBar.barTintColor = mainColor
    }
    
    func generateViewController(viewController: UIViewController, title: String?, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return UINavigationController(rootViewController: viewController)
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
        let timeInterval: TimeInterval = 0.2
        let propertyAnimator = UIViewPropertyAnimator(duration: timeInterval, dampingRatio: 0.9) {
            view.transform = CGAffineTransform.identity.scaledBy(x: 0.7, y: 0.7)
        }
        propertyAnimator.addAnimations({ view.transform = .identity }, delayFactor: CGFloat(timeInterval))
        propertyAnimator.startAnimation()

    }
}

// MARK: - UITabBarControllerDelegate

extension TabBarController: UITabBarControllerDelegate {
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        changePositionOfInducator(item)
        
        var view: UIView? = nil
        
        for i in tabBar.subviews {
            if i == item.value(forKey: "view") as? UIView {
                view = i
                break;
            }
        }
        
        guard let view = view else {
            return
        }
        
        animationOfTabBarButton(view)
        
        
    }
    
}
