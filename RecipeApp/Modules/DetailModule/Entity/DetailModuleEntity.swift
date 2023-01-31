import Foundation
import UIKit

class DetailModuleEntity {
    // MARK: - Info
    struct Info: Codable {
        var items: [Item]
    }

    // MARK: - Item
    struct Item: Codable {
        let idRecipe: Int
        let nameRecipe: String
        let urlImage: String
        let descriptionText: String
        let timeCooking: Int
        let category: [Category]
        let userInfo: [UserInfo]
        let rating: Int
        let caloricContent: [CaloricContent]
        let products: [Product]
        let preparation: [Preparation]
        
        var image: UIImage?
        
        enum CodingKeys: CodingKey {
            case idRecipe
            case nameRecipe
            case urlImage
            case descriptionText
            case timeCooking
            case category
            case userInfo
            case rating
            case caloricContent
            case products
            case preparation
        }
    }

    // MARK: - CaloricContent
    struct CaloricContent: Codable {
        let caloric, protein, fat, carbohydrates: Int
    }

    // MARK: - Category
    struct Category: Codable {
        let idCategory: Int
        let nameCategory: String
    }

    // MARK: - Preparation
    struct Preparation: Codable {
        let step: Int
        let urlImage: String
        let preparationDescription: String
        
        var image: UIImage?

        enum CodingKeys: String, CodingKey {
            case step, urlImage
            case preparationDescription = "description"
        }
    }

    // MARK: - Product
    struct Product: Codable {
        let idIngredient: Int
        let nameImgredient: String
        let counts: Int
        let measurement: [Measurement]
    }

    // MARK: - Measurement
    struct Measurement: Codable {
        let idMeasurement: Int
        let nameMeasurement: String
    }

    // MARK: - UserInfo
    struct UserInfo: Codable {
        let idUser: Int
        let nameUser: String
    }

    
}
