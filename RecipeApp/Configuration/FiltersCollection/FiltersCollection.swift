import Foundation
import UIKit

class FiltersCollection: UICollectionView {
    
    // MARK: - Properties
    
    private var items: [String] = []
    private var indexOfActiveElement = IndexPath(item: 0, section: 0)
    private var output: FiltersCollectionOutput?
    
    // MARK: - Initialization
    
    init(_ items: [String], _ frame: CGRect) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        super.init(frame: frame, collectionViewLayout: flowLayout)
        
        self.items = items
        self.frame = frame
        
        self.setupCells()
        self.configureCollection()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func setOutput(output: FiltersCollectionOutput) {
        self.output = output
    }
    
    func getCurrentActiveElements() -> Int {
        return indexOfActiveElement.item
    }
    
}

// MARK: - Private methods

private extension FiltersCollection {
    func configureCollection() {
        dataSource = self
        delegate = self
        
        showsHorizontalScrollIndicator = false
    }
    
    func setupCells() {
        self.register(UINib(nibName: "\(FiltersCollectionViewCell.self)", bundle: .main), forCellWithReuseIdentifier: "\(FiltersCollectionViewCell.self)")
    }
    
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension FiltersCollection: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: "\(FiltersCollectionViewCell.self)", for: indexPath)
        guard let cell = cell as? FiltersCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let label = UILabel()
        label.text = items[indexPath.row]
        label.sizeToFit()
        
        if collectionView.indexPathsForSelectedItems?.contains(indexPath) ?? false {
            cell.isSelected = true
            cell.indicator.frame = CGRect(x: 0, y: 0, width: label.frame.width + 16, height: 2)
            cell.indicator.center = CGPoint(x: label.frame.width / 2.0 + 20, y: cell.frame.height - 2)
        } else {
            cell.isSelected = false
        }
        cell.name = items[indexPath.row]
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel()
        label.text = items[indexPath.row]
        label.sizeToFit()
        label.frame = CGRect(x: 0, y: 0, width: label.frame.width + 40, height: label.frame.height + 4)
        return CGSize(width: label.frame.width, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? FiltersCollectionViewCell else {
            return
        }
        
        let label = UILabel()
        label.text = items[indexPath.row]
        label.sizeToFit()
        
        cell.indicator.frame = CGRect(x: 0, y: 0, width: label.frame.width + 16, height: 2)
        cell.indicator.center = CGPoint(x: label.frame.width / 2.0 + 20, y: cell.frame.height - 2)
        
        scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        indexOfActiveElement = indexPath
        output?.tapOnFiltersButton(itemCount: indexPath.item)
    }
    
    
    
}

