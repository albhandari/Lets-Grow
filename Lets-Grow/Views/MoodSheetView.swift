//
//  MoodSheetView.swift
//  Lets-Grow
//
//  Created by Alex Bhandari on 12/13/24.
//

import SwiftUI

struct MoodSheetView: View {
    @EnvironmentObject var core: Core
    @State var selectedMood: String = ""

    let moodImages = Array(["mood_1", "mood_2", "mood_3", "mood_4", "mood_5"].reversed())
    let moodNames = ["Supercharged", "Energetic", "Neutral", "Distracted", "Exhausted"]

    var body: some View {
        let halfSize = (moodImages.count / 2) + 1
        
        VStack(spacing: 40) {
            Spacer()
            moodRow(from: 0, to: halfSize)
            moodRow(from: halfSize, to: moodImages.count)
                .padding(.bottom)
        }
        .background(imageBackground)

    }
    
    var imageBackground: some View {
        Image("mood_back")
            .resizable()
            .scaledToFill()
            .frame(width: 400, height: 500, alignment: .top)
            .clipped()
    }
    
    func moodRow(from: Int, to: Int) -> some View {
        HStack {
            ForEach(from..<to, id: \.self) { index in
                buttonIcon(imageIndex: index)
            }
        }
        .frame(height: 50)
    }
    
    func buttonIcon(imageIndex: Int) -> some View {
        Button(action: {
            selectedMood = moodImages[imageIndex] // Update selected mood
            
            updateTime(moodType: moodNames[imageIndex])
        }) {
            ZStack {
                Image(moodImages[imageIndex]) // Mood image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .background {
                        Circle().fill(selectedMood == moodImages[imageIndex]
                          ? Color.green.opacity(0.3)
                          : Color.clear
                        )
                    }
                Text(moodNames[imageIndex])
                    .padding(.top, 80)
                    .font(.custom("Noteworthy", size: 16))
                    .fontWeight(.semibold)
            }
        }
    }
    
    func updateTime(moodType: String, time: Int = 0){
        if moodType == "Supercharged"{
            core.totalTime = 35 * 60
            
        }
        else if moodType == "Energetic"{
            core.totalTime = 30 * 60
        }
        else if moodType == "Neutral"{
            core.totalTime = 25 * 60
        }
        else if moodType == "Distracted"{
            core.totalTime = 20 * 60
        }
        else if moodType == "Exhausted"{
            core.totalTime = 15 * 60
        }
        else{
            core.totalTime = Double(time * 60)
        }
        
        core.timeElapsed = 0
        core.isPaused = true
        core.isFinished = false
        core.userStopped = false
    }
}

#Preview {
    MoodSheetView()
}
