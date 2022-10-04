import Foundation
import UIKit

// MARK: - Recipes
struct Recipes: Codable {
    var items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let idRecipe: Int
    let nameRecipe: String
    let urlImage: String
    let timeCooking: Int
    let category: [Category]
    let rating: Double
    let caloricContent: [CaloricContent]
    
    var dataImage: UIImage? = nil
    
    enum CodingKeys: CodingKey {
        case idRecipe
        case nameRecipe
        case urlImage
        case timeCooking
        case category
        case rating
        case caloricContent
    }
}

// MARK: - CaloricContent
struct CaloricContent: Codable {
    let caloric: Int
}

// MARK: - Category
struct Category: Codable {
    let idCategory: Int
    let nameCategory: String
}
