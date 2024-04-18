import Foundation

class Listing: Codable {
   
    let after: String?
    let dist: Int?
    var children: [Children]
    let before: String?
    
    init(after: String?, dist: Int?, children: [Children], before: String?) {
        self.after = after
        self.dist = dist
        self.children = children
        self.before = before
    }
    
    enum CodingKeys: String, CodingKey {
        case after
        case dist
        case children
        case before
    }
    
}

