//
//  ContentView.swift
//  Lets-Grow
//
//  Created by Alex Bhandari on 12/8/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 8) {
            // Main Image with price tag
            ZStack(alignment: .topTrailing) {
                Image("pet_box")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 150)

                // Price tag at the top right
                HStack(spacing: 4) {
                    Image("coin") // Coin icon
                        .resizable()
                        .frame(width: 16, height: 16) // Adjust size as needed

                    Text("100")
                        .foregroundColor(Color(hex: "#FFD700")) // Gold color for the total
                        .font(.system(size: 14, weight: .bold))
                }
                .padding(6)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                )
                .offset(x: -8, y: 8) // Adjust position
            }

            // Item Name with background
            Text("Item Name")
                .foregroundColor(Color(hex: "#2D8CFB")) // Text color
                .padding(6)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(hex: "#FCF5EA")) // Background color
                )
        }
        .padding()
        .background(Color.white.opacity(0.3))
        .cornerRadius(10)
    }
}

// Extension to use hex colors in SwiftUI


#Preview {
    ContentView()
}
