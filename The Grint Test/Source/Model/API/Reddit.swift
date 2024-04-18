import Foundation

struct Reddit: Codable {
    let kind: String
    let data: Listing

    enum CodingKeys: String, CodingKey {
        case data
        case kind
    }
    
}
