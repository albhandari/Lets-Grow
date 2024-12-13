import SwiftUI

struct HomeView: View {
    @EnvironmentObject var core: Core
    @State private var isMenuOpen = false
    @State private var showingStreak = false
    @State private var showingMoodInput = false
    @State private var showingRegularInput = false
    @State private var showingPomodoro = false
    
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .leading) {
                // Your original background and content
                ZStack {
                    Image("background_home")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                    
                    VStack {
                        // Top Navigation, Coins, and Profile
                        HStack {
                            HamburgerButton {
                                withAnimation {
                                    isMenuOpen.toggle()
                                }
                            }
                            Spacer()
                            
                            HStack {
                                CoinView(totalCoin: core.currentUser?.coins.defaultCoin ?? 0000)
                                NavigationLink(destination: ProfileView()) {
                                    ProfileIconView()
                                }
                                    
                            }
                        }
                        .padding([.top, .horizontal], 30)
                        
                        // Items above the timer
                        HStack {
                            
                            NavigationLink(destination: SpotifyView()) {
                                Image("music_icon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 70, height: 60)
                            }
                            
                            Image("lock_off")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 70, height: 70)
                                .onTapGesture {
                                    core.showLockdown.toggle()
                                }
                            
                            Image("calendar")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 70, height: 60)
                                .onTapGesture {
                                    showingStreak.toggle()
                                }
                            
                        }
                        
                        TimerView(equippedPet: core.currentUser?.equipedPet ?? "default_pet")
                            .frame(height: 400)
                        
                        Spacer()
                        
                        HStack {
                            IconTextView(iconName: "Regular", iconImage: "regular_mode_icon")
                                .padding(.horizontal)
                                .onTapGesture {
                                    showingRegularInput.toggle()
                                }
                            IconTextView(iconName: "Pomodoro", iconImage: "pomodoro_mode_icon")
                                .onTapGesture {
                                    showingPomodoro.toggle()
                                }
                            IconTextView(iconName: "Mood", iconImage: "mood_mode_icon")
                                .padding(.horizontal)
                                .onTapGesture {
                                    showingMoodInput.toggle()
                                }
                        }
                        
                        Spacer()
                    }
                }
                
                // Dimmed overlay and side menu appear on top
                if isMenuOpen {
                    // Dimmed overlay
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation {
                                isMenuOpen = false
                            }
                        }

                    // Side Menu
                    SideMenuView(isMenuOpen: $isMenuOpen)
                        .frame(width: UIScreen.main.bounds.width / 2)
                        .offset(x: isMenuOpen ? 0 : -UIScreen.main.bounds.width / 2)
                        .transition(.move(edge: .leading))
                        .animation(.easeInOut(duration: 0.3), value: isMenuOpen)
                }
                
                //When timer is done banner
                if core.isFinished{
                    ZStack{
                        Color.black.opacity(0.6)
                            .edgesIgnoringSafeArea(.all)
                        CopyPasteView()
                    }
                    
                }
                
                //Lockdown mode banner
                if core.showLockdown{
                    ZStack{
                        Color.black.opacity(0.6)
                            .edgesIgnoringSafeArea(.all)
                        LockdownBannerView()
                    }
                }
                
                if core.userStopped{
                    ZStack{
                        Color.black.opacity(0.6)
                            .edgesIgnoringSafeArea(.all)
                        QuitView()
                    }
                }
                
                if core.userQuits{
                    ZStack{
                        Color.black.opacity(0.6)
                            .edgesIgnoringSafeArea(.all)
                        MissionFailedView()
                    }
                }
            }
            .sheet(isPresented: $showingStreak) {
                DailyRewardsView()
                    .presentationDetents([
                        .custom(CustomDetent.self) // or .fraction(0.999)
                    ])
                    .presentationBackground(.clear)
            }
            .sheet(isPresented: $showingMoodInput) {
                MoodSheetView()
                    .presentationDetents([.height(330)])
                    .presentationBackground(.clear)
            }
            .sheet(isPresented: $showingRegularInput) {
                NormalTimerSheetView()
                    .presentationDetents([.height(330)])
                    
            }
            .sheet(isPresented: $showingPomodoro) {
                PomodoroSheetView()
                    .presentationDetents([.height(330)])
                    
            }
        }
    }
    
    struct CustomDetent: CustomPresentationDetent {
        static func height(in context: Context) -> CGFloat? {
            return context.maxDetentValue - 1
        }
    }
    
}




#Preview {
    HomeView()
        .environmentObject(Core())
}
