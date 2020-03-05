//
//  ChatPresenter.swift
//  ChatAjaTest
//
//  Created by Nico Prasasty S on 04/03/20.
//  Copyright © 2020 Nico Prasasty Sembiring. All rights reserved.
//
import FirebaseDatabase
import FirebaseAuth

protocol ChatDelegate: class {
    func showMessage(message: [Message])
}

class ChatPresenter {
    var delegate: ChatDelegate?
    
    var currentUser: Profile?
    var opponentUser: Profile?
    
    private var messages: [Message]?
    
    init(profile: Profile, currentUser: Profile) {
        self.opponentUser = profile
        self.currentUser = currentUser
    }
    
    func sendMessage(message: String){
        let ref = Database.database().reference().child("messages")
        let chieldRef = ref.childByAutoId()
        
        let toID = opponentUser?.uid
        let fromID = Auth.auth().currentUser?.uid
        let time = String(NSDate().timeIntervalSince1970)
        let values = [
            "toId" : toID,
            "fromID": fromID,
            "name": currentUser?.name,
            "text": message,
            "time": time,
        ] as [String: AnyObject]
        chieldRef.updateChildValues(values)
        
    }
    
    func observeMessage(){
        self.messages = [Message]()
        let ref = Database.database().reference().child("messages")
        ref.observe(.childAdded, with: { (snapshot) in
            if let dic = snapshot.value as? [String: AnyObject]{
                var message = Message()
                message.fromID = dic["fromID"] as? String
                message.text = dic["text"] as? String
                message.time = dic["time"] as? String
                message.toID = dic["toId"] as? String
                message.name = dic["name"] as? String
                
                self.messages?.append(message)
                
                DispatchQueue.main.async {
                    self.delegate?.showMessage(message: self.messages!)
                }
            }
        }, withCancel: nil)
    }
}
