import UIKit

class NavigationTableViewCell: UITableViewCell {
    
    // MARK: - UIViews
    
    @IBOutlet private weak var headerLabel: UILabel!
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var profileButton: UIButton!
    
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

private extension NavigationTableViewCell {
    func configureCell() {
        self.backgroundColor = customBackgroundColor
        
        headerLabel.tintColor = .black
        headerLabel.font = .systemFont(ofSize: 28, weight: .semibold)
        headerLabel.numberOfLines = 2
        
        searchButton.tintColor = mainColor
        searchButton.setImage(searchIconImage, for: .normal)
        
        profileButton.tintColor = mainColor
        profileButton.setImage(profileIconImage, for: .normal)
    }
}
