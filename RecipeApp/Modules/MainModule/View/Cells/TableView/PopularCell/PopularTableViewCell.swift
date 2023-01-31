import UIKit

class PopularTableViewCell: UITableViewCell {
    
    // MARK: - UIViews
    
    @IBOutlet weak var popularCollectionView: UICollectionView!
    
    private weak var popularOutput: PopularOutput?
    
    // MARK: - Lyfecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configurePopularCollectionView()
    }
    
    func setPopularOutput(_ view: MainViewController) {
        self.popularOutput = view
    }
    
}

// MARK: - Private methods

private extension PopularTableViewCell {
    func configurePopularCollectionView() {
        popularCollectionView.register(UINib(nibName: "\(PopularCollectionViewCell.self)", bundle: .main), forCellWithReuseIdentifier: "\(PopularCollectionViewCell.self)")
        popularCollectionView.dataSource = self
        popularCollectionView.delegate = self
        popularCollectionView.backgroundColor = customBackgroundColor
        popularCollectionView.showsHorizontalScrollIndicator = false
    }
    
    func configureCell() {
        backgroundColor = customBackgroundColor
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

extension PopularTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = popularOutput?.getCountOfPopular()
        if count == 0 {
            return 3
        }
        return count!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = popularCollectionView.dequeueReusableCell(withReuseIdentifier: "\(PopularCollectionViewCell.self)", for: indexPath)
        
        guard let cell = cell as? PopularCollectionViewCell else {
            return cell
        }
        
        cell.setPopularCollectionOutput(self)
        
        let count = popularOutput?.getCountOfPopular()
        if count != 0 {
            guard let recipe = popularOutput?.getCurrentPopularItem(indexPath.row) else {
                return UICollectionViewCell()
            }
            
            guard let favoriteRecipes = popularOutput?.getFavoriteRecipes() else {
                return UICollectionViewCell()
            }
            
            cell.isTapped = false
            
            for i in favoriteRecipes {
                if i == recipe.idRecipe {
                    cell.isTapped = true
                }
            }
            
            cell.name = recipe.nameRecipe
            cell.time = recipe.timeCooking
            cell.caloric = recipe.caloricContent[0].caloric
            cell.rating = recipe.rating
            cell.image = recipe.dataImage
            cell.colorOfInforationView = .white
            cell.isLoad = false
            cell.id = recipe.idRecipe
            
        } else {
            
            cell.image = UIImage(color: loadColor)
            cell.time = 0
            cell.caloric = 0
            cell.rating = 0
            cell.name = ""
            cell.colorOfInforationView = loadColor
            cell.isLoad = true
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 28, bottom: 0, right: 28)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? PopularCollectionViewCell else {
            return
        }
        popularOutput?.pushDetailScreen(id: cell.id)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
    }
    
}

// MARK: - PopularInput

extension PopularTableViewCell: PopularInput {
    func reloadCell() {
        self.popularCollectionView.reloadData()
    }
}

// MARK: - PopularCollectionOutput

extension PopularTableViewCell: PopularCollectionOutput {
    func actionsWithRecipe(_ id: Int) {
        popularOutput?.getActionWithRecipe(id)
    }
}


public extension UIImage {
     convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
       let rect = CGRect(origin: .zero, size: size)
       UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
       color.setFill()
       UIRectFill(rect)
       let image = UIGraphicsGetImageFromCurrentImageContext()
       UIGraphicsEndImageContext()
       
       guard let cgImage = image?.cgImage else { return nil }
       self.init(cgImage: cgImage)
     }
   }
