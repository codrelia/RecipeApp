import UIKit

class PreparationsTableViewCell: UITableViewCell {
    
    // MARK: - UIViews
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    private var output: PreparationOutput?
    
    // MARK: - Initialization

    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
        configureTable()
    }
    
    // MARK: - Methods
    
    func setOutput(output: PreparationOutput) {
        self.output = output
    }
    
}

// MARK: - Private methods

private extension PreparationsTableViewCell {
    func configureCell() {
        
    }
    
    func configureTable() {
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.register(UINib(nibName: "\(PreparationTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(PreparationTableViewCell.self)")
    }
}

// MARK: - UITableViewDataSource

extension PreparationsTableViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output?.getCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(PreparationTableViewCell.self)", for: indexPath) as? PreparationTableViewCell else {
            return UITableViewCell()
        }
        guard let item = output?.getRequest() else { return cell }
        cell.step = item.preparation[indexPath.row].step
        cell.image = item.preparation[indexPath.row].dataImage
        cell.descriptionText = item.preparation[indexPath.row].preparationDescription
        return cell
    }
    
    
}
