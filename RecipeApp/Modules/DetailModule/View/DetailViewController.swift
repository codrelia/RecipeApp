import UIKit
import SkeletonView

class DetailViewController: UIViewController {
    
    // MARK: - UIViews
    @IBOutlet weak var tableView: UITableView!
    private var errorMessage: ErrorMessage?
    
    // MARK: - Protocols
    weak var viewOutput: DetailModuleViewOutput?
    
    // MARK: - Properties
    private var isReload: Bool = false
    private var tappedItem: Int = 0
    
    var heightStatusBar: CGFloat = 0.0 {
        didSet {
            if oldValue > 0.0 {
                heightStatusBar = oldValue
            }
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        heightStatusBar = UIApplication.shared.statusBarFrame.height
        return true
    }

    // MARK: - Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureTable()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillLayoutSubviews() {
        self.tableView.contentInset = UIEdgeInsets(top: -heightStatusBar, left: 0, bottom: 0, right: 0)
    }
    
    override func viewDidLayoutSubviews() {
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
}

// MARK: - Private methods

private extension DetailViewController {
    func configureView() {
        view.backgroundColor = customBackgroundColor
    }
    
    func configureTable() {
        tableView.backgroundColor = .white
        
        tableView.register(UINib(nibName: "\(DetailImageTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(DetailImageTableViewCell.self)")
        tableView.register(UINib(nibName: "\(FilterDetailTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(FilterDetailTableViewCell.self)")
        tableView.register(UINib(nibName: "\(DescriptionTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(DescriptionTableViewCell.self)")
        tableView.register(UINib(nibName: "\(IngredientTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(IngredientTableViewCell.self)")
        tableView.register(UINib(nibName: "\(PreparationTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(PreparationTableViewCell.self)")
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.allowsSelection = false
        
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var temp = 2
        if tappedItem == 0 {
            temp += 1
        } else if tappedItem == 1 {
            temp += viewOutput?.getRequestIngredientsInfo()?.products.count ?? 5
        } else if tappedItem == 2 {
            temp += viewOutput?.getRequestPreparationInfo()?.preparation.count ?? 1
        }
        return temp
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(DetailImageTableViewCell.self)", for: indexPath) as? DetailImageTableViewCell else {
                return UITableViewCell()
            }
            
            cell.setOutput(self)
            guard let recipes = viewOutput?.getGeneralInfo() else {
                return UITableViewCell()
            }
            
            guard let favoritesRecipes = viewOutput?.getFavoritesRecipes() else {
                return UITableViewCell()
            }
            
            cell.isTapped = false
            
            for i in favoritesRecipes {
                if i == recipes.idRecipe {
                    cell.isTapped = true
                    break
                }
            }
            
            cell.image = recipes.dataImage
            cell.name = recipes.nameRecipe
            cell.time = recipes.timeCooking
            cell.caloric = recipes.caloricContent[0].caloric
            cell.rating = recipes.rating
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(FilterDetailTableViewCell.self)", for: indexPath) as? FilterDetailTableViewCell else {
                return UITableViewCell()
            }
            cell.setOutput(output: self)
            return cell
        default:
            if tappedItem == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(DescriptionTableViewCell.self)", for: indexPath) as? DescriptionTableViewCell else { return UITableViewCell() }
                guard let item = viewOutput?.getRequestDescriptionInfo() else {
                    cell.isLoad = true
                    return cell
                }
                cell.descriptions = item.descriptionText
                cell.fats = item.caloricContent[0].fat
                cell.protein = item.caloricContent[0].protein
                cell.carbohydrates = item.caloricContent[0].carbohydrates
                cell.isLoad = false
                return cell
            } else if tappedItem == 1 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(IngredientTableViewCell.self)", for: indexPath) as? IngredientTableViewCell else {
                    return UITableViewCell() }
                guard let item = viewOutput?.getRequestIngredientsInfo() else {
                    cell.isLoad = true
                    return cell
                    
                }
                cell.name = item.products[indexPath.row - 2].nameImgredient
                let temp = item.products[indexPath.row - 2].counts == 0 ? "" : String(item.products[indexPath.row - 2].counts)
                cell.measurent = temp + " " + item.products[indexPath.row - 2].measurement[0].nameMeasurement
                cell.isLoad = false
                return cell
            } else if tappedItem == 2 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(PreparationTableViewCell.self)", for: indexPath) as? PreparationTableViewCell else { return UITableViewCell() }
                guard let item = viewOutput?.getRequestPreparationInfo() else {
                    cell.isLoad = true
                    return cell
                }
                cell.step = item.preparation[indexPath.row - 2].step
                cell.image = item.preparation[indexPath.row - 2].dataImage
                cell.descriptionText = item.preparation[indexPath.row - 2].preparationDescription
                cell.isLoad = false
                return cell
            }
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0: return 400.0
        case 1: return 32.0
        default:
            return UITableView.automaticDimension
        }
    }
    
   func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? DetailImageTableViewCell {
                cell.frame.origin.y = scrollView.contentOffset.y
                let originalHeight: CGFloat = tableView(tableView, heightForRowAt: IndexPath(row: 0, section: 0))
                cell.frame.size.height = originalHeight + scrollView.contentOffset.y * (-1.0)
            }
        }
    }
}

