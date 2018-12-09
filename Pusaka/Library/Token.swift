//
//  Token.swift
//  Pusaka
//
//  Created by Steven Bong on 24/11/18.
//  Copyright © 2018 Beneran Indonesia. All rights reserved.
//

import Foundation

struct TokenManager {
    static var access_token: String?
    static var token_type  : String?
    static var expires_in  : Int?
    static var sid         : String?
}

struct Token: Decodable {
    var access_token: String
    var token_type  : String
    var expires_in  : Int
    var sid         : String?
    var encrypted   : Bool?
    
    enum Keys: CodingKey {
        case access_token
        case token_type
        case expires_in
    }
    
    init(from decoder: Decoder) throws {
        let container     = try decoder.container(keyedBy: Keys.self)
        self.access_token = try container.decodeIfPresent(String.self, forKey: .access_token) ?? ""
        self.token_type   = try container.decodeIfPresent(String.self, forKey: .token_type) ?? ""
        self.expires_in   = try container.decodeIfPresent(Int.self, forKey: .expires_in) ?? 0
        
        let access_tokens = self.access_token.components(separatedBy: ".")
        if access_tokens.count > 1, let decoded = Data(base64Encoded: access_tokens[1]) {
            let tokenJson = try JSONSerialization.jsonObject(with: decoded, options: []) as! [String:Any]
            self.sid = tokenJson["sid"] as? String
            self.encrypted = ((tokenJson["prod"] as? String) ?? "0") == "1"
        }
    }
}
