import UIKit

class PreparationTableViewCell: UITableViewCell {
    
    // MARK: - UIViews

    @IBOutlet private weak var stepLabel: UILabel!
    @IBOutlet private weak var preparationImageView: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    // MARK: - Properties
    
    var step = 0 {
        didSet {
            stepLabel.text = String(step) + " шаг."
        }
    }
    
    var image: UIImage? = nil {
        didSet {
            preparationImageView.image = image
        }
    }
    
    var descriptionText = "" {
        didSet {
            descriptionLabel.text = descriptionText
        }
    }
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureCell()
    }
    
}

// MARK: - Private methods

private extension PreparationTableViewCell {
    func configureCell() {
        stepLabel.font = .systemFont(ofSize: 14.0, weight: .medium)
        stepLabel.textColor = .black
        stepLabel.text = "-"
        
        preparationImageView.contentMode = .scaleAspectFill
        
        descriptionLabel.font = .systemFont(ofSize: 14.0, weight: .regular)
        descriptionLabel.textColor = .black
        descriptionLabel.text = "-"
        descriptionLabel.numberOfLines = 0
    }
}
