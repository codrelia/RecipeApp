import UIKit

class SearchFilterTableViewCell: UITableViewCell {
    
    private let filter = FiltersCollection(["Все", "Первые блюда", "Вторые блюда", "Закуски", "Салаты", "Соусы, крема", "Напитки", "Десерты", "Выпечка"],
                                           CGRect(
                                            x: 0,
                                            y: 0,
                                            width: UIScreen.main.bounds.width,
                                            height: 32
                                           )
    )
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

// MARK: - Private methods

private extension SearchFilterTableViewCell {
    func configureCell() {
        filter.backgroundColor = .clear
        backgroundColor = .clear
        addSubview(filter)
        
        filter.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .centeredHorizontally)
    }
}
