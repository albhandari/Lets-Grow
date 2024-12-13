
import Foundation

class LoginViewModel: ObservableObject{
    @Published var email = ""
    @Published var password = ""
    @Published var loginFailed = false
    @Published var showingRegister = false
    
    init(){}
    
    func toggleLoginFailed(){
        self.loginFailed.toggle()
    }
    
    func toggleRegisterView(){
        self.showingRegister.toggle()
    }

}

