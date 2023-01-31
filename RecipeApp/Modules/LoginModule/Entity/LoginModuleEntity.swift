import Foundation

final class LoginModuleEntity {
    // MARK: - CheckLogin
    struct CheckLogin: Codable {
        let isindb: String
        let links: [Link]
    }

    // MARK: - Link
    struct Link: Codable {
        let rel: String
        let href: String
    }
    
    
}
