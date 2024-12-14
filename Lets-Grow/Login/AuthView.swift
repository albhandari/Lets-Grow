import SwiftUI

struct AuthView: View {
    @EnvironmentObject var core: Core
    @State private var selectedSegment = 0 // 0 = Login, 1 = Register
    
    // Login fields
    @State private var loginEmail = ""
    @State private var loginPassword = ""
    @State private var loginFailed = false
    
    // Register fields
    @State private var registerUsername = ""
    @State private var registerEmail = ""
    @State private var registerPassword = ""
    @State private var registerFailed = false
    
    var body: some View {
        VStack {
            Picker("Auth Picker", selection: $selectedSegment) {
                Text("Login").tag(0)
                Text("Register").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            if selectedSegment == 0 {
                
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .foregroundColor(.blue)
                    .padding(.bottom, 20)
                
                // Login UI
                TextField("Email", text: $loginEmail)
                    .font(.custom("Noteworthy", size: 20))
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .textInputAutocapitalization(.never)
                
                SecureField("Password", text: $loginPassword)
                    .font(.custom("Noteworthy", size: 20))
                    .padding([.horizontal, .bottom])
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Button(action: {
                    
                    let success = core.authenticateUser(email: loginEmail, password: loginPassword)
                    if !success {
                        loginFailed = true
                    }
                }) {
                    Text("Login")
                        .font(.custom("Noteworthy", size: 20)) // Ensure a size is specified for the custom font
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(red: 45/255, green: 140/255, blue: 251/255)) // RGB(45, 140, 251)
                        .cornerRadius(8)
                        .padding(.horizontal, 30)
                }
                .padding(.bottom, 10)
                .alert(isPresented: $loginFailed) {
                    Alert(title: Text("Login Failed"), message: Text("Invalid credentials."))
                }
                
                
        
                
            } else {
                // Register UI
                
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .foregroundColor(.blue)
                    .padding(.bottom, 20)
                
                TextField("Username", text: $registerUsername)
                    .font(.custom("Noteworthy", size: 20))
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .textInputAutocapitalization(.never)
                TextField("Email", text: $registerEmail)
                    .font(.custom("Noteworthy", size: 20))
                    .padding(.horizontal)
                    .background(Color.white.opacity(0.8))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding([.horizontal, .bottom])
                    .textInputAutocapitalization(.never)
                SecureField("Password", text: $registerPassword)
                    .font(.custom("Noteworthy", size: 20))
                    .padding([.horizontal, .bottom])
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                
                Button(action: {
                    let success = core.userManager.register(username: registerUsername, email: registerEmail.lowercased(), password: registerPassword)
                    if !success {
                        registerFailed = true
                    } else {
                        selectedSegment = 0
                    }
                    
                }) {
                    Text("Register")
                        .font(.custom("Noteworthy", size: 20)) // Ensure a size is specified for the custom font
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(red: 45/255, green: 140/255, blue: 251/255)) // RGB(45, 140, 251)
                        .cornerRadius(8)
                        .padding(.horizontal, 30)
                }
                .padding(.bottom, 10)
                .alert(isPresented: $registerFailed) {
                    Alert(title: Text("Register Failed"), message: Text("User with this email already exists."))
                }
        
            }
        }
        .padding()
    }
}


#Preview {
    AuthView()
        .environmentObject(Core())
}
