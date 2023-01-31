import UIKit

class SearchNavigationTableViewCell: UITableViewCell {
    
    // MARK: - UIViews
    
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var searchView: UIView!
    
    // MARK: - Properties
    
    weak var output: SearchNavigationOutput?
    
    // MARK: - Initialization

    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureCell()
    }
    
    // MARK: - Methods
    
    func setOutput(output: SearchNavigationOutput?) {
        self.output = output
    }
    
    func getSearchButton() -> UIButton {
        return searchButton
    }
    
    // MARK: - Actions
    
    @IBAction func tapOnBackButton(_ sender: Any) {
        output?.tapOnBackButton()
    }
    
    @IBAction func searchChanged(_ sender: Any) {
        if let searchText = searchTextField.text {
            output?.setFilterPhrase(searchText: searchText)
        }
    }
}

// MARK: - Private methods

private extension SearchNavigationTableViewCell {
    func configureCell() {
        backgroundColor = .clear
        
        searchButton.tintColor = mainColor
        searchButton.setImage(searchIconImage, for: .normal)
        searchButton.backgroundColor = .clear
        
        backButton.contentMode = .scaleAspectFill
        backButton.tintColor = mainColor
        backButton.setImage(backLeftImage, for: .normal)
        
        searchView.layer.cornerRadius = 20.0
        
        searchTextField.placeholder = "Например, салат из спаржи"
    }
}
