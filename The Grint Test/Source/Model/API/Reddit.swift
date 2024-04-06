import Foundation

struct Reddit: Codable {
    let data: Listing

    enum CodingKeys: String, CodingKey {
        case data
    }
    
}
