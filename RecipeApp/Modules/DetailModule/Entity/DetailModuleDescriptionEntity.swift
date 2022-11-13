import Foundation

class DetailModuleDescriptionEntity {
    // MARK: - Info
    struct Info: Codable {
        let items: [Item]
    }

    // MARK: - Item
    struct Item: Codable {
        let idRecipe: Int
        let descriptionText: String
        let userInfo: [UserInfo]
        let caloricContent: [CaloricContent]
    }

    // MARK: - CaloricContent
    struct CaloricContent: Codable {
        let caloric, protein, fat, carbohydrates: Int
    }

    // MARK: - UserInfo
    struct UserInfo: Codable {
        let idUser: Int
        let nameUser: String?
    }
}
