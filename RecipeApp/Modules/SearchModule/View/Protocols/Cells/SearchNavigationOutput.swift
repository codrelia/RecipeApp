import Foundation

protocol SearchNavigationOutput: AnyObject {
    func tapOnBackButton()
    func setFilterPhrase(searchText: String)
}
