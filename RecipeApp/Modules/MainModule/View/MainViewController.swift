import UIKit
import SkeletonView

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
        
        navigationController?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        viewOutput?.getReloadUserDefaults()
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        popularInput?.reloadCell()
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

extension MainViewController: SkeletonTableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(NavigationTableViewCell.self)")
            guard let cell = cell as? NavigationTableViewCell else {
                return UITableViewCell()
            }
            cell.title = "Популярные\nрецепты"
            cell.setOutput(self)
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
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        switch indexPath.row {
        case 0: return "\(NavigationTableViewCell.self)"
        case 1: return "\(PopularTableViewCell.self)"
        case 2: return "\(RecommendTableViewCell.self)"
        case 3: return "\(RecommendCollectionTableViewCell.self)"
        default:
            return ""
        }
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
        errorMessage?.removeFromSuperview()
        errorMessage = ErrorMessage(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height / 8.0))
        errorMessage!.text = "Отсутствует интернет-соединение\nПопробуйте позже"
        view.addSubview(errorMessage!)
        errorMessage?.startAnimation()
    }
    
}

// MARK: - Extension PopularOutput

extension MainViewController: PopularOutput {
    
    func pushDetailScreen(id: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.viewOutput?.pushDetailScreen(id: id)
        }
    }
    
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
    
    func getCurrentPopularItem(_ row: Int) -> MainModuleEntity.Item? {
        viewOutput?.getPopularData(row)
    }
    
    func getCurrentImage(_ url: String) -> UIImage? {
        return UIImage()
    }
}

// MARK: - UINavigationControllerDelegate

extension MainViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let transition: UIViewControllerAnimatedTransitioning?

        switch (fromVC, toVC) {
        case (is MainViewController, is DetailViewController):
            let moveElementsTransition = TransitionWithDetail()
            moveElementsTransition.operation = .push
            transition = moveElementsTransition
        case (is DetailViewController, is MainViewController):
            let moveElementsTransition = TransitionWithDetail()
            moveElementsTransition.operation = .pop
            transition = moveElementsTransition
        case (is MainViewController, is SearchModuleViewController):
            let moveElementsTransition = TransitionWithSearch()
            moveElementsTransition.operation = .push
            transition = moveElementsTransition
        case (is SearchModuleViewController, is MainViewController):
            let moveElementsTransition = TransitionWithSearch()
            moveElementsTransition.operation = .pop
            transition = moveElementsTransition
        default:
            transition = nil
        }
        
        return transition
    }
}

// MARK: - Extension AnimationDetailProtocol

extension MainViewController: AnimationDetailProtocol {
    func viewsToAnimate() -> [UIView] {
        var mainCell: PopularCollectionViewCell
        guard let cell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? PopularTableViewCell else {
            return []
        }
        
        if let indexPath = cell.popularCollectionView.indexPathsForSelectedItems {
            guard let temp = cell.popularCollectionView.cellForItem(at: indexPath[0]) as? PopularCollectionViewCell else {
                return []
            }
            mainCell = temp
        } else {
            return []
        }
        
        return [
            mainCell.imageView,
            mainCell.informationView,
            mainCell.favoriteButton,
            mainCell.clockImageView,
            mainCell.caloricImageView,
            mainCell.ratingImageView,
            mainCell.timeLabel,
            mainCell.caloricLabel,
            mainCell.ratingLabel,
            mainCell.nameLabel
        ]
    }
    
    func copyForView(_ subView: UIView) -> UIView {
        switch subView {
        case is UIImageView:
            let image = subView as! UIImageView
            let temp = UIImageView(image: image.image)
            temp.contentMode = .scaleAspectFit
            if image.frame.size.height > 40 {
                temp.contentMode = .scaleAspectFill
            }
            temp.clipsToBounds = true
            temp.tintColor = image.tintColor
            temp.layer.cornerRadius = 5
            return temp
        case is UILabel:
            let label = subView as! UILabel
            let temp = UILabel()
            temp.text = label.text
            temp.textColor = label.textColor
            temp.numberOfLines = 2
            temp.font = label.font
            temp.textAlignment = .center
            temp.center = label.center
            return temp
        case is UIButton:
            let button = subView as! UIButton
            let temp = UIButton()
            temp.setImage(button.image(for: .normal), for: .normal)
            temp.tintColor = .white
            temp.frame = button.frame
            return temp
        default:
            let view = subView
            let temp = UIView(frame: subView.frame)
            temp.backgroundColor = view.backgroundColor
            temp.layer.cornerRadius = view.layer.cornerRadius
            return temp
        }
    }
    
