import UIKit

class ErrorMessage: UIView {
    
    // MARK: - UIViews
    
    private var errorMessage = UILabel()
    
    // MARK: - Properties
    
    var text = "" {
        didSet {
            errorMessage.text = text
            errorMessage.sizeToFit()
            errorMessage.center.x = center.x
            errorMessage.center.y = center.y + 10
        }
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureMessage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func startAnimation() {
        transform = CGAffineTransform(translationX: 0.0, y: -frame.height)
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseInOut]) {
            self.transform = CGAffineTransform.identity
        } completion: { _ in
            UIView.animate(withDuration: 1.0, delay: 5.0, options: [.curveEaseInOut]) {
                self.transform = CGAffineTransform(translationX: 0.0, y: -self.frame.height)
            } completion: { _ in
                self.removeFromSuperview()
                self.transform = .identity
            }

        }

    }
}

// MARK: - Private methods

private extension ErrorMessage {
    func configureMessage() {
        backgroundColor = backgroundErrorColor
        
        errorMessage.font = .systemFont(ofSize: 14, weight: .regular)
        errorMessage.textColor = .white
        errorMessage.numberOfLines = 2
        errorMessage.textAlignment = .center
        
        addSubview(errorMessage)
    }
}
