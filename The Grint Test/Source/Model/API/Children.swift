import Foundation

struct Children: Codable {
	let post: Post
   
	enum CodingKeys: String, CodingKey {
		case post = "data"
	}
    
}
