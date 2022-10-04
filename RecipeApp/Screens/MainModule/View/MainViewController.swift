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
    weak var popularInput: PopularInput?
    
    private var errorMessage: ErrorMessage?
    
    private var refreshControl = UIRefreshControl()
    
    
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
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "\(NavigationTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(NavigationTableViewCell.self)")
        tableView.register(UINib(nibName: "\(PopularTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(PopularTableViewCell.self)")
        tableView.register(UINib(nibName: "\(RecommendTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(RecommendTableViewCell.self)")
        tableView.register(UINib(nibName: "\(RecommendCollectionTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(RecommendCollectionTableViewCell.self)")
        
        tableView.separatorStyle = .none
        
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(updateTable), for: .valueChanged)
    }
    
    func callingRequest() {
        let _ = viewOutput?.getPopularData()
    }
    
    @objc func updateTable(_ sender: UIRefreshControl) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.refreshControl.endRefreshing()
        }
        callingRequest()
        tableView.reloadData()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// MARK: - Extension MainViewInput

extension MainViewController: MainViewInput {
    func reloadData() {
        DispatchQueue.main.async {
            let cell = self.tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? PopularTableViewCell
            self.popularInput = cell
            self.popularInput?.reloadCell()
            //self.tableView.reloadData()
        }
    }
    
    func showErrorMessage() {
        errorMessage = ErrorMessage(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height / 8.0))
        errorMessage!.text = "Отсутствует интернет-соединение\nПопробуйте позже"
        view.addSubview(errorMessage!)
        errorMessage?.startAnimation()
    }
    
}

// MARK: - Extension PopularOutput

extension MainViewController: PopularOutput {
    func getFavoriteRecipes() -> [Int] {
        guard let favoriteRecipes = viewOutput?.getFavoritesRecipes() else {
            return []
        }
        return favoriteRecipes
    }
    
    func getActionWithRecipe(_ id: Int) {
        viewOutput?.getActionsWithRecipe(id)
    }
    
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
