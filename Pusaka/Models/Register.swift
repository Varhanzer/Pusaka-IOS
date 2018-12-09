//
//  Register.swift
//  Pusaka
//
//  Created by Steven Bong on 01/12/18.
//  Copyright © 2018 Beneran Indonesia. All rights reserved.
//

import Foundation

struct Register: Decodable {
    var userID: String
    
    enum Keys: String, CodingKey {
        case userID
    }
    
    init(from decoder: Decoder) throws {
        let container  = try decoder.container(keyedBy: Keys.self)
        self.userID    = try container.decodeIfPresent(String.self, forKey: .userID) ?? ""
    }
}
