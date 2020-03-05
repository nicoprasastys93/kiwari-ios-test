//
//  ContactPresenter.swift
//  ChatAjaTest
//
//  Created by Nico Prasasty S on 05/03/20.
//  Copyright © 2020 Nico Prasasty Sembiring. All rights reserved.
//
import FirebaseAuth
import FirebaseDatabase

protocol ContactDelegate {
    func logout(success: Bool)
}
class ContactPresenter {
    var delegate: ContactDelegate?
    
    var myProfile: Profile?
    
    var contactList: [Profile]?
    
    init(profile: Profile, contactList: [Profile]) {
        self.myProfile = profile
        self.contactList = contactList
    }
    
    func logout(){
        do{
            try Auth.auth().signOut()
        }catch let error{
            print(error)
            delegate?.logout(success: false)
        }
        delegate?.logout(success: true)
    }
}
