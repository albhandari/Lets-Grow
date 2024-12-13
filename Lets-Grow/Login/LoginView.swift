import SwiftUI

struct LoginView: View {
    @EnvironmentObject var core: Core
    @StateObject var loginViewModel = LoginViewModel()
    
    var body: some View {
        VStack {
            Text("Login Here")
            
            TextField("Email", text: $loginViewModel.email)
                .textInputAutocapitalization(.never)
            
            SecureField("Password", text: $loginViewModel.password)
            
//            Button("Login"){
//                core.updateUser(email: loginViewModel.email, password: loginViewModel.password)
//            }
            
        }
        .padding()
    }
}
