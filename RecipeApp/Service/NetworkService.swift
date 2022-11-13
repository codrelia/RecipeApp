import Foundation

class NetworkService {
    
    let cacheForData = NSCache<NSString, NSData>()
    let defForService = UserDefaults.standard
    
    let api = "https://apex.oracle.com/pls/apex/dashashevchenkoapps/recipeapp"
    
    enum urlAPIs: String {
        case generalInfo = "/popularGeneralInfo"
        case fullInfo = "/getFullInfo?id_recipe="
        case description = "/description?id_recipe="
        case products = "/products?id_recipe="
        case preparation = "/preparation?id_recipe="
    }
    
    enum errors: String, Error {
        case selfError = "selfError"
    }
    
    func request(direction: urlAPIs, completion: @escaping (Result<Data, Error>) -> ()){
        if let data = defForService.object(forKey: direction.rawValue) as? Data, let date = defForService.object(forKey: direction.rawValue + "time") as? Date {
            let currentDate = Date()
            if date.distance(to: currentDate) / 60.0 < 60 {
                completion(.success(data))
                return
            }
        }
        let url = URL(string: api + direction.rawValue)
        guard let url = url else {
            print("Optional url")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else {
                return
            }
            guard let data = data else {
                completion(.failure(error!))
                return
            }
            DispatchQueue.main.async {
                let date = Date()
                self.defForService.setValue(data, forKey: direction.rawValue)
                self.defForService.setValue(date, forKey: direction.rawValue + "time")
            }
            completion(.success(data))
            
        }
        task.resume()
    }
    
    func request(direction: urlAPIs, parameter: String, completion: @escaping (Result<Data, Error>) -> ()) {
        if let data = defForService.object(forKey: direction.rawValue + parameter) as? Data, let date = defForService.object(forKey: direction.rawValue + parameter + "time") as? Date {
            let currentDate = Date()
            if date.distance(to: currentDate) / 60.0 < 60 {
                completion(.success(data))
                return
            }
        }
        let url = URL(string: api + direction.rawValue + parameter)
        guard let url = url else {
            print("Optional url")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion(.failure(error!))
                return
            }
            DispatchQueue.main.async {
                let date = Date()
                self.defForService.setValue(data, forKey: direction.rawValue + parameter)
                self.defForService.setValue(date, forKey: direction.rawValue + parameter + "time")
            }
            completion(.success(data))
            
        }
        task.resume()
    }
    
    func request(urlString: String, completion: @escaping (Result<Data, Error>) -> ()){
        if let data = defForService.object(forKey: urlString) as? Data, let date = defForService.object(forKey: urlString + "time") as? Date {
            let currentDate = Date()
            if date.distance(to: currentDate) / 60.0 < 60 {
                completion(.success(data))
                return
            }
        }
        let url = URL(string: urlString)
        guard let url = url else {
            print("Optional url")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion(.failure(error!))
                return
            }
            DispatchQueue.main.async {
                let date = Date()
                self.defForService.setValue(data, forKey: urlString)
                self.defForService.setValue(date, forKey: urlString + "time")
            }
            completion(.success(data))
            
        }
        task.resume()
    }
}
