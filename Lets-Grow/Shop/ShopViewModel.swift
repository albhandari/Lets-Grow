import Foundation
import SwiftUI

class ShopViewModel: ObservableObject {
    @Published var selectedSegment = 0 // 0 = Default Shop, 1 = SJSU Shop
    @Published var selectedItem: ShopItem? = nil // For showing item detail
    @Published var showDetail = false
    
    var user: User {
        didSet {
            // Notify after changes if needed
        }
    }
    
    init(user: User) {
        self.user = user
        filterItems()
    }
    
    private var defaultItems: [ShopItem] = []
    private var sanJoseItems: [ShopItem] = []
    
    func loadItems() {
        defaultItems = ShopService.shared.getDefaultShopItems()
        sanJoseItems = ShopService.shared.getSanJoseShopItems()
        filterItems()
    }
    
    // Returns filtered items based on user not owning them
    var filteredItems: [ShopItem] {
        switch selectedSegment {
        case 0:
            return defaultItems.filter { _ in !user.ownedItems.contains(where: { $0.id == $0.id }) }
        default:
            return sanJoseItems.filter { _ in !user.ownedItems.contains(where: { $0.id == $0.id }) }
        }
    }
    
    func filterItems() {
        // If needed, additional filtering can be done here
    }
    
    func selectItem(_ item: ShopItem) {
        selectedItem = item
        showDetail = true
    }
    
    func buyItem(core: Core) {
        guard let item = selectedItem else { return }
        // Check if user can afford
        if selectedSegment == 0 {
            // Default shop
            guard user.coins.defaultCoin >= item.cost else {
                // Not enough coins
                return
            }
            user.coins.defaultCoin -= item.cost
        } else {
            // SJSU shop - find SJSU coin count
            if let index = user.coins.orgCoins.firstIndex(where: { $0.orgName == "SJSU" }) {
                guard user.coins.orgCoins[index].totalOrgCoins >= item.cost else {
                    // Not enough org coins
                    return
                }
                user.coins.orgCoins[index].totalOrgCoins -= item.cost
            } else {
                // The user doesn't have any SJSU coins or orgCoin record
                return
            }
        }
        
        // Add item to user's ownedItems
        user.ownedItems.append(item)
        
        // Update user in core and userManager
        if let currentUser = core.currentUser {
            var updatedUser = currentUser
            updatedUser.ownedItems = user.ownedItems
            updatedUser.coins = user.coins
            core.userManager.updateUserData(updatedUser)
            core.currentUser = updatedUser
            self.user = updatedUser
        }
        
        // Close detail view and refresh items
        showDetail = false
        selectedItem = nil
    }
    
    func userCoinDisplay() -> Int {
        // Show either defaultCoin or SJSU coin depending on selected segment
        if selectedSegment == 0 {
            return user.coins.defaultCoin
        } else {
            // SJSU coins
            if let orgCoin = user.coins.orgCoins.first(where: { $0.orgName == "SJSU" }) {
                return orgCoin.totalOrgCoins
            }
            return 0
        }
    }
}

