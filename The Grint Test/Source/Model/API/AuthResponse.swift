//
//  AuthResponse.swift
//  The Grint Test
//
//  Created by Pedro Toro on 4/5/24.
//

import Foundation

struct AuthResponse: Decodable {
    let token: String
    
    enum CodingKeys: String, CodingKey {
        case token = "access_token"
    }
    
}


