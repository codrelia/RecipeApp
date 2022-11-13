import Foundation

protocol DetailModuleViewInput: AnyObject {
    func setOutput(viewOutput: DetailModuleViewOutput)
    func showErrorMessage()
    func reloadData()
    func reloadInformation()
}
