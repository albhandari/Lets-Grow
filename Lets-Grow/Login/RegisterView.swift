import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var core: Core
    @Environment(\.dismiss) var dismiss
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var registrationFailed = false
    
    var body: some View {
        VStack {
            Text("Register").font(.largeTitle)
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Create Account") {
                let success = core.userManager.register(username: username, email: email, password: password)
                if success {
                    dismiss()
                } else {
                    registrationFailed = true
                }
            }
            .alert(isPresented: $registrationFailed) {
                Alert(title: Text("Registration Failed"), message: Text("User with this email already exists"))
            }
        }
        .padding()
    }
}
