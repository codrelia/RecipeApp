import UIKit

class SearchModuleViewController: UIViewController {
    
    // MARK: - UIViews
    
    @IBOutlet private weak var tableView: UITableView!
    private var errorMessage: ErrorMessage?
    
    private var notFoundLabel: UILabel = {
        let label = UILabel()
        label.text = "Ничего не найдено"
        label.font = .systemFont(ofSize: 16.0, weight: .medium)
        label.frame = CGRect(x: 0.0, y: 0.0, width: 100, height: 100)
        label.sizeToFit()
        return label
    }()
    
    // MARK: - VIPERs elements
    
    private weak var viewOutput: SearchModuleViewOutput?
    
    // MARK: - Properties
    private var searchText = ""

    // MARK: - Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
}

// MARK: - Private methods

private extension SearchModuleViewController {
    func configureView() {
        view.backgroundColor = customBackgroundColor
        
        notFoundLabel.center = view.center
        view.addSubview(notFoundLabel)
        notFoundLabel.alpha = 0.0
    }
    
    func configureTable() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "\(SearchNavigationTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(SearchNavigationTableViewCell.self)")
        tableView.register(UINib(nibName: "\(SearchFilterTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(SearchFilterTableViewCell.self)")
        tableView.register(UINib(nibName: "\(SearchResultsTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(SearchResultsTableViewCell.self)")
    }
}

// MARK: - SearchModuleViewInput

extension SearchModuleViewController: SearchModuleViewInput {
    func setOutput(viewOutput: SearchModuleViewOutput) {
        self.viewOutput = viewOutput
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
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

// MARK: - UITableViewDataSource

extension SearchModuleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewOutput = viewOutput else {
            notFoundLabel.alpha = 0.0
            return 0
        }
        if section == 0 {
            notFoundLabel.alpha = 0.0
            return 1
        } else {
            if let countOfRecipes = viewOutput.countOfRecipes(searchText: searchText) {
                notFoundLabel.alpha = 0.0
                if countOfRecipes != 0 {
                    return countOfRecipes
                } else {
                    return 1
                }
            } else {
                notFoundLabel.alpha = 1.0
                return 0
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.row, indexPath.section) {
        case (0, 0):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(SearchNavigationTableViewCell.self)", for: indexPath) as? SearchNavigationTableViewCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.setOutput(output: self)
            return cell
        /*
        case (1, 0):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(SearchFilterTableViewCell.self)", for: indexPath) as? SearchFilterTableViewCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell
         */
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(SearchResultsTableViewCell.self)", for: indexPath) as? SearchResultsTableViewCell else {
                return UITableViewCell()
            }
            cell.setOutput(self)
            let items = viewOutput?.getRequestSearch()
            var filteredItems: [SearchModuleEntity.Item]?
            guard let favoriteRecipes = viewOutput?.getFavoritesRecipes() else {
                return cell
            }
            if searchText == "" {
                filteredItems = items?.items
            } else {
                filteredItems = items?.items.filter {$0.nameRecipe.lowercased().contains(searchText.lowercased())}
            }
            if items == nil {
                cell.image = UIImage(color: loadColor)
                cell.isLoad = true
            } else {
                if filteredItems?.count == 0 {
                    print("Не найдено")
                } else {
                    DispatchQueue.main.async {
                        guard let currentRecipe = filteredItems?[indexPath.row] else {
                            return
                        }
                        cell.idRecipe = currentRecipe.idRecipe
                        cell.name = currentRecipe.nameRecipe
                        cell.image = currentRecipe.image
                        cell.time = currentRecipe.timeCooking
                        cell.caloric = currentRecipe.caloricContent[0].caloric
                        cell.rating = currentRecipe.rating
                        cell.isTapped = false
                        favoriteRecipes.forEach( {
                            if $0 == currentRecipe.idRecipe {
                                cell.isTapped = true
                            }
                        })
                        cell.isLoad = false
                    }
                }
            }
            return cell
        }
    }
}

// MARK: - UITableViewDelegate

extension SearchModuleViewController: UITableViewDelegate {
    /*
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath.row, indexPath.section) {
        case (1, 0):
            return 32.0
        default:
            return UITableView.automaticDimension
        }
    }
    */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath) as? SearchResultsTableViewCell else {
            return
        }
        viewOutput?.pushDetailScreen(id: cell.idRecipe)
    }
}

// MARK: - SearchNavigationOutput

extension SearchModuleViewController: SearchNavigationOutput {
    func tapOnBackButton() {
        viewOutput?.tapOnBackButton()
    }
    
    func setFilterPhrase(searchText: String) {
        self.searchText = searchText
        DispatchQueue.main.async {
            self.tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
        }
    }
}

// MARK: -

extension SearchModuleViewController: SearchResultsOutput {
    func actionsWithRecipe(_ id: Int) {
        viewOutput?.getActionsWithRecipe(id)
    }
}

// MARK: - Extension AnimationProtocol

extension SearchModuleViewController: AnimationSearchProtocol {
    func buttonToAnimate() -> [UIView] {
        guard let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? SearchNavigationTableViewCell else {
            return []
        }
        return [cell.getSearchButton()]
    }
    
    func copyButton(_ subView: UIView) -> UIView {
        let button = subView as! UIButton
        let temp = UIButton()
        temp.backgroundColor = .clear
        temp.setImage(button.image(for: .normal), for: .normal)
        temp.tintColor = mainColor
        temp.frame = button.frame
        temp.contentMode = .scaleAspectFill
        return temp
    }
    
}
