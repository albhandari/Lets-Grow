//
//  HamburgerButton.swift
//  Lets-Grow
//
//  Created by Alex Bhandari on 12/12/24.
//

import SwiftUI

struct HamburgerButton: View {
    var action: () -> Void // Callback for button action

    var body: some View {
        Button(action: action) {
            Image(systemName: "line.horizontal.3") // SF Symbol for hamburger icon
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24) // Set the size of the icon
                .foregroundColor(.black) // Change the color if needed
        }
        .padding() // Add some padding
    }
    
    func printStuff(){}
}

#Preview {
    HamburgerButton{
        print("Hello World")
    }
}
