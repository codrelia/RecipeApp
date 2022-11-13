import Foundation
import UIKit

class DetailModulePresenter: UserDefaultsService {
    // MARK: - VIPERs elements
    
    var interactorInput: DetailModuleInteractorInput?
    var view: DetailViewController?
    weak var viewInput: DetailModuleViewInput?
    var routerInput: DetailRouterInput?
    
    
    // MARK: - Initialization
    
    init(view: DetailViewController, datas: (Data, UIImage)) {
        super.init()
        self.interactorInput = DetailModuleInteractor(interactorOutput: self)
        self.interactorInput?.setGeneralInfo(data: datas.0, image: datas.1)
        self.view = view
        self.viewInput = view
        
        self.viewInput?.setOutput(viewOutput: self)
    }
    
    // MARK: - Methods
    
    func setRouterInput(_ routerInput: DetailRouterInput) {
        self.routerInput = routerInput
    }
    
}

// MARK: - DetailModuleViewOutput

extension DetailModulePresenter: DetailModuleViewOutput {
    func getFavoritesRecipes() -> [Int] {
        return favoritesRecipes
    }
    
    func getFullRecipe() -> DetailModuleEntity.Info? {
        return interactorInput?.getDetailInfo()
    }
    
    func returnToBackScreen() {
        routerInput?.returnToBackScreen()
    }
    
    func getRequestDescriptionInfo() -> DetailModuleDescriptionEntity.Item? {
        guard let interactorInput = interactorInput else { return nil }
        var resultItem: DetailModuleDescriptionEntity.Item? = nil
        interactorInput.getRequestDescriptionInfo(completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let item):
                resultItem = item
            case .failure(_):
                self.viewInput?.showErrorMessage()
                resultItem = nil
            }
        })
        return resultItem
    }
    
    func getRequestIngredientsInfo() -> DetailModuleProductsEntity.Item? {
        guard let interactorInput = interactorInput else { return nil }
        var resultItem: DetailModuleProductsEntity.Item? = nil
        interactorInput.getRequestIngredientsInfo { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let item):
                resultItem = item
            case .failure(_):
                self.viewInput?.showErrorMessage()
                resultItem = nil
            }
        }
        return resultItem
    }
    
    func getRequestPreparationInfo() -> DetailModulePreparationEntity.Item? {
        guard let interactorInput = interactorInput else { return nil }
        var resultItem: DetailModulePreparationEntity.Item? = nil
        interactorInput.getRequestPreparationInfo { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let item):
                resultItem = item
            case .failure(_):
                self.viewInput?.showErrorMessage()
                resultItem = nil
            }
        }
        return resultItem

    }
    
    func getGeneralInfo() -> DetailModuleGeneralInfoEntity.Item? {
        interactorInput?.getGeneralInfo()
    }
}

// MARK: - DetailModuleInteractorOutput

extension DetailModulePresenter: DetailModuleInteractorOutput {
    func reloadDataInTable() {
        viewInput?.reloadData()
    }
    
    func reloadInformation() {
        viewInput?.reloadInformation()
    }
}
