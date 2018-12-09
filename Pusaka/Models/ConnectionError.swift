//
//  ConnectionError.swift
//  Pusaka
//
//  Created by Steven Bong on 24/11/18.
//  Copyright © 2018 Beneran Indonesia. All rights reserved.
//

import Foundation

struct ConnectionError {
    let errorCode: Int
    let errorMessage: String
    init(errorCode: Int, errorMessage: String) {
        self.errorCode    = errorCode
        self.errorMessage = errorMessage
    }
}
