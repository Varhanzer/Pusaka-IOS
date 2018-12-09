//
//  NetworkConst.swift
//  Pusaka
//
//  Created by Steven Bong on 24/11/18.
//  Copyright © 2018 Beneran Indonesia. All rights reserved.
//

import Foundation

struct NetworkConst {
    
    private static let url     = "http://api-dev.beneranindonesiapps.com"
    
    static let token           = url + "/token"
    static let login           = url + "/auth/signin"
    static let signup          = url + "/auth/signup"
    static let mission_list    = url + "/content/list"
    static let mission_get     = url + "/content/get"
    static let mission_take    = url + "/content/take"
    static let mission_ongoing = url + "/users/mission/list"
}
