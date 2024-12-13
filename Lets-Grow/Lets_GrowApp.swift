//
//  Lets_GrowApp.swift
//  Lets-Grow
//
//  Created by Alex Bhandari on 12/8/24.
//

import SwiftUI

@main
struct Lets_GrowApp: App {
    @StateObject var core = Core()
        
        var body: some Scene {
            WindowGroup {
                
                if core.currentUser == nil {
                    AuthView()
                        .environmentObject(core)
                }else{
                    HomeView()
                        .environmentObject(core)
                }
//                ContentView()
//                    .environmentObject(core)
//                if core.userManager.currentUser == nil {
//                    LoginView()
//                        .environmentObject(core)
//                } else {
//                    HomeView()
//                        .environmentObject(core)
//                }
            }
        }
}
