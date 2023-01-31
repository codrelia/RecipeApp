import UIKit

class NavigationTableViewCell: UITableViewCell {
    
    // MARK: - UIViews
    
    @IBOutlet private weak var headerLabel: UILabel!
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var profileButton: UIButton!
    
    // MARK: - Properties
    
    weak var navigationOutput: NavigationOutput?
    
    var title: String = "" {
        didSet {
            headerLabel.text = title
        }
    }
    
    var isButtons: Bool = true {
        didSet {
            searchButton.isHidden = isButtons
            profileButton.isHidden = isButtons
        }
    }
    
    // MARK: - Lyfecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureCell()
    }
    
    // MARK: - Actions
    
    @IBAction func tapOnSearchButton(_ sender: Any) {
        navigationOutput?.pushSearchScreen()
    }
    
    @IBAction func tapOnProfileButton(_ sender: Any) {
        navigationOutput?.pushProfileScreen()
    }
    // MARK: - Methods
    
    func setOutput(_ navigationOutput: NavigationOutput) {
        self.navigationOutput = navigationOutput
    }
    
    func getSearchButton() -> UIButton {
        return searchButton
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
        searchButton.backgroundColor = .clear
        
        profileButton.tintColor = mainColor
        profileButton.setImage(profileIconImage, for: .normal)
        
        selectionStyle = .none
    }
}
