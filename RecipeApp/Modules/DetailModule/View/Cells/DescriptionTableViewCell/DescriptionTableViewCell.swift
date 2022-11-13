import UIKit

class DescriptionTableViewCell: UITableViewCell {
    
    // MARK: - UIViews
    
    @IBOutlet private weak var descriptionText: UILabel!
    @IBOutlet private weak var proteinLabel: UILabel!
    @IBOutlet private weak var fatsLabel: UILabel!
    @IBOutlet private weak var carbohydratesLabel: UILabel!
    
    // MARK: - Properties
    
    var descriptions: String = "" {
        didSet {
            descriptionText.text = descriptions
        }
    }
    
    var protein: Int = 0 {
        didSet {
            proteinLabel.text = String(protein) + " г."
        }
    }
    
    var fats: Int = 0 {
        didSet {
            fatsLabel.text = String(fats) + " г."
        }
    }
    
    var carbohydrates: Int = 0 {
        didSet {
            carbohydratesLabel.text = String(carbohydrates) + " г."
        }
    }
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureCell()
    }
    
}

// MARK: - Private methods

private extension DescriptionTableViewCell {
    func configureCell() {
        backgroundColor = .white
        
        descriptionText.font = .systemFont(ofSize: 14.0, weight: .regular)
        descriptionText.textColor = .black
        descriptionText.numberOfLines = 0
        
        proteinLabel.font = .systemFont(ofSize: 14.0, weight: .regular)
        proteinLabel.textColor = .black
        fatsLabel.font = .systemFont(ofSize: 14.0, weight: .regular)
        fatsLabel.textColor = .black
        carbohydratesLabel.font = .systemFont(ofSize: 14.0, weight: .regular)
        carbohydratesLabel.textColor = .black
        
    }
}
