import UIKit

class FilterDetailTableViewCell: UITableViewCell {
    
    // MARK: - UIView
    
    private let filter = FiltersCollection(["Описание", "Ингредиенты", "Приготовление"], CGRect(
        x: 0,
        y: 0,
        width: UIScreen.main.bounds.width,
        height: 32))
    
    // MARK: - Lyfecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Methods
    
    func setOutput(output: FiltersCollectionOutput) {
        filter.setOutput(output: output)
    }
}

// MARK: - Private methods

private extension FilterDetailTableViewCell {
    func configureCell() {
        filter.backgroundColor = .clear
        backgroundColor = customBackgroundColor
        addSubview(filter)
        
        filter.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10000)
    }
}
