import UIKit

class RecommendCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UIViews
    
    @IBOutlet private weak var favoriteButton: UIButton!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var recommendImageView: UIImageView!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var ratingImageView: UIImageView!
    
    // MARK: - Properties
    
    var isTapped: Bool = false {
        didSet {
            isTapped ? favoriteButton.setImage(tappedHeartIconImage, for: .normal) : favoriteButton.setImage(heartIconImage, for: .normal)
        }
    }
    
    var name: String = "" {
        didSet {
            nameLabel.text = name
        }
    }
    
    var image: UIImage? = UIImage() {
        didSet {
            recommendImageView.image = image
        }
    }
    
    var rating: Double = 0.0 {
        didSet {
            ratingLabel.text = "\(rating)"
        }
    }
    

    // MARK: - Lyfecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureCell()
    }

}

// MARK: - Private methods

private extension RecommendCollectionViewCell {
    func configureCell() {
        ratingImageView.image = ratingIconImage
        ratingImageView.tintColor = ratingColor
        ratingImageView.contentMode = .scaleAspectFill
        
        recommendImageView.contentMode = .scaleAspectFill
        recommendImageView.layer.cornerRadius = 10
        
        favoriteButton.tintColor = .white
        
        nameLabel.font = .systemFont(ofSize: 22, weight: .black)
        nameLabel.textColor = .white
        nameLabel.shadowColor = .black
        nameLabel.shadowOffset = CGSize(width: 1.0, height: 1.0)
        nameLabel.numberOfLines = 0
        
        ratingLabel.font = .systemFont(ofSize: 14, weight: .black)
        ratingLabel.textColor = .white
        ratingLabel.shadowColor = .black
        ratingLabel.shadowOffset = CGSize(width: 1.0, height: 1.0)
        ratingLabel.numberOfLines = 0
        
    }
}
