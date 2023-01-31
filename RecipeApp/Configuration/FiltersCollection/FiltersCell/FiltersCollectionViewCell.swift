import UIKit

class FiltersCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UIViews

    @IBOutlet weak var nameInCollection: UILabel!
    
    let indicator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.263, green: 0.306, blue: 0.039, alpha: 1)
        view.frame.size = CGSize(width: 40, height: 6)
        view.layer.cornerRadius = 3
        
        return view
    }()
    
    // MARK: - Properties
    
    var name: String = "" {
        didSet {
            nameInCollection.text = name
        }
    }
    
    private var color: UIColor = .gray {
        didSet {
            nameInCollection.textColor = color
        }
    }
    
    var colorOfIndicator: UIColor = .black {
        didSet {
            indicator.backgroundColor = colorOfIndicator
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureCell()
        backgroundColor = .clear
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                color = .black
                addSubview(indicator)
                animationSelectIndicator()
            } else {
                color = .gray
                animationDeselectIndicator()
            }
        }
    }
}

// MARK: - Private extension

private extension FiltersCollectionViewCell {
    func configureCell() {
        nameInCollection.font = .systemFont(ofSize: 14, weight: .medium)
        nameInCollection.textColor = .gray
    }
}

// MARK: - Animations

private extension FiltersCollectionViewCell {
    
    func animationSelectIndicator() {
        self.indicator.transform = CGAffineTransform(scaleX: 0.001, y: 1)
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [.curveEaseInOut]) {
            self.indicator.transform = CGAffineTransform.identity
            //self.nameInCollection.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }
    }
    
    func animationDeselectIndicator() {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [.curveEaseInOut]) {
            self.indicator.transform = CGAffineTransform(scaleX: 0.001, y: 1)
           // self.nameInCollection.transform = CGAffineTransform.identity
        } completion: { _ in
            self.indicator.transform = CGAffineTransform.identity
            self.indicator.removeFromSuperview()
        }
    }
}
