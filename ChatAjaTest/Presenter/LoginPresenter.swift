
import Firebase

protocol LoginDelegate {
    func singInSuccess(_ loginPresenter: LoginPresenter, success: Bool, message: String?)
    func singInAnimation(hidden: Bool)
}

class LoginPresenter {
    var delegate: LoginDelegate?
    var profile: Profile?
    var contactList: [Profile] = []
    
    
    func validateSignIn(user: LoginModel){
        guard let email = user.email, let password = user.password else {return}
        
        if email == "" || password == ""{
            delegate?.singInSuccess(self, success: false, message: "email or password is empty")
        }
        
        self.delegate?.singInAnimation(hidden: false)
        
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in

            
            if error != nil{
                self.delegate?.singInSuccess(self, success: false, message: "The password is invalid or the user does not have a password")
                return
            }
            
            Database.database().reference().child("User").observe(.value, with: { (snapshot) in
                self.delegate?.singInAnimation(hidden: true)
                
                if let snap = snapshot.value as? [String: AnyObject]{
                    if let uid = Auth.auth().currentUser?.uid{
                        if let user = snap[uid] as? [String: AnyObject]{
                            self.profile = Profile(email: user["email"] as! String, name: user["name"] as! String, profileImage: user["profileImage"] as! String, uid: uid)
                        }
                        
                        let contacts = snap.filter{$0.key != uid}
                        
                        contacts.forEach { (user) in
                            self.contactList.append(Profile(email: user.value["email"] as! String, name: user.value["name"] as! String, profileImage: user.value["profileImage"] as! String, uid: user.key))
                        }
                    }
                }
                self.delegate?.singInSuccess(self, success: true, message: nil)
            }, withCancel: nil)
            
        }
    }
}
