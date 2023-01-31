import Foundation

protocol SearchModuleViewInput: AnyObject {
    func setOutput(viewOutput: SearchModuleViewOutput)
    func reloadData()
    func showErrorMessage()
}
