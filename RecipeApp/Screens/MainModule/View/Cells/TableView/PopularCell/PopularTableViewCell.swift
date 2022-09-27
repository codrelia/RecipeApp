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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
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
        
        let count = popularOutput?.getCountOfPopular()
        if count != 0 {
            guard let recipe = popularOutput?.getCurrentPopularItem(indexPath.row) else {
                return UICollectionViewCell()
            }
            cell.image = recipe.dataImage
            cell.name = recipe.nameRecipe
            cell.isTapped = false
            cell.time = recipe.timeCooking
            cell.caloric = recipe.caloricContent[0].caloric
            cell.rating = Double(recipe.rating)
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
    
    
}
