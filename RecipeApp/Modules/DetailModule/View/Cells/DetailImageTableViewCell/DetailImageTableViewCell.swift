import UIKit

class DetailImageTableViewCell: UITableViewCell {

    
    // MARK: - UIViews
    @IBOutlet weak var imageRecipeView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var clockImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var caloricImageView: UIImageView!
    @IBOutlet weak var caloricLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet private weak var separatorImageView: UIImageView!
    
    // MARK: - Properties
    
    weak var output: DetailImageOutput?
    
    var image: UIImage? = nil {
        didSet {
            imageRecipeView.image = image
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
    
    var isTapped: Bool = false {
        didSet {
            isTapped ? favoriteButton.setImage(tappedHeartIconImage, for: .normal) : favoriteButton.setImage(heartIconImage, for: .normal)
        }
    }

    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureCell()
    }
    
    // MARK: - Methods
    
    func setOutput(_ output: DetailImageOutput) {
        self.output = output
    }
    
    // MARK: - Actions
    
    @IBAction func tapOnBackButton(_ sender: Any) {
        output?.returnToBackScreen()
    }
}

// MARK: - Private methods

private extension DetailImageTableViewCell {
    func configureCell() {
        backgroundColor = customBackgroundColor
        imageRecipeView.contentMode = .scaleAspectFill
        
        favoriteButton.contentMode = .scaleAspectFill
        favoriteButton.tintColor = .white
        
        backButton.contentMode = .scaleAspectFill
        backButton.tintColor = mainColor
        backButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        backButton.backgroundColor = .white
        backButton.layer.cornerRadius = 15
        
        infoView.backgroundColor = .white
        infoView.layer.cornerRadius = 20.0
        
        nameLabel.font = .systemFont(ofSize: 22, weight: .medium)
        nameLabel.textColor = mainColor
        
        clockImageView.image = timeIconImage
        clockImageView.tintColor = mainColor
        
        timeLabel.font = .systemFont(ofSize: 12.0, weight: .medium)
        timeLabel.textColor = mainColor
        
        caloricImageView.image = caloricIconImage
        caloricImageView.tintColor = mainColor
        
        caloricLabel.font = .systemFont(ofSize: 12.0, weight: .medium)
        caloricLabel.textColor = mainColor
        
        ratingImageView.image = ratingIconImage
        ratingImageView.tintColor = ratingColor
        
        ratingLabel.font = .systemFont(ofSize: 12.0, weight: .medium)
        ratingLabel.textColor = mainColor
        
        separatorImageView.image = separatorImage
        
    }
}
