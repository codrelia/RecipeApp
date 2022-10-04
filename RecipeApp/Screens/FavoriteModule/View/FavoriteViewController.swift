import UIKit

class FavoriteViewController: UIViewController {
    
    // MARK: - UIViews
    
    @IBOutlet private weak var tableView: UITableView!
    
    weak var viewOutput: FavoriteViewOutput?

    // MARK: - Lyfecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureTable()
    }
    
    func setOutput(viewOutput: FavoriteViewOutput) {
        self.viewOutput = viewOutput
    }
}

// MARK: - Private methods

private extension FavoriteViewController {
    func configureView() {
        view.backgroundColor = customBackgroundColor
    }
    
    func configureTable() {
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "\(NavigationTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(NavigationTableViewCell.self)")
        
        tableView.separatorStyle = .none
    }
}

// MARK: - FavoriteViewInput

extension FavoriteViewController: FavoriteViewInput {
    
}

// MARK: - UITableViewDataSourse, UITableViewDelegate

extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(NavigationTableViewCell.self)", for: indexPath)
        guard let cell = cell as? NavigationTableViewCell else {
            return UITableViewCell()
        }
        cell.title = "Избранное"
        cell.isButtons = true
        return cell
    }
    
    
    
    
}
