import SwiftUI
import Combine

struct TimerView: View {
    @EnvironmentObject var core: Core
    
    let equippedPet: String
    
    @State private var timerCancellable: AnyCancellable?
    
    var body: some View {
        VStack{
            GeometryReader { geometry in
                let size = min(geometry.size.width, geometry.size.height) * 0.7
                let progress = fractionElapsed()
                
                ZStack {
                    // Background circle
                    Circle()
                        .stroke(Color.gray.opacity(0.3), lineWidth: 10)
                    
                    // Progress circle
                    Circle()
                        .trim(from: 0.0, to: CGFloat(progress))
                        .stroke(Color(red: 126 / 255, green: 182 / 255, blue: 247 / 255), style: StrokeStyle(lineWidth: 10, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                    
                    // The image inside based on progress
                    getImageForProgress(progress: progress, equippedPet: equippedPet)
                        .resizable()
                        .scaledToFit()
                        .frame(width: size * 0.6, height: size * 0.6)
                    
                }
                .frame(width: size, height: size)
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                
                
                
                
            }
            //.background(.red)
            .frame(height: 300)
            
            Text(formatTimeRemaining())
                .font(.system(size: 48, weight: .bold, design: .rounded)) // Large, rounded font
                .foregroundColor(Color(red: 33 / 255, green: 105 / 255, blue: 208 / 255)) // Custom blue color
                .shadow(color: Color.black.opacity(0.3), radius: 4, x: 0, y: 2) // Subtle shadow for depth
                .padding(.horizontal, 30)
                .padding(.top,5)
            
            HStack{
                
                if core.isPaused{
                    
                    Button(action: {
                        // Add your button action here
                        unpauseTimer()
                    }) {
                            
                        Image("pause_button")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 85, height: 85)
                            .foregroundColor(.red)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    
                }else{
                    Button(action: {
                        // Add your button action here
                        pauseTimer()
                    }) {
                            
                        Image("pause_button")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 85, height: 85)
                            .foregroundColor(.red)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                Button(action: {
                    // Add your button action here
                    stopTimer()
                }) {
                        
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35, height: 35)
                        .foregroundColor(.red)
                }
                .buttonStyle(PlainButtonStyle())
                
                
            }
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
    }
    
    
    func stopTimer() {
        timerCancellable?.cancel()
        timerCancellable = nil
        core.isPaused = true
        core.userStopped = true
    }
    
    func pauseTimer(){
        timerCancellable?.cancel()
        core.isPaused = true
    }
    
    func unpauseTimer(){
        core.isPaused = false
        timerCancellable?.cancel()
        timerCancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                tick()
            }
        
    }
    
    func userDidStop(){
        timerCancellable?.cancel()
        timerCancellable = nil
        core.timeElapsed = 0
        core.isPaused = true
        core.isFinished = false
        core.userStopped = false
        core.userQuits = false
        
    }
    
    
    func tick() {
        print(core.timeElapsed)
        print(core.totalTime)
        print(core.isFinished)
        print(core.isPaused)
        print("---")
        
        if(core.isPaused){
            pauseTimer()
        }
        else if (core.userQuits){
            userDidStop()
        }
        else{
            core.timeElapsed += 1
            if core.timeElapsed >= core.totalTime {
                core.timeElapsed = 0
                core.isFinished = true
                core.isPaused = true
                pauseTimer()
            }
        }
    
    }
    
    func fractionElapsed() -> Double {
        guard core.totalTime > 0 else { return 0 }
        return min(core.timeElapsed / core.totalTime, 1.0)
    }
    
    func getImageForProgress(progress: Double, equippedPet: String) -> Image {
        // Logic:
        // 0% to <25%: egg
        // 25% to <50%: egg_cracking
        // 50% to <90%: equippedPet_stage_3
        // 90% to 100%: equippedPet
        switch progress {
        case let p where p >= 0.9:
            return Image(equippedPet)
        case let p where p >= 0.5:
            return Image("\(equippedPet)_stage_3")
        case let p where p >= 0.25:
            return Image("egg_cracking")
        default:
            return Image("egg")
        }
    }
    
    func formatTimeRemaining() -> String {
        let timeLeft = max(core.totalTime - Double(core.timeElapsed), 0)
            let minutes = Int(timeLeft) / 60
            let seconds = Int(timeLeft) % 60
            return String(format: "%02d:%02d", minutes, seconds)
        }
}

#Preview {
    TimerView(equippedPet: "default_pet")
        .environmentObject(Core())
}
