import Foundation

struct UsersData: Codable {
    var users: [User]
}

struct User: Codable, Identifiable {
    var id: String
    var username: String
    var email: String
    var password: String
    var equipedPet: String
    var coins: Coins
    var streak: Streak
    var ownedItems: [ShopItem]
    var focusSessions: [FocusSession]
    var spotifyapi: String
    var toDoList: [ToDoItem]
    var orgs: [org]
    
    
    func totalFocusTime() -> String {
            let totalSeconds = focusSessions.reduce(0) { $0 + $1.duration }
            
            if totalSeconds < 60 {
                return "\(totalSeconds) seconds"
            } else {
                let minutes = totalSeconds / 60
                let seconds = totalSeconds % 60
                return "\(minutes)m, \(seconds)s"
            }
        }
}

struct Streak: Codable {
    var currentStreak: Int
    var lastCollected: Date
    var isOver24Hrs: Bool {
        let now = Date()
        let elapsedTime = now.timeIntervalSince(lastCollected)
        print(elapsedTime)
        print(elapsedTime > (24*60*60))
        return elapsedTime > (24*60*60)
    }
}


struct Coins: Codable {
    var defaultCoin: Int
    var orgCoins: [OrgCoin]
}

struct OrgCoin: Codable {
    var orgName: String
    var totalOrgCoins: Int
}

struct ShopItem: Codable, Identifiable {
    var id: String
    var name: String
    var description: String
    var cost: Int
    var category: String // "default" or the org's name
    var imageURL: String
}

struct FocusSession: Codable, Identifiable {
    var id: String
    var dateCompleted: Date
    var duration: Int
}

struct ToDoItem: Codable, Identifiable {
    var id: String
    var title: String
    var description: String
    var completed: Bool
    var dueDate: Date?
}

struct org: Codable, Identifiable {
    var id: String
    var name: String
    var description: String
    var orgItems: [ShopItem]
    var coin: String
}
