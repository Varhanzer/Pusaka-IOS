//
//  MissionDetail.swift
//  Pusaka
//
//  Created by Steven Bong on 25/11/18.
//  Copyright © 2018 Beneran Indonesia. All rights reserved.
//

import Foundation

struct MissionDetail: Decodable {
    var missionTypeID : Int
    var orgName       : String
    var misName       : String
    var misImage      : String
    var misDesc       : String
    var latitude      : Double
    var longitude     : Double
    var dayStart      : String
    var dayEnd        : String
    var maxParticipant: String
    var applicants    : String
    var misAddress    : String
    var misPlace      : String
    var pointValue    : String
    var missionStatus : String
}
