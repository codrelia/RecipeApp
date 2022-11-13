import UIKit

class RecommendCollectionTableViewCell: UITableViewCell {
    
    // MARK: - UIViews
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Lyfecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureCollectionView()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

// MARK: - Private methods

private extension RecommendCollectionTableViewCell {
    func configureCollectionView() {
        collectionView.backgroundColor = customBackgroundColor
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UINib(nibName: "\(RecommendCollectionViewCell.self)", bundle: .main), forCellWithReuseIdentifier: "\(RecommendCollectionViewCell.self)")
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

extension RecommendCollectionTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(RecommendCollectionViewCell.self)", for: indexPath)
        guard let cell = cell as? RecommendCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.rating = 4.1
        cell.name = "Плов из морепродуктов"
        cell.isTapped = false
        cell.image = UIImage(named: "example-recommend")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 264, height: 438)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 28, bottom: 10, right: 28)
    }
    
    
}
