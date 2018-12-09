//
//  UserManager.swift
//  Pusaka
//
//  Created by Steven Bong on 24/11/18.
//  Copyright © 2018 Beneran Indonesia. All rights reserved.
//

import Foundation

class UserManager {
    private let key_profile = "UserManager.User"
    
    private var user: User?
    private let userDefaults = UserDefaults.standard
    
    static let shared = UserManager()
    
    func isLoggedIn() -> Bool {
        return user != nil
    }
    
    func saveUser(user: User) {
        guard let userJSON = try? JSONEncoder().encode(user) else { return }
        userDefaults.set(userJSON, forKey: key_profile)
    }
    
    func logout() {
        userDefaults.removeObject(forKey: key_profile)
    }
    
    func getUser() {
        guard let userJSON = userDefaults.data(forKey: key_profile) else { return }
        self.user = try? JSONDecoder().decode(User.self, from: userJSON)
    }
    
    var userID: String {
        return user?.userID ?? ""
    }
    
    var userImage: String {
        return user?.imageFile ?? ""
    }
    
    var nickname: String {
        return user?.nickName ?? ""
    }
    
    
    
    
    
}
