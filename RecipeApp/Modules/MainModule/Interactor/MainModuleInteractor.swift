import Foundation
import UIKit

class MainModuleInteractor: NetworkService {
    weak var interactorOutput: MainModuleInteractorOutput?
    
    var popularRecipesEntity: MainModuleEntity.Recipes? {
        didSet {
            interactorOutput?.changingData()
        }
    }
    
    // MARK: - Initialization
    
    init(interactorOutput: MainModuleInteractorOutput?) {
        self.interactorOutput = interactorOutput
    }
}

// MARK: - Private methods

private extension MainModuleInteractor {
    
    func getImage() {
        for i in 0..<self.popularRecipesEntity!.items.count {
            guard let url = URL(string: self.popularRecipesEntity!.items[i].urlImage) else { return }
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else { return }
                self.popularRecipesEntity!.items[i].dataImage = UIImage(data: data)
            }
            task.resume()
        }
    }
}


// MARK: - MainModuleInteractorInput

extension MainModuleInteractor: MainModuleInteractorInput {
    
    func getRequestPopularRecipes(completion: @escaping (MainModuleEntity.Recipes?, Error?) -> ()) {
        request(direction: urlAPIs.generalInfo) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let data):
                let recipe = try? JSONDecoder().decode(MainModuleEntity.Recipes.self, from: data)
                self.popularRecipesEntity = recipe
                for i in 0..<self.popularRecipesEntity!.items.count {
                    guard let url = URL(string: self.popularRecipesEntity!.items[i].urlImage) else { return }
                    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                        guard let data = data else { return }
                        self.popularRecipesEntity!.items[i].dataImage = UIImage(data: data)
                    }
                    task.resume()
                }
                completion(recipe, nil)
            case .failure(let error):
                completion(nil, error)
            }
            
        }
    }
    
    func getCountOfPopularRecipes() -> Int {
        guard popularRecipesEntity == nil else {
            return popularRecipesEntity!.items.count
        }
        return 0
    }
    
    func getPopularData() -> MainModuleEntity.Recipes? {
        guard let entity = popularRecipesEntity else {
            return nil
        }
        return entity
    }
    
    func getGeneralInfoInData(id: Int) -> (Data?, UIImage?) {
        guard let popularRecipesEntity = popularRecipesEntity else {
            return (nil, nil)
        }
        for i in popularRecipesEntity.items {
            if i.idRecipe == id {
                guard let data = try? JSONEncoder().encode(i) else {
                    return (nil, nil)
                }
                return (data, i.dataImage)
            }
        }
        return (nil, nil)
    }
    
    
}
