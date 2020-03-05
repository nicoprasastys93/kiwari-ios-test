
struct LoginModel {
    var email: String?
    var password: String?
    var profile: Profile?
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
