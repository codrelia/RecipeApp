import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let sizeOfButtonsOnNavigationBar = 34.0
        static let additionHeightForNavigationBar = 100.0
        static let marginEdges = 28.0
    }
    
    // MARK: - UIViews
    
    @IBOutlet weak var tableView: UITableView!
    
    weak var viewOutput: MainViewOutput?
    
    // MARK: - Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureTableView()
        callingRequest()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: - Methods
    
    func setOutput(mainViewOutput: MainViewOutput) {
        self.viewOutput = mainViewOutput
    }
}

// MARK: - Private methods

private extension MainViewController {
    func configureView() {
        view.backgroundColor = customBackgroundColor
    }
    
    func configureTableView() {
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "\(NavigationTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(NavigationTableViewCell.self)")
        tableView.register(UINib(nibName: "\(PopularTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(PopularTableViewCell.self)")
        tableView.register(UINib(nibName: "\(RecommendTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(RecommendTableViewCell.self)")
        tableView.register(UINib(nibName: "\(RecommendCollectionTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(RecommendCollectionTableViewCell.self)")
        
        tableView.separatorStyle = .none
    }
    
    func callingRequest() {
        viewOutput?.getPopularData()
    }
    
}

// MARK: - UITableViewDataSource and UITableViewDelegate

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(NavigationTableViewCell.self)")
            guard let cell = cell as? NavigationTableViewCell else {
                return UITableViewCell()
            }
            cell.title = "Популярные\nрецепты"
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(PopularTableViewCell.self)")
            guard let cell = cell as? PopularTableViewCell else {
                return UITableViewCell()
            }
            cell.setPopularOutput(self)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(RecommendTableViewCell.self)")
            guard let cell = cell as? RecommendTableViewCell else {
                return UITableViewCell()
            }
            cell.title = "Рекомендуемые"
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(RecommendCollectionTableViewCell.self)")
            guard let cell = cell as? RecommendCollectionTableViewCell else {
                return UITableViewCell()
            }
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
}

// MARK: - Extension MainViewInput

extension MainViewController: MainViewInput {
    func reloadData() {
        DispatchQueue.main.async {
            let cell = self.tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? PopularTableViewCell
            cell?.popularCollectionView.reloadData()
            self.tableView.reloadData()
        }
    }
    
}

// MARK: - Extension PopularOutput

extension MainViewController: PopularOutput {
    func getCountOfPopular() -> Int? {
        viewOutput?.getCountPopular()
    }
    
    func getCurrentPopularItem(_ row: Int) -> Item? {
        viewOutput?.getPopularData(row)
    }
    
    func getCurrentImage(_ url: String) -> UIImage? {
        return UIImage()
    }
}
