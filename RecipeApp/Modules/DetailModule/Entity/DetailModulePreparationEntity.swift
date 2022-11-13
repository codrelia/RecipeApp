import Foundation
import UIKit

class DetailModulePreparationEntity {
    // MARK: - Info
    struct Info: Codable {
        let items: [Item]
    }

    // MARK: - Item
    struct Item: Codable {
        var preparation: [Preparation]
    }

    // MARK: - Preparation
    struct Preparation: Codable {
        let step: Int
        let urlImage: String
        let preparationDescription: String
        
        var dataImage: UIImage?

        enum CodingKeys: String, CodingKey {
            case step, urlImage
            case preparationDescription = "description"
        }
    }
}
