import Foundation

class Core: ObservableObject {
    @Published var userManager: UserManager
    
    @Published var currentUser: User? = nil
    
    // Timer-related properties
    @Published var totalTime: Double = 10
    @Published var timeElapsed: Double = 0
    @Published var isPaused: Bool = true
    @Published var isFinished: Bool = false
    @Published var userStopped: Bool = false
    
    //if timerIsFinished is true then put a popup for "Oh wow you got coins!" and when usr clicks ok in the popup set isFinished to false
    
    
    //Banners and Notif
    @Published var showLockdown = false
    @Published var userQuits = false
    
    
    
    init() {
        let userDefaultsService = UserDefaultsService()
        self.userManager = UserManager(userDefaultsService: userDefaultsService)
        // The printing of the entire data happens during UserManager init via loadUsersData()
    }
    
    func authenticateUser(email: String, password: String)->Bool{
        let signedIn = userManager.login(email: email.lowercased(), password: password)
        if signedIn{
            self.currentUser = userManager.fetchCurrentUser()
        }
        return signedIn
    }
    
    func completedTimer(){
        let focusSession = FocusSession(id: UUID().uuidString, dateCompleted: Date(), duration: Int(totalTime))
        currentUser?.focusSessions.append(focusSession)
        if let updateUser = currentUser{
            userManager.updateUserData(updateUser)
        }
        
    }
    
    func addCoins(amount: Int){
        currentUser?.coins.defaultCoin = (currentUser?.coins.defaultCoin ?? 100) + amount
        if let updatedUser = currentUser{
            userManager.updateUserData(updatedUser)
        }
    }
    
    
    func getRewards(){
        if let validForReward = currentUser?.streak.isOver24Hrs{
            let streak = (currentUser?.streak.currentStreak ?? 0) + 1
            let currentDate = Date.now
            let totalCoins = (currentUser?.coins.defaultCoin ?? 100) + (streak * 10)
            
            currentUser?.streak.currentStreak = streak
            currentUser?.streak.lastCollected = currentDate
            currentUser?.coins.defaultCoin = totalCoins
            
            if let updatedUser = currentUser{
                userManager.updateUserData(updatedUser)
            }
        }
    }
    
    
    
    
    
    
}
