//
//  DailyRewardsView.swift
//  Lets-Grow
//
//  Created by Alex Bhandari on 12/13/24.
//

import SwiftUI

struct DailyRewardsView: View {
    
    @EnvironmentObject var core: Core
    
    
    let columns = [GridItem(.fixed(70)), GridItem(.fixed(70)), GridItem(.fixed(70))]
    var body: some View {
        VStack {
            Spacer()
            // Middle Section: Paw Grid
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(0..<9) { index in
                    VStack(spacing: 5) {
                        // Paw Icon
                        Image(index < 1 ? "paw_filled" : "paw_empty")
                            .resizable()
                            .frame(width: 50, height: 50)

                        // Reward below the paw
                        HStack(spacing: 5) {
                            Image("coin")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text("x\(20 + index * 10)")
                                .font(.system(size: 15, weight: .semibold, design: .default))
                                .foregroundColor(.orange)
                        }
                    }
                }
            }
            .padding(.bottom, 20)
            
            // Bottom Section: "Collect" Button
            Button(action: {
                core.getRewards() // Mark reward as collected
            }) {
                Text(core.currentUser?.streak.isOver24Hrs ?? false ? "Collect" : "Collected")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .padding(8)
                    .frame(width: 100)
                    .background(!(core.currentUser?.streak.isOver24Hrs ?? false) ? Color.gray.opacity(0.5) : Color(red: 255 / 255, green: 184 / 255, blue: 195 / 255))
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .disabled(!(core.currentUser?.streak.isOver24Hrs ?? false))
            .padding(.bottom, 20)


            Spacer() // Pushes content upward to avoid crowding the bottom
        }
        .padding(.bottom, 200)
        .background(imageBackground)
    }
    
    var imageBackground: some View {
        Image("streak_background")
            .resizable()
            .scaledToFill()
            .padding(.bottom, 100)
            .padding(.leading, 10)
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
}

#Preview {
    DailyRewardsView()
}
