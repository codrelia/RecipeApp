import Foundation
import UIKit

class DetailModuleInteractor: NetworkService {
    var interactorOutput: DetailModuleInteractorOutput?
    var entity: DetailModuleEntity.Info? {
        didSet {
            interactorOutput?.reloadDataInTable()
        }
    }
    var generalEntity: DetailModuleGeneralInfoEntity.Item? {
        didSet {
            interactorOutput?.reloadDataInTable()
        }
    }
    var descriptionEntity: DetailModuleDescriptionEntity.Item? {
        didSet {
            interactorOutput?.reloadInformation()
        }
    }
    
    var ingredientsEntity: DetailModuleProductsEntity.Item? {
        didSet {
            interactorOutput?.reloadInformation()
        }
    }
    
    var preparationEntity: DetailModulePreparationEntity.Item? {
        didSet {
            interactorOutput?.reloadInformation()
        }
    }
    
    init(interactorOutput: DetailModuleInteractorOutput?) {
        self.interactorOutput = interactorOutput
    }
}

// MARK: - Private methods

private extension DetailModuleInteractor {
    
}

// MARK: - DetailModuleInteractorInput

extension DetailModuleInteractor: DetailModuleInteractorInput {
    func getDetailInfo() -> DetailModuleEntity.Info? {
        return entity
    }
    
    func setGeneralInfo(data: Data, image: UIImage) {
        generalEntity = try? JSONDecoder().decode(DetailModuleGeneralInfoEntity.Item.self, from: data)
        generalEntity?.dataImage = image
    }
    
    func getGeneralInfo() -> DetailModuleGeneralInfoEntity.Item? {
        return generalEntity
    }
    
    func getRequestDescriptionInfo(completion: @escaping (Result<DetailModuleDescriptionEntity.Item, Error>) -> ()) {
        guard let generalEntity = generalEntity else {
            return
        }
        if descriptionEntity != nil {
            completion(.success(descriptionEntity!))
            return
        }
        request(direction: .description, parameter: String(generalEntity.idRecipe)) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.descriptionEntity = try? JSONDecoder().decode(DetailModuleDescriptionEntity.Info.self, from: data).items[0]
                    completion(.success(self.descriptionEntity!))
                    self.interactorOutput?.reloadInformation()
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getRequestIngredientsInfo(completion: @escaping (Result<DetailModuleProductsEntity.Item, Error>) -> ()) {
        guard let generalEntity = generalEntity else {
            return
        }
        if ingredientsEntity != nil {
            completion(.success(ingredientsEntity!))
            return
        }
        request(direction: .products, parameter: String(generalEntity.idRecipe)) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.ingredientsEntity = try? JSONDecoder().decode(DetailModuleProductsEntity.Info.self, from: data).items[0]
                    completion(.success(self.ingredientsEntity!))
                    self.interactorOutput?.reloadInformation()
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getRequestPreparationInfo(completion: @escaping (Result<DetailModulePreparationEntity.Item, Error>) -> ()) {
        guard let generalEntity = generalEntity else {
            return
        }
        if preparationEntity != nil {
            completion(.success(preparationEntity!))
            return
        }
        request(direction: .preparation, parameter: String(generalEntity.idRecipe)) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.preparationEntity = try? JSONDecoder().decode(DetailModulePreparationEntity.Info.self, from: data).items[0]
                    for i in 0..<self.preparationEntity!.preparation.count {
                        self.request(urlString: self.preparationEntity!.preparation[i].urlImage) { [weak self] result in
                            guard let self = self else {
                                return
                            }
                            switch result {
                            case .success(let data):
                                self.preparationEntity!.preparation[i].dataImage = UIImage(data: data)
                            case .failure(_):
                                self.preparationEntity!.preparation[i].dataImage = nil
                            }
                        }
                    }
                    completion(.success(self.preparationEntity!))
                    self.interactorOutput?.reloadInformation()
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
