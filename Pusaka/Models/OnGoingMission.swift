//
//  OnGoingMission.swift
//  Pusaka
//
//  Created by Steven Bong on 29/11/18.
//  Copyright © 2018 Beneran Indonesia. All rights reserved.
//

import Foundation

struct OnGoingMission: Decodable {
    let orgName      : String
    let misName      : String
    let dayStart     : String
    let pointValue   : String
    let missionStatus: String
    let missionID    : Int
    let pointID      : String
}
