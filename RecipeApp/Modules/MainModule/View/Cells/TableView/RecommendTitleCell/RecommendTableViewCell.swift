import UIKit

class RecommendTableViewCell: UITableViewCell {

    // MARK: - UIViews
    
    @IBOutlet private weak var headerLabel: UILabel!
    
    // MARK: - Properties
    
    var title: String = "" {
        didSet {
            headerLabel.text = title
        }
    }
    
    // MARK: - Lyfecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureCell()
    }
    
}

// MARK: - Private methods

private extension RecommendTableViewCell {
    func configureCell() {
        headerLabel.tintColor = .black
        headerLabel.font = .systemFont(ofSize: 28, weight: .semibold)
        headerLabel.numberOfLines = 1
        
        backgroundColor = customBackgroundColor
        
        selectionStyle = .none
    }
}
