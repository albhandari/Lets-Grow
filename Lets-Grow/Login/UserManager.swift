import Foundation
import Combine

class UserManager: ObservableObject {
    private var currentUser: User? = nil
    
    private let userDefaultsService: UserDefaultsService
    private var usersData: UsersData
    
    init(userDefaultsService: UserDefaultsService) {
        //UserDefaults.standard.removeObject(forKey: "usersDataKey")
        self.userDefaultsService = userDefaultsService
        self.usersData = userDefaultsService.loadUsersData()
        // The loadUsersData method already prints the loaded data,
        // so we get a debug printout of the entire stored dataset.
    }
    
    func register(username: String, email: String, password: String) -> Bool {
        
        // Check if user already exists
        if usersData.users.contains(where: { $0.email == email }) {
            return false // user with that email already exists
        }
        
        let newUser = User(
            id: UUID().uuidString,
            username: username,
            email: email,
            password: password,
            equipedPet: "default_pet",
            coins: Coins(defaultCoin: 100, orgCoins: [OrgCoin(orgName: "SJSU", totalOrgCoins: 100)]),
            streak: Streak(currentStreak: 0, lastCollected: Date().addingTimeInterval(-25 * 60 * 60 * 2)),
            ownedItems: [ShopItem(
                id: "default_pet",
                name: "Cute Cat",
                description: "A cute mythical cat that will evolve your focus experience.",
                cost: 500,
                category: "default",
                imageURL: "idk"
            )],
            focusSessions: [],
            spotifyapi: "",
            toDoList:[],
            orgs: [org(id: "SJSU", name: "San Jose State University", description: "The college of San Jose State University", orgItems: ShopService.shared.getSanJoseShopItems(), coin: "Sammy_Coin")]
        )
        
        usersData.users.append(newUser)
        userDefaultsService.saveUsersData(usersData)
        return true
    }
    
    func login(email: String, password: String) -> Bool {
        
        guard let user = usersData.users.first(where: { $0.email == email && $0.password == password }) else {
            return false
        }
        currentUser = user
        print(currentUser)
        return true
    }
    
    
    func logout() {
        currentUser = nil
    }
    
    func updateUserData(_ updatedUser: User) {
        if let index = usersData.users.firstIndex(where: { $0.id == updatedUser.id }) {
            usersData.users[index] = updatedUser
            userDefaultsService.saveUsersData(usersData)
            currentUser = updatedUser
        }
    }
    
    func fetchCurrentUser()->User?{
        if let currentUser = self.currentUser{
            return currentUser
        }
        return nil
    }
}
