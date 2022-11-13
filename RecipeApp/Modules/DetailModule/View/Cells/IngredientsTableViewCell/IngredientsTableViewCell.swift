import UIKit

class IngredientsTableViewCell: UITableViewCell {
    
    // MARK: - UIViews
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    private var output: IngredientsOutput?
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
        configureTable()
    }
    
    // MARK: - Methods
    
    func setOutput(output: IngredientsOutput) {
        self.output = output
    }
    
}

// MARK: - Private methods

private extension IngredientsTableViewCell {
    func configureCell() {
        
    }
    
    func configureTable() {
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        
        tableView.register(UINib(nibName: "\(IngredientTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(IngredientTableViewCell.self)")
    }
}

// MARK: - UITableViewDataSource

extension IngredientsTableViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output?.getCountOfCells() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(IngredientTableViewCell.self)", for: indexPath) as? IngredientTableViewCell else {
            return UITableViewCell()
        }
        guard let item = output?.getRequest() else { return cell }
        cell.name = item.products[indexPath.item].nameImgredient
        let counts = String(item.products[indexPath.item].counts)
        cell.measurent = (counts == "0" ? "" : counts) + " " + item.products[indexPath.item].measurement[0].nameMeasurement
        return cell
    }

}

// MARK: - UITableViewDelegate

extension IngredientsTableViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 32.0
    }
}
