import Foundation

class DetailModuleProductsEntity {
    // MARK: - Info
    struct Info: Codable {
        let items: [Item]
    }
    
    // MARK: - Item
    struct Item: Codable {
        let products: [Product]
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
}
