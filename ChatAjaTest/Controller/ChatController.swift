//
//  ChatController.swift
//  ChatAjaTest
//
//  Created by Nico Prasasty S on 03/03/20.
//  Copyright © 2020 Nico Prasasty Sembiring. All rights reserved.
//

import UIKit
import SDWebImage

class ChatController: UIViewController {
    @IBOutlet weak var outletConstrainButtom: NSLayoutConstraint!
    @IBOutlet weak var outletTextfieldMessage: UITextField!{
        didSet{
            outletTextfieldMessage.placeholder = "Enter Message"
            outletTextfieldMessage.autocorrectionType = .no
            outletTextfieldMessage.delegate = self
        }
    }
    @IBOutlet weak var outletButtomMessage: UIButton!{
        didSet{
            outletButtomMessage.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        }
    }
    @IBOutlet weak var outletTableView: UITableView!{
        didSet{
            outletTableView.dataSource = self
            outletTableView.delegate = self
        }
    }
    
    var chatPresenter: ChatPresenter?
    
    var messages: [Message]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatPresenter!.delegate = self
        chatPresenter?.observeMessage()
        setupNavBar()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeybord), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeybord), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    fileprivate func setupNavBar(){
        let titleView = UIView()
        titleView.translatesAutoresizingMaskIntoConstraints = true
        navigationItem.titleView = titleView
        titleView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        titleView.widthAnchor.constraint(equalToConstant: self.view.frame.width - 100).isActive = true
        
        var outletImageAvatar: UIImageView!
        outletImageAvatar = UIImageView(image: UIImage())
        outletImageAvatar.contentMode = .scaleAspectFit
        outletImageAvatar.frame = CGRect(x: 5, y: 2, width: 40, height: 40)
        outletImageAvatar.layer.cornerRadius = outletImageAvatar.frame.height/2
        outletImageAvatar.layer.masksToBounds = true
        outletImageAvatar.sd_setImage(with: URL(string: (chatPresenter?.opponentUser!.profileImage)!), completed: nil)
        titleView.addSubview(outletImageAvatar)
        
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        titleView.addSubview(stack)
        stack.topAnchor.constraint(equalTo: titleView.topAnchor, constant: 2).isActive = true
        stack.leadingAnchor.constraint(equalTo: outletImageAvatar.trailingAnchor, constant: 5).isActive = true
        stack.bottomAnchor.constraint(equalTo: titleView.bottomAnchor, constant: -2).isActive = true
        stack.trailingAnchor.constraint(equalTo: titleView.trailingAnchor, constant: -5).isActive = true
        
        var outletLabelName: UILabel!
        outletLabelName = UILabel()
        outletLabelName.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        outletLabelName.textColor = .black
        outletLabelName.text = chatPresenter?.opponentUser?.name
        stack.addArrangedSubview(outletLabelName)
        
        var outletLabelStatus: UILabel!
        outletLabelStatus = UILabel()
        outletLabelStatus.font = UIFont.systemFont(ofSize: 12, weight: .thin)
        outletLabelStatus.textColor = .black
        outletLabelStatus.text = "Busy"
        stack.addArrangedSubview(outletLabelStatus)
        
        navigationItem.title = ""
        
    }
    
    @objc fileprivate func handleKeybord(notification: Notification){
        if let userInfo = notification.userInfo{
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
            
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            
            let safe = view.safeAreaInsets
            outletConstrainButtom.constant = isKeyboardShowing ? -keyboardFrame.height+safe.bottom:0
            print(safe)
            UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    @objc fileprivate func sendMessage(){
        chatPresenter?.sendMessage(message: self.outletTextfieldMessage.text!)
        self.outletTextfieldMessage.text = ""
    }
    
    fileprivate func moveToBottom(){
        self.outletTableView.performBatchUpdates({
            let lastIndex = NSIndexPath(row: self.messages!.count - 1, section: 0)
            self.outletTableView.scrollToRow(at: lastIndex as IndexPath, at: .bottom, animated: true)
        }, completion: nil)
    }
}


extension ChatController: ChatDelegate{
    func showMessage(message: [Message]) {
        self.messages = message
        self.outletTableView.reloadData()
        self.moveToBottom()
    }
}

extension ChatController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        chatPresenter?.sendMessage(message: textField.text!)
        return textField.resignFirstResponder()
    }
}

extension ChatController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! ChatCell
        cell.message = messages![indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        outletTextfieldMessage.endEditing(true)
    }
}
