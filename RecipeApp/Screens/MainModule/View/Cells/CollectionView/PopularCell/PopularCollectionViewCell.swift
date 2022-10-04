import UIKit

class PopularCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UIViews

    @IBOutlet private weak var informationView: UIView!
    @IBOutlet private weak var favoriteButton: UIButton!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet private weak var clockImageView: UIImageView!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var caloricImageView: UIImageView!
    @IBOutlet private weak var caloricLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var ratingImageView: UIImageView!
    
    // MARK: -
    
    weak var popularCollectionOutput: PopularCollectionOutput?
    
    
    // MARK: - Properties
    
    var id: Int = 0
    
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
            let floorNumber = Int(rating)
            if Double(floorNumber) != rating {
                ratingLabel.text = "\(rating)"
            } else {
                ratingLabel.text = "\(floorNumber)"
            }
        }
    }
    
    var colorOfInforationView = UIColor.white {
        didSet {
            informationView.backgroundColor = colorOfInforationView
        }
    }
    
    var isLoad: Bool = false {
        didSet {
            caloricImageView.isHidden = isLoad
            caloricLabel.isHidden = isLoad
            
            timeLabel.isHidden = isLoad
            clockImageView.isHidden = isLoad
            
            ratingImageView.isHidden = isLoad
            ratingLabel.isHidden = isLoad
        }
    }
    
    // MARK: - Lyfecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
    }
    
    // MARK: - Actions
    
    @IBAction func tapOnFavoriteButton(_ sender: Any) {
        animationButton()
        popularCollectionOutput!.actionsWithRecipe(id)
        
    }
    
    func setPopularCollectionOutput(_ popularCollectionOutput: PopularCollectionOutput) {
        self.popularCollectionOutput = popularCollectionOutput
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
    
    func animationButton() {
        UIView.animate(withDuration: 0.1, delay: 0.0) {
            self.favoriteButton.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        } completion: { _ in
            UIView.animate(withDuration: 0.1, delay: 0.0) {
                self.favoriteButton.transform = CGAffineTransform.identity
                self.isTapped.toggle()
            } completion: { _ in
            }
        }
    }
}
