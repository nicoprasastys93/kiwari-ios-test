//
//  Profile.swift
//  ChatAjaTest
//
//  Created by Nico Prasasty S on 05/03/20.
//  Copyright © 2020 Nico Prasasty Sembiring. All rights reserved.
//
struct Profile {
    var email: String?
    var name: String?
    var profileImage: String?
    var uid: String?
    
    init(email: String, name: String, profileImage: String, uid: String? = nil) {
        self.email = email
        self.name = name
        self.profileImage = profileImage
        self.uid = uid
    }
    
}
