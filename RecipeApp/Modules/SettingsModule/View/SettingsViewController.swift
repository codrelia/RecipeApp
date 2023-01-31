import UIKit

class SettingsViewController: UIViewController {

    // MARK: - Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
}

// MARK: - Private methods

private extension SettingsViewController {
    func configureView() {
        view.backgroundColor = customBackgroundColor
    }
}
