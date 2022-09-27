import UIKit

class FavoriteViewController: UIViewController {

    // MARK: - Lyfecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }

}

// MARK: - Private methods

private extension FavoriteViewController {
    func configureView() {
        view.backgroundColor = customBackgroundColor
    }
}