    func takeViewsHigher() -> [[UIView]] {
        var result: [[UIView]] = []
        guard let temp = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? PopularTableViewCell else {
            return []
        }
        
        let indices = temp.popularCollectionView.indexPathsForVisibleItems
        
        for index in indices {
            if index.row > temp.popularCollectionView.indexPathsForSelectedItems?[0].row ?? 0 {
                break
            }
            if index == temp.popularCollectionView.indexPathsForSelectedItems?[0] {
                continue
            }
            var tempResult: [UIView] = []
            let tempCell = temp.popularCollectionView.cellForItem(at: index) as! PopularCollectionViewCell
            tempResult.append(tempCell.imageView)
            tempResult.append(tempCell.informationView)
            tempResult.append(tempCell.favoriteButton)
            tempResult.append(tempCell.clockImageView)
            tempResult.append(tempCell.caloricImageView)
            tempResult.append(tempCell.ratingImageView)
            tempResult.append(tempCell.timeLabel)
            tempResult.append(tempCell.caloricLabel)
            tempResult.append(tempCell.ratingLabel)
            
            result.append(tempResult)
        }
        return result
    }
    
    func takeViewsBelow() -> [[UIView]] {
        var result: [[UIView]] = []
        guard let temp = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? PopularTableViewCell else {
            return []
        }
        
        let indices = temp.popularCollectionView.indexPathsForVisibleItems
        for index in indices {
            if index.row <= temp.popularCollectionView.indexPathsForSelectedItems?[0].row ?? 0 {
                continue
            }
            var tempResult: [UIView] = []
            let tempCell = temp.popularCollectionView.cellForItem(at: index) as! PopularCollectionViewCell
            tempResult.append(tempCell.imageView)
            tempResult.append(tempCell.informationView)
            tempResult.append(tempCell.favoriteButton)
            tempResult.append(tempCell.clockImageView)
            tempResult.append(tempCell.caloricImageView)
            tempResult.append(tempCell.ratingImageView)
            tempResult.append(tempCell.timeLabel)
            tempResult.append(tempCell.caloricLabel)
            tempResult.append(tempCell.ratingLabel)
            
            result.append(tempResult)
        }
        return result
    }
    
    func copyAnotherView(_ subView: UIView) -> UIView {
        switch subView {
        case is UIImageView:
            let copy = UIImageView(image: (subView as! UIImageView).image)
            copy.contentMode = .scaleAspectFill
            copy.clipsToBounds = true
            return copy
        case is UILabel:
            let label = subView as! UILabel
            let temp = UILabel()
            temp.text = label.text
            temp.attributedText = label.attributedText
            temp.attributedText = label.attributedText
            temp.frame = label.frame
            temp.textColor = .black
            return temp
        case is UIButton:
            let button = subView as! UIButton
            let temp = UIButton(frame: button.frame)
            temp.setImage(button.imageView?.image, for: .normal)
            temp.tintColor = button.tintColor
            temp.imageView?.contentMode = .scaleAspectFill
            return temp
        default:
            return UIView()
        }
    }
}

// MARK: - Extension AnimationSearchProtocol
extension MainViewController: AnimationSearchProtocol {
    func buttonToAnimate() -> [UIView] {
        guard let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? NavigationTableViewCell else {
            return []
        }
        return [cell.getSearchButton()]
    }
    
    func copyButton(_ subView: UIView) -> UIView {
        let button = subView as! UIButton
        let temp = UIButton()
        temp.setImage(button.image(for: .normal), for: .normal)
        temp.tintColor = mainColor
        temp.frame = button.frame
        temp.backgroundColor = .clear
        temp.contentMode = .scaleAspectFill
        return temp
    }
}

// MARK: - NavigationOutput

extension MainViewController: NavigationOutput {
    func pushProfileScreen() {
        DispatchQueue.main.async {
            self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.viewOutput?.pushProfileScreen()
        }
    }
    
    func pushSearchScreen() {
        DispatchQueue.main.async {
            self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.viewOutput?.pushSearchScreen()
        }
    }
}
