import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var core: Core
    

    var body: some View {
        VStack(spacing: 20) {
            
            // Profile Image
            Image("profile")
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 120)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.blue.opacity(0.6), lineWidth: 4)
                )
                .shadow(radius: 10)

            // Username
            Text(core.currentUser?.username ?? "User not logged in")
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundColor(Color.blue)

            // Email
            Text(core.currentUser?.email ?? "Email")
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .foregroundColor(.gray)

            // Stats Section
            HStack(spacing: 30) {
                Spacer()
                VStack {
                    Text("Total Pets")
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .foregroundColor(.gray)
                    Text("\(core.currentUser?.ownedItems.count ?? 5)")
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .foregroundColor(Color.green)
                }

                VStack {
                    Text("Study Time")
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .foregroundColor(.gray)
                    Text(core.currentUser?.totalFocusTime() ?? "12h 30m")
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .foregroundColor(Color.orange)
                }
                
                Spacer()
            }
            .padding(.top, 10)
            
            Spacer()
            
            if let focusSessions = core.currentUser?.focusSessions{
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(focusSessions) { session in
                            HStack {
                                VStack(alignment: .leading, spacing: 5) {
                                    // Display date of focus session
                                    Text("Date: \(formattedDate(from: session.dateCompleted))")
                                        .font(.headline)
                                        .foregroundColor(.blue)

                                    // Display duration of focus session
                                    Text("Duration: \(formattedDuration(from: session.duration))")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        }
                    }
                    .padding()
                }
            }
            
            HStack {
                Menu("Select an organization") {
                    Button("San Jose State University", action: {})
                    Button("Starbucks", action: {})
                }
                .font(.headline)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)

                Button("Join") {
                    // No action needed
                }
                .font(.headline)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding(.vertical)

            // Logout button
            Button("Logout") {
                core.userManager.logout()
                core.currentUser = nil
            }
            .font(.headline)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            
            
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemGray6))
                .shadow(radius: 10)
        )
        .padding(.horizontal)
    
    }
    
    private func formattedDate(from date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            return formatter.string(from: date)
        }

        // Helper function to format duration in "Xh Xm" or "Xm"
        private func formattedDuration(from seconds: Int) -> String {
            if seconds < 60 {
                return "\(seconds)s"
            } else {
                let minutes = seconds / 60
                let remainingSeconds = seconds % 60
                return "\(minutes)m \(remainingSeconds)s"
            }
        }
}


#Preview {
    ProfileView().environmentObject(Core())
}
