
import SwiftUI

struct ProfileIconView: View {
    var body: some View {
        Image("profile")
            .resizable()
            .frame(width: 40, height: 40)
    }
}

#Preview {
    ProfileIconView()
}
