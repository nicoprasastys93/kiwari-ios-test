//
//  ViewController.swift
//  ChatAjaTest
//
//  Created by Nico Prasasty S on 03/03/20.
//  Copyright © 2020 Nico Prasasty Sembiring. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    @IBOutlet weak var outletTFEmail: UITextField!
    @IBOutlet weak var outletTFPassword: UITextField!
    
    let loginPresenter = LoginPresenter()
    
    var loading: Loading!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginPresenter.delegate = self
        
        loading = Loading(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        loading.center = self.view.center
        self.view.addSubview(loading)
        self.view.bringSubviewToFront(loading)
    }

    @IBAction func actionButtonLogin(_ sender: Any) {
        loginPresenter.validateSignIn(user: LoginModel(email: outletTFEmail.text!, password: outletTFPassword.text!))
    }
}

extension LoginController: LoginDelegate{
    
    func singInSuccess(_ loginPresenter: LoginPresenter, success: Bool, message: String?) {
        if success{
            let main = UIStoryboard(name: "Main", bundle: nil)
            let contact = main.instantiateViewController(identifier: "ContactController") as! ContactController
            contact.contackPresenter = ContactPresenter(profile: loginPresenter.profile!, contactList: loginPresenter.contactList)
            
            let navChat = UINavigationController(rootViewController: contact)
            navChat.modalPresentationStyle = .fullScreen
            present(navChat, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func singInAnimation(hidden: Bool) {
        loading.isHidden = hidden
    }
}
