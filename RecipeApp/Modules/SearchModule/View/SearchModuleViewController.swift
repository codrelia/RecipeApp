import UIKit

class SearchModuleViewController: UIViewController {
    
    // MARK: - UIViews
    
    @IBOutlet private weak var tableView: UITableView!
    // MARK: - VIPERs elements
    
    private weak var viewOutput: SearchModuleViewOutput?

    // MARK: - Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureTable()
    }
}

// MARK: - Private methods

private extension SearchModuleViewController {
    func configureView() {
        view.backgroundColor = customBackgroundColor
    }
    
    func configureTable() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "\(SearchNavigationTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(SearchNavigationTableViewCell.self)")
        tableView.register(UINib(nibName: "\(SearchFilterTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(SearchFilterTableViewCell.self)")
    }
}

// MARK: - SearchModuleViewInput

extension SearchModuleViewController: SearchModuleViewInput {
    func setOutput(viewOutput: SearchModuleViewOutput) {
        self.viewOutput = viewOutput
    }
}

// MARK: - UITableViewDataSource

extension SearchModuleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(SearchNavigationTableViewCell.self)", for: indexPath) as? SearchNavigationTableViewCell else {
                return UITableViewCell()
            }
            cell.setOutput(output: self)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(SearchFilterTableViewCell.self)", for: indexPath) as? SearchFilterTableViewCell else {
                return UITableViewCell()
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate

extension SearchModuleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 1:
            return 32.0
        default:
            return UITableView.automaticDimension
        }
    }
}

// MARK: - SearchNavigationOutput

extension SearchModuleViewController: SearchNavigationOutput {
    func tapOnBackButton() {
        viewOutput?.tapOnBackButton()
    }
}

// MARK: - Extension AnimationProtocol

extension SearchModuleViewController: AnimationSearchProtocol {
    func buttonToAnimate() -> [UIView] {
        guard let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? SearchNavigationTableViewCell else {
            return []
        }
        print(cell.getSearchButton().frame)
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
