import UIKit

class PopularCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UIViews

    @IBOutlet private weak var informationView: UIView!
    @IBOutlet private weak var favoriteButton: UIButton!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var clockImageView: UIImageView!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var caloricImageView: UIImageView!
    @IBOutlet private weak var caloricLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var ratingImageView: UIImageView!
    
    
    // MARK: - Properties
    
    var image: UIImage? = UIImage() {
        didSet {
            imageView.image = image
        }
    }
    
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
    
    var time: Int = 0 {
        didSet {
            var temp = time / 60
            if temp < 60 {
                timeLabel.text = "\(temp) м."
            } else if temp % 60 != 0 {
                timeLabel.text = "\(Int(temp / 60)) ч. \(temp % 60) м."
            } else {
                temp /= 60
                timeLabel.text = "\(temp) ч."
            }
        }
    }
    
    var caloric: Int = 0 {
        didSet {
            caloricLabel.text = "\(caloric) ккал."
        }
    }
    
    var rating: Double = 0 {
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

private extension PopularCollectionViewCell {
    func configureCell() {
        informationView.backgroundColor = .white
        informationView.layer.cornerRadius = 20
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 5
        
        backgroundColor = .clear
        
        nameLabel.font = .systemFont(ofSize: 14, weight: .medium)
        nameLabel.tintColor = textColor
        nameLabel.numberOfLines = 2
        nameLabel.textAlignment = .center
        
        favoriteButton.tintColor = .white
        
        clockImageView.image = timeIconImage
        clockImageView.tintColor = textColor
        clockImageView.contentMode = .scaleAspectFill
        
        timeLabel.tintColor = textColor
        timeLabel.font = .systemFont(ofSize: 12, weight: .medium)
        
        caloricImageView.image = caloricIconImage
        caloricImageView.tintColor = textColor
        clockImageView.contentMode = .scaleAspectFill
        
        ratingImageView.image = ratingIconImage
        ratingImageView.tintColor = ratingColor
        ratingImageView.contentMode = .scaleAspectFill
        
    }
}
