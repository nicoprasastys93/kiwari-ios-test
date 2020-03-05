//
//  ContactController.swift
//  ChatAjaTest
//
//  Created by Nico Prasasty S on 05/03/20.
//  Copyright © 2020 Nico Prasasty Sembiring. All rights reserved.
//

import UIKit

class ContactController: UITableViewController {
    var contackPresenter: ContactPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contackPresenter?.delegate = self
        navigationItem.title = "Chat Aja"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(hadleLogout))
    }
    
    @objc fileprivate func hadleLogout(){
        contackPresenter!.logout()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else{
            return contackPresenter?.contactList?.count ?? 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as! ContactCell
        if indexPath.section == 0{
            cell.profile = contackPresenter?.myProfile
        }else{
            
            cell.profile = contackPresenter?.contactList![indexPath.row]
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1{
            let main = UIStoryboard(name: "Main", bundle: nil)
            let chat = main.instantiateViewController(identifier: "ChatController") as! ChatController
            chat.chatPresenter = ChatPresenter(profile: (contackPresenter?.contactList![indexPath.row])!, currentUser: (contackPresenter?.myProfile!)!)
            self.navigationController?.pushViewController(chat, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.selectionStyle = .none
        if indexPath.section == 1{
            tableView.separatorInset = UIEdgeInsets(top: 0, left: 70, bottom: 0, right: 0)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "Profil"
        }else{
            return "Contact"
        }
    }
}

extension ContactController: ContactDelegate{
    func logout(success: Bool) {
        if success{
            let main = UIStoryboard(name: "Main", bundle: nil)
            let loginVC =  main.instantiateViewController(identifier: "LoginViewController") as! LoginController
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: true, completion: nil)
        }
    }
}
