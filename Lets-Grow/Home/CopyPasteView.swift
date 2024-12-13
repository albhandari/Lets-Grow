import SwiftUI


//HomeView
struct CopyPasteView: View {
    @State private var isMenuOpen = false
    @State private var showingLockdownPopup: Bool = false
    @EnvironmentObject var core: Core
    
    var body: some View {
        VStack(spacing: 20) {
            Image(core.currentUser?.equipedPet ?? "default_pet")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.red)

            Text("You have raised your pet!")
                .font(.headline)
                .foregroundColor(Color(red: 255 / 255, green: 184 / 255, blue: 195 / 255))
                .font(.custom("Noteworthy", size: 16))
                .fontWeight(.bold)

            Text("Congrats on your new pet! You have also earned 50 coins!")
                .font(.subheadline)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .font(.custom("Noteworthy", size: 16))
                .padding(.horizontal)
                .foregroundColor(Color(red: 255 / 255, green: 184 / 255, blue: 195 / 255).opacity(0.8))

            Button("Got it!") {
                withAnimation {
                    showingLockdownPopup = false
                    core.isFinished = false
                    core.addCoins(amount: 50)
                    core.completedTimer()
                    
                }
            }
            .padding()
            .background(Color(red: 255 / 255, green: 184 / 255, blue: 195 / 255))
            .foregroundColor(.white)
            .cornerRadius(10)
            .font(.custom("Noteworthy", size: 16))
            .fontWeight(.semibold)
        }
        .padding() //49/74/103
        .background(Color(red: 49 / 255, green: 74 / 255, blue: 103 / 255).opacity(0.9))
        .cornerRadius(20)
        .shadow(radius: 10)
        .transition(.opacity) // Smooth fade-out
        .animation(.easeInOut, value: showingLockdownPopup)
    }
}




#Preview {
    CopyPasteView()
        .environmentObject(Core())
}
