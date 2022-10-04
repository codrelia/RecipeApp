import Foundation
import UIKit

class MainModuleInteractor {
    weak var interactorOutput: MainModuleInteractorOutput?
    let api = "https://apex.oracle.com/pls/apex/dashashevchenkoapps/recipeapp"
    
    enum path: String {
        case popularGeneralInfo = "/popularGeneralInfo"
    }
    
    var popularRecipesEntity: Recipes? {
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
    
    func request(direction: path, completion: @escaping (Recipes?, Error?) -> ()){
        let url = URL(string: api + direction.rawValue)
        guard let url = url else {
            print("Optional url")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            self.popularRecipesEntity = try? jsonDecoder.decode(Recipes.self, from: data)
            completion(self.popularRecipesEntity, nil)
            
            DispatchQueue.main.sync {
                self.getImage()
            }
        }
        task.resume()
    }
    
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
    
    func getRequestPopularRecipes(completion: @escaping (Recipes?, Error?) -> ()) {
        request(direction: path.popularGeneralInfo) { recipes, error in
            completion(recipes, error)
        }
    }
    
    func getCountOfPopularRecipes() -> Int {
        guard popularRecipesEntity == nil else {
            return popularRecipesEntity!.items.count
        }
        return 0
    }
    
    func getPopularData() -> Recipes? {
        guard let entity = popularRecipesEntity else {
            return nil
        }
        return entity
    }
    
    
}
