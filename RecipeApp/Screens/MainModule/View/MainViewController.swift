import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let sizeOfButtonsOnNavigationBar = 34.0
        static let additionHeightForNavigationBar = 100.0
        static let marginEdges = 28.0
    }
    
    // MARK: - Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureNavigationBar()
         
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

// MARK: - Private methods

private extension MainViewController {
    func configureView() {
        view.backgroundColor = backgroundColor
    }
    
    func configureNavigationBar() {
        guard var frame = navigationController?.navigationBar.frame else {
            return
        }
        
        frame.size = CGSize(width: frame.width, height: frame.height + Constants.additionHeightForNavigationBar)
        navigationController?.setValue(NavigationBar(frame: frame), forKey: "navigationBar")
        
        guard let navigationBar = navigationController?.navigationBar as? NavigationBar else {
            return
        }
        
        navigationBar.setupMainTitle("Популярные\nрецепты", CGPoint(x: Constants.marginEdges, y: 0))
        
        let frameOfButton = CGRect(x: navigationBar.frame.midX, y: navigationBar.frame.midY, width: Constants.sizeOfButtonsOnNavigationBar, height: Constants.sizeOfButtonsOnNavigationBar)
        
        navigationBar.setupButtons(frameOfButton, Constants.marginEdges)
    }
}
