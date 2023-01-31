import Foundation
import UIKit

class SearchModuleInteractor: NetworkService {
    // MARK: - VIPERs elements
    weak var interactorOutput: SearchModuleInteractorOutput?
    var searchEntity: SearchModuleEntity.Recipes? {
        didSet {
            interactorOutput?.reloadTable()
        }
    }
    
    // MARK: - Initialization
    init(interactorOutput: SearchModuleInteractorOutput) {
        self.interactorOutput = interactorOutput
    }
}

// MARK: - SearchModuleInteractorInput

extension SearchModuleInteractor: SearchModuleInteractorInput {
    func getRequestSearch(completion: @escaping (Result<SearchModuleEntity.Recipes?, Error>) -> ()) {
        if searchEntity != nil {
            return completion(.success(searchEntity))
        }
        request(direction: .search) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let data):
                self.searchEntity = try? JSONDecoder().decode(SearchModuleEntity.Recipes.self, from: data)
                guard let count = self.searchEntity?.items.count else {
                    return
                }
                for i in 0..<count {
                    self.request(urlString: self.searchEntity!.items[i].urlImage) { [weak self] result in
                        guard let self = self else {
                            return
                        }
                        switch result {
                        case .success(let data):
                            self.searchEntity?.items[i].image = UIImage(data: data)
                        case .failure(_):
                            return
                        }
                    }
                }
                completion(.success(self.searchEntity))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func countOfRecipes(searchText: String) -> Int? {
        guard let searchEntity = searchEntity else {
            return 0
        }
        if searchText == "" {
            return searchEntity.items.count
        }
        var filteredItems = searchEntity.items.filter {$0.nameRecipe.lowercased().contains(searchText.lowercased())}
        if filteredItems.count == 0 {
            return nil
        } else {
            return filteredItems.count
        }
    }
    
    func getGeneralInfoInData(id: Int) -> (Data?, UIImage?) {
        guard let popularRecipesEntity = searchEntity else {
            return (nil, nil)
        }
        for i in popularRecipesEntity.items {
            if i.idRecipe == id {
                guard let data = try? JSONEncoder().encode(i) else {
                    return (nil, nil)
                }
                return (data, i.image)
            }
        }
        return (nil, nil)
    }
}
