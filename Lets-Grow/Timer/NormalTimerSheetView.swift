import SwiftUI

struct NormalTimerSheetView: View{
    
    @State var selectedMinutes: Int = 25
    @EnvironmentObject var core: Core
    
    
    var body: some View{
        ZStack{
            Color(red: 250 / 255, green: 245 / 255, blue: 234 / 255)
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                Picker("Select Minutes", selection: $selectedMinutes) {
                    ForEach(1...120, id: \.self) { minute in
                        Text("\(minute) minutes").tag(minute)
                    }
                }
                .labelsHidden()
                .pickerStyle(WheelPickerStyle())
                .frame(height: 150)
                
                Button(action: {
                    core.totalTime = Double(selectedMinutes * 60)
                    core.timeElapsed = 0
                    core.isPaused = true
                    core.isFinished = false
                    core.userStopped = false
                }) {
                    Text("Set Time")
                        .font(.title2)
                        .padding()
                        .background(Color(red: 255 / 255, green: 184 / 255, blue: 195 / 255))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            
           
        }
        
    }
}

#Preview {
    NormalTimerSheetView()
}
