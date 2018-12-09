//
//  File.swift
//  Pusaka
//
//  Created by Steven Bong on 24/11/18.
//  Copyright © 2018 Beneran Indonesia. All rights reserved.
//

import Foundation

struct MissionList: Decodable {
    var profile    : Profile?
    var listContent: [Mission]
    
    enum Keys: CodingKey {
        case profile
        case listContent
    }
    
    init(from decoder: Decoder) {
        do {
            let container    = try decoder.container(keyedBy: Keys.self)
            self.profile     = try container.decodeIfPresent(Profile.self, forKey: .profile)
            self.listContent = try container.decodeIfPresent([Mission].self, forKey: .listContent) ?? []
        } catch let error {
            print(error)
            self.profile = nil
            self.listContent = []
        }

    }
}

struct Profile: Decodable {
    var nickName    : String
    var fullName    : String
    var nextMission : String
    var schoolName  : String
    var point       : String
    var imageFile   : String
}

struct Mission: Decodable {
    var missionID      : String
    var missionTypeID  : String
    var misName        : String
    var misImage       : String
    var misDesc        : String
    var reviewCount    : String
    var point          : String
    var dayStart       : String
    var maxParticipant : String
    var applicants     : String
}
