import UIKit

class SearchResultsTableViewCell: UITableViewCell {
    
    // MARK: - UIViews
    
    @IBOutlet private weak var recipeImage: UIImageView!
    @IBOutlet private weak var favoriteButton: UIButton!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var clockImage: UIImageView!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var fireImage: UIImageView!
    @IBOutlet private weak var caloricLabel: UILabel!
    @IBOutlet private weak var ratingImage: UIImageView!
    @IBOutlet private weak var ratingLabel: UILabel!
    
    // MARK: - Properties
    
    private weak var output: SearchResultsOutput?
    
    var idRecipe: Int = 0
    
    var image: UIImage? = UIImage() {
        didSet {
            recipeImage.image = image
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
    
    var isLoad: Bool = false {
        didSet {
            fireImage.isHidden = isLoad
            caloricLabel.isHidden = isLoad
            
            timeLabel.isHidden = isLoad
            clockImage.isHidden = isLoad
            
            ratingImage.isHidden = isLoad
            ratingLabel.isHidden = isLoad
            
            if isLoad {
                recipeImage.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: loadColor, secondaryColor: anotherLoadColor), transition: .crossDissolve(1.0))
            } else {
                recipeImage.hideSkeleton()
            }
        }
    }
    
    // MARK: - Initialization

    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureCell()
    }
    
    // MARK: - Methods
    
    func setOutput(_ output: SearchResultsOutput) {
        self.output = output
    }
    
    // MARK: - Actions
    
    
    @IBAction func tapOnFavoriteButton(_ sender: Any) {
        animationButton()
        output?.actionsWithRecipe(idRecipe)
    }
    
}

// MARK: - Private methods

private extension SearchResultsTableViewCell {
    func configureCell() {
        recipeImage.contentMode = .scaleAspectFill
        recipeImage.layer.cornerRadius = 5
        
        backgroundColor = .clear
        
        nameLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        nameLabel.textColor = mainColor
        nameLabel.numberOfLines = 2
        nameLabel.textAlignment = .left
        
        favoriteButton.tintColor = .white
        
        clockImage.image = timeIconImage
        clockImage.tintColor = mainColor
        clockImage.contentMode = .scaleAspectFill
        
        timeLabel.textColor = mainColor
        timeLabel.font = .systemFont(ofSize: 12, weight: .medium)
        
        fireImage.image = caloricIconImage
        fireImage.tintColor = mainColor
        //fireImage.contentMode = .scaleAspectFill
        
        ratingImage.image = ratingIconImage
        ratingImage.tintColor = ratingColor
        ratingImage.contentMode = .scaleAspectFill
        
        ratingLabel.textColor = mainColor
        ratingLabel.font = .systemFont(ofSize: 12, weight: .medium)
        caloricLabel.font = .systemFont(ofSize: 12, weight: .medium)
        caloricLabel.textColor = mainColor
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