// MARK: - SkeletonTableViewDataSource

extension DetailViewController: SkeletonTableViewDataSource {
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        switch indexPath.row {
        case 0: return "\(DetailImageTableViewCell.self)"
        case 1: return "\(FilterDetailTableViewCell.self)"
        default:
            if tappedItem == 0 {
                return "\(DescriptionTableViewCell.self)"
            } else if tappedItem == 1 {
                return "\(IngredientTableViewCell.self)"
            } else if tappedItem == 2 {
                return "\(PreparationTableViewCell.self)"
            } else {
                return ""
            }
        }
    }
}

// MARK: - DetailModuleViewInput

extension DetailViewController: DetailModuleViewInput {
    func setOutput(viewOutput: DetailModuleViewOutput) {
        self.viewOutput = viewOutput
    }
    
    func showErrorMessage() {
        errorMessage?.removeFromSuperview()
        errorMessage = ErrorMessage(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height / 8.0))
        errorMessage!.text = "Отсутствует интернет-соединение\nПопробуйте позже"
        view.addSubview(errorMessage!)
        errorMessage?.startAnimation()
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func reloadInformation() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - DetailImageOutput

extension DetailViewController: DetailImageOutput {
    func returnToBackScreen() {
        viewOutput?.returnToBackScreen()
    }
    
    func actionsWithRecipe() {
        viewOutput?.actionsWithRecipe()
    }
}

// MARK: - AnimationProtocol

extension DetailViewController: AnimationDetailProtocol {
    func viewsToAnimate() -> [UIView] {
        guard let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? DetailImageTableViewCell else {
            return []
        }
        
        return [
                cell.imageRecipeView,
                cell.infoView,
                cell.favoriteButton,
                cell.clockImageView,
                cell.caloricImageView,
                cell.ratingImageView,
                cell.timeLabel,
                cell.caloricLabel,
                cell.ratingLabel,
                cell.nameLabel
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
            temp.attributedText = label.attributedText
            return temp
        case is UIButton:
            let button = subView as! UIButton
            let temp = UIButton()
            temp.setImage(button.image(for: .normal), for: .normal)
            temp.frame = button.frame
            temp.tintColor = button.tintColor
            return temp
        case is UIView:
            let view = subView as! UIView
            let temp = UIView(frame: subView.frame)
            temp.backgroundColor = view.backgroundColor
            temp.layer.cornerRadius = view.layer.cornerRadius
            return temp
        default:
            return UIView()
        }
    }
    
    func takeViewsHigher() -> [[UIView]] {
        var result: [[UIView]] = []
        if let indices = tableView.indexPathsForVisibleRows {
            for index in indices {
                if index.row > tableView.indexPathForSelectedRow?.row ?? 0 {
                    break
                }
                if index == tableView.indexPathForSelectedRow {
                    continue
                }
                var tempResult: [UIView] = []
                let tempCell = tableView.cellForRow(at: index) as! DetailImageTableViewCell
                tempResult.append(tempCell.imageRecipeView)
                tempResult.append(tempCell.infoView)
                tempResult.append(tempCell.clockImageView)
                tempResult.append(tempCell.caloricImageView)
                tempResult.append(tempCell.ratingImageView)
                tempResult.append(tempCell.timeLabel)
                tempResult.append(tempCell.caloricLabel)
                tempResult.append(tempCell.ratingLabel)
                result.append(tempResult)
            }
        }
        return result
    }
    
    func takeViewsBelow() -> [[UIView]] {
        var result: [[UIView]] = []
        if let indices = tableView.indexPathsForVisibleRows {
            for index in indices {
                if index.row <= tableView.indexPathForSelectedRow?.row ?? 0 {
                    break
                }
                if index == tableView.indexPathForSelectedRow {
                    continue
                }
                var tempResult: [UIView] = []
                let tempCell = tableView.cellForRow(at: index) as! DetailImageTableViewCell
                tempResult.append(tempCell.imageRecipeView)
                tempResult.append(tempCell.infoView)
                tempResult.append(tempCell.clockImageView)
                tempResult.append(tempCell.caloricImageView)
                tempResult.append(tempCell.ratingImageView)
                tempResult.append(tempCell.timeLabel)
                tempResult.append(tempCell.caloricLabel)
                tempResult.append(tempCell.ratingLabel)
                result.append(tempResult)
            }
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
            temp.frame = label.frame
            temp.textColor = .black
            return temp
        case is UIButton:
            return UIButton()
        default:
            return UIView()
        }
    }
}

// MARK: - FiltersCollectionOutput

extension DetailViewController: FiltersCollectionOutput {
    func tapOnFiltersButton(itemCount: Int) {
        tappedItem = itemCount
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
