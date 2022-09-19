import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
}

// MARK: - Private methods

private extension MainViewController {
    func configureView() {
        view.backgroundColor = backgroundColor
    }
}

