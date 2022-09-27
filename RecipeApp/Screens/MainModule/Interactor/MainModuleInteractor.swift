import Foundation
import UIKit

class MainModuleInteractor {
    weak var interactorOutput: MainModuleInteractorOutput?
    
    var entity: Recipes? {
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
    
    func getPopularData(completion: @escaping (Recipes?, Error?) -> ()){
        let url = URL(string: "https://apex.oracle.com/pls/apex/dashashevchenkoapps/recipeapp/allRecipesMiniInfo")
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
            self.entity = try? jsonDecoder.decode(Recipes.self, from: data)
            print(self.entity)
            completion(self.entity, nil)
            
            DispatchQueue.main.sync {
                self.getImage()
            }
        }
        task.resume()
    }
    
    func getImage() {
        for i in 0..<self.entity!.items.count {
            guard let url = URL(string: self.entity!.items[i].urlImage) else { return }
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else { return }
                self.entity!.items[i].dataImage = UIImage(data: data)
            }
            task.resume()
        }
    }
}


// MARK: - MainModuleInteractorInput

extension MainModuleInteractor: MainModuleInteractorInput {
    
    func getRequestPopularRecipes(completion: @escaping (Recipes?, Error?) -> ()) {
        getPopularData { recipes, error in
            completion(recipes, error)
        }
    }
    
    func getCountOfPopularRecipes() -> Int {
        guard entity == nil else {
            return entity!.items.count
        }
        return 0
    }
    
    func getPopularData() -> Recipes? {
        guard let entity = entity else {
            return nil
        }
        return entity
    }
    
    
}
