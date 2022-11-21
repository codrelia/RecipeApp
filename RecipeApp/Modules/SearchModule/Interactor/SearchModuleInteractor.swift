import Foundation

class SearchModuleInteractor {
    // MARK: - VIPERs elements
    weak var interactorOutput: SearchModuleInteractorOutput?
    
    init(interactorOutput: SearchModuleInteractorOutput) {
        self.interactorOutput = interactorOutput
    }
}

// MARK: - SearchModuleInteractorInput

extension SearchModuleInteractor: SearchModuleInteractorInput {
    
}
