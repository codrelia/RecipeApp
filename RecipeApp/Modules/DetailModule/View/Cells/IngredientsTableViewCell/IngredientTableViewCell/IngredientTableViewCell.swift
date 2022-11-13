import UIKit

class IngredientTableViewCell: UITableViewCell {
    
    // MARK: - UIViews
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var measurentLabel: UILabel!
    
    // MARK: - Properties
    var name: String = "" {
        didSet {
            nameLabel.text = name
        }
    }
    
    var measurent: String = "" {
        didSet {
            measurentLabel.text = measurent
        }
    }
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureCell()
    }
    
}

// MARK: - Private extension

private extension IngredientTableViewCell {
    func configureCell() {
        nameLabel.font = .systemFont(ofSize: 14.0, weight: .medium)
        nameLabel.textColor = .black
        nameLabel.text = "-"
        
        measurentLabel.font = .systemFont(ofSize: 12.0, weight: .medium)
        measurentLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    }
}
