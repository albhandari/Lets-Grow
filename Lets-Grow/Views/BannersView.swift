//
//  BannersView.swift
//  Lets-Grow
//
//  Created by Alex Bhandari on 12/13/24.
//

import SwiftUI

struct BannersView: View {
    
    var body: some View {
        
        Text("Hello world")
        
    }
}

struct QuitView: View {
    
    @EnvironmentObject var core: Core
    
    var body: some View {
        
        VStack(spacing: 20) {
            Image("mission_icon")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .padding(.top, 20)

            Text("Your pet believes in you!")
                .font(.custom("Noteworthy", size: 16))
                .fontWeight(.bold)
                .foregroundColor(Color(red: 235 / 255, green: 138 / 255, blue: 170 / 255))

            Text("Stopping now will reset your progress, but your pet believes in you to stay focused!")
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 235 / 255, green: 138 / 255, blue: 170 / 255))
                .padding(.horizontal)
                .font(.custom("Noteworthy", size: 16))
                .fontWeight(.semibold)

            VStack(spacing: 15) { // Buttons in vertical stack
                // Stay Button
                Button(action: {
                    withAnimation {
                        core.userStopped = false
                    }
                }) {
                    Text("Stay")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity) // Matches parent width
                        .background(Color.green)
                        .cornerRadius(10)
                        .font(.custom("Noteworthy", size: 16))
                        .fontWeight(.semibold)
                }

                // Leave Button
                Button(action: {
                    withAnimation {
                        // Reset timer and progress
                        core.userQuits = true
                        core.userStopped = false
                    }
                }) {
                    Text("Leave")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity) // Matches parent width
                        .background(Color(red: 248 / 255, green: 66 / 255, blue: 66 / 255))
                        .cornerRadius(10)
                        .font(.custom("Noteworthy", size: 16))
                        .fontWeight(.semibold)
                }
            }
            .padding(.horizontal) // Align buttons within parent
        }
        .padding()
        .background(Color(red: 252 / 255, green: 245 / 255, blue: 234 / 255).opacity(0.9))
        .cornerRadius(20)
        .shadow(radius: 10)
        .frame(maxWidth: 300) // Ensures consistent size

        
    }
}

struct MissionFailedView: View {
    
    @EnvironmentObject var core: Core
    
    var body: some View {
        
        
        VStack(spacing: 20) {
            // Mission Failed Title
            Text("Mission Failed")
                .foregroundColor(.black)
                .fontWeight(.bold)
                .font(.custom("Noteworthy", size: 20))

            // Image: Pet Cry
            Image("pet_die")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 150)

            // Mission Failed Message
            Text("Your pet couldn't survive this time...")
                .foregroundColor(.black)
                .fontWeight(.bold)
                .font(.custom("Noteworthy", size: 16))
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)

            // Retry Button
            Button(action: {
                withAnimation {
                    core.userQuits = false
                    core.timeElapsed = 0
                    // Logic for retrying the mission
                }
            }) {
                Text("Retry")
                    .foregroundColor(.black)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 235 / 255, green: 138 / 255, blue: 170 / 255))
                    .cornerRadius(12)
                    .font(.custom("Noteworthy", size: 16))
                    .fontWeight(.bold)
            }

            // Dismiss Button
            Button(action: {
                withAnimation {
                    core.userQuits = false
                }
            }) {
                Text("Dismiss")
                    .foregroundColor(Color(red: 51 / 255, green: 51 / 255, blue: 51 / 255))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray)
                    .cornerRadius(12)
                    .font(.custom("Noteworthy", size: 16))
                    .fontWeight(.bold)
            }
        }
        .padding()
        .frame(width: 300, height: 450)
        .background(Color(red: 252 / 255, green: 245 / 255, blue: 234 / 255).opacity(0.9))
        .cornerRadius(20)
        .shadow(radius: 10)

        
    }
}



struct LockdownBannerView: View {
    
    @EnvironmentObject var core: Core
    
    var body: some View {
        VStack(spacing: 20) {
            Image("lock_on")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.red)

            Text("Lockdown Mode Activated")
                .font(.headline)
                .foregroundColor(Color(red: 235 / 255, green: 138 / 255, blue: 170 / 255))
                .font(.custom("Noteworthy", size: 16))
                .fontWeight(.bold)

            Text("Click here to go to the settings to customize your Screen Time")
                .font(.subheadline)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .font(.custom("Noteworthy", size: 16))
                .padding(.horizontal)
                .foregroundColor(Color(red: 235 / 255, green: 138 / 255, blue: 170 / 255))

            Button("Got it!") {
                core.showLockdown.toggle()
                if let appSettings = URL(string: "App-prefs:SCREEN_TIME"), UIApplication.shared.canOpenURL(appSettings) {
                        UIApplication.shared.open(appSettings)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(red: 235 / 255, green: 138 / 255, blue: 170 / 255))
            .foregroundColor(.white)
            .cornerRadius(10)
            .font(.custom("Noteworthy", size: 16))
            .fontWeight(.semibold)
        }
        .padding()
        .background(Color(red: 252 / 255, green: 245 / 255, blue: 234 / 255).opacity(0.9))
        .cornerRadius(20)
        .shadow(radius: 10)
        .frame(maxWidth: 300)
    }
}

#Preview {
    MissionFailedView()
}
