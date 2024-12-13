import SwiftUI

struct OrgShopView: View {
    @EnvironmentObject var core: Core
    @State private var selectedOrgID: String = "SJSU"
    @State private var selectedItem: ShopItem? = nil
    
    var body: some View {
        guard let user = core.currentUser else {
            return AnyView(Text("No user logged in"))
        }
        
        return AnyView(
            ZStack {
                // Background based on selectedOrgID
                backgroundImage(for: selectedOrgID)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack {
                    // Picker for default and orgs
                    
                    
                    HStack {
                        Spacer()
                        Text("Shop")
                            .font(.system(size: 30, weight: .bold, design: .rounded)) // Large, rounded font
                            .foregroundColor(Color(red: 33 / 255, green: 105 / 255, blue: 208 / 255)) // Custom blue color
                            .shadow(color: Color.black.opacity(0.3), radius: 4, x: 0, y: 2) // Subtle shadow for depth
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color(hex: "#FCF5EA"))
                                    .shadow(color: Color(hex: "#FCF5EA").opacity(1), radius: 10, x: 0, y: 4)
                            )
                        
                        
                        CoinView(totalCoin: getCoinCount(for: selectedOrgID, user: user))
                            .padding(.trailing)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .padding(.top)
                    
                    let items = getItems(for: selectedOrgID, user: user)
                    
                    if items.isEmpty {
                        Text("No items available.")
                            .padding()
                            .foregroundColor(.white)
                    } else {
                        // Use LazyVGrid for 2 items per row
                        ScrollView {
                            let columns = [
                                GridItem(.flexible()),
                                GridItem(.flexible())
                            ]
                            
                            LazyVGrid(columns: columns, spacing: 20) {
                                ForEach(items) { item in
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

                                                Text("\(item.cost)")
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
                                        Text(item.name)
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
                                    .onTapGesture {
                                        selectedItem = item
                                    }
                                }
                            }
                            .padding()
                        }
                        .padding(.top, 160)
                    }
                }
                
                // Popup overlay if an item is selected
                if let item = selectedItem {
                    Color.black.opacity(0.4).ignoresSafeArea()
                    
                    VStack(spacing: 20) {
                        // Display image based on item.id
                        Image(item.id)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 100)
                        
                        Text(item.name)
                            .font(.title)
                        
                        Text(item.description)
                            .padding(.horizontal)
                        
                        Text("Cost: \(item.cost)")
                            .font(.headline)
                        
                        HStack {
                            Button("Cancel") {
                                selectedItem = nil
                            }
                            .padding()
                            
                            Button("Buy") {
                                buyItem(item: item)
                            }
                            .padding()
                            .buttonStyle(.borderedProminent)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .padding()
                }
            }
        )
    }
    
    // MARK: - Helper Methods
    
    func backgroundImage(for orgID: String) -> Image {
        if orgID == "SJSU" {
            return Image("background_SJSU")
        } else {
            return Image("background_default")
        }
    }
    
    func getItems(for orgID: String, user: User) -> [ShopItem] {
        let allItems: [ShopItem]
        
        if orgID == "default" {
            allItems = ShopService.shared.getDefaultShopItems()
        } else if orgID == "SJSU" {
            allItems = ShopService.shared.getSanJoseShopItems()
        } else {
            allItems = []
        }
        
        let ownedIDs = Set(user.ownedItems.map { $0.id })
        let filtered = allItems.filter { !ownedIDs.contains($0.id) }
        
        return filtered
    }
    
    func getCoinCount(for orgID: String, user: User) -> Int {
        if orgID == "default" {
            return user.coins.defaultCoin
        } else {
            if let orgCoin = user.coins.orgCoins.first(where: { $0.orgName == orgID }) {
                return orgCoin.totalOrgCoins
            }
            return 0
        }
    }
    
    func buyItem(item: ShopItem) {
        guard var user = core.currentUser else { return }
        
        // Deduct cost from appropriate coin
        if selectedOrgID == "default" {
            guard user.coins.defaultCoin >= item.cost else {
                selectedItem = nil
                return
            }
            user.coins.defaultCoin -= item.cost
        } else {
            if let index = user.coins.orgCoins.firstIndex(where: { $0.orgName == selectedOrgID }) {
                guard user.coins.orgCoins[index].totalOrgCoins >= item.cost else {
                    selectedItem = nil
                    return
                }
                user.coins.orgCoins[index].totalOrgCoins -= item.cost
            } else {
                selectedItem = nil
                return
            }
        }
        
        // Add the item to ownedItems
        user.ownedItems.append(item)
        
        // Update currentUser and UserDefaults
        core.userManager.updateUserData(user)
        core.currentUser = user
        
        // Close popup
        selectedItem = nil
    }
}


