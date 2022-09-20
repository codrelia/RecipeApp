import UIKit

class NavigationBar: UINavigationBar {
    
    // MARK: - Constants
    
    private enum Constants {
        static let fontSize = 28.0
    }
    
    // MARK: - UIViews
    
    let titleLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: Constants.fontSize, weight: .semibold)
        label.numberOfLines = 0
        label.text = nil
        label.sizeToFit()
        return label
        
    }()
    
    let buttonSearch: UIButton = {
        var button = UIButton()
        button.setBackgroundImage(searchIconImage, for: .normal)
        button.tintColor = mainColor
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }()
    
    let buttonProfile: UIButton = {
        var button = UIButton()
        button.setBackgroundImage(profileIconImage, for: .normal)
        button.tintColor = mainColor
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }()

    var navigationBar: UIView = {
        var view = UIView()
        view.backgroundColor = .clear
        
        return view
    }()
    
    // MARK: - Lyfecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        navigationBar.frame = frame
        addSubview(navigationBar)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupMainTitle(_ title: String, _ point: CGPoint) {
        titleLabel.text = title
        titleLabel.frame = CGRect(x: point.x, y: point.y, width: titleLabel.frame.width, height: titleLabel.frame.height)
        titleLabel.sizeToFit()
        titleLabel.center.y = navigationBar.center.y
        navigationBar.addSubview(titleLabel)
    }
    
    func setupButtons(_ frame: CGRect, _ marginEdges: Double) {
        buttonSearch.frame = CGRect(
            x: navigationBar.frame.width - (marginEdges + frame.width / 2.0) * 2 - frame.width / 2.0,
            y: navigationBar.center.y - titleLabel.frame.height / 2.0,
            width: frame.width,
            height: frame.height)
        
        navigationBar.addSubview(buttonSearch)
        
        buttonProfile.frame = CGRect(
            x: navigationBar.frame.width - (marginEdges + frame.width / 2.0) * 1 - frame.width / 2.0,
            y: navigationBar.center.y - titleLabel.frame.height / 2.0,
            width: frame.width,
            height: frame.height)
        
        navigationBar.addSubview(buttonProfile)
    }
    
}
