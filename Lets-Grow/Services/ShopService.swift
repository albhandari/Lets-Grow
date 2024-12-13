//
//  ShopService.swift
//  Lets-Grow
//
//  Created by Alex Bhandari on 12/10/24.
//

import Foundation

class ShopService{
    
    private init(){}
    
    static let shared = ShopService()
    
    func getDefaultShopItems()->[ShopItem]{
        let defaultItems = [
            ShopItem(
                id: "item_1",
                name: "Green Cat",
                description: "A green mythical cat that will help you grow your mental-wellbeing.",
                cost: 100,
                category: "default",
                imageURL: "idk"
            ),
            ShopItem(
                id: "item_2",
                name: "Red Cat",
                description: "A red cat that will have you in a fiery spirit for focusing.",
                cost: 200,
                category: "default",
                imageURL: "idk"
            ),
            ShopItem(
                id: "item_3",
                name: "Cold Cat",
                description: "A blue cat that will have you in a chill state of mind for focusing.",
                cost: 300,
                category: "default",
                imageURL: "idk"
            ),
            ShopItem(
                id: "item_5",
                name: "Chill Cat",
                description: "A blue cat that will have you in a chill state of mind for focusing.",
                cost: 300,
                category: "default",
                imageURL: "idk"
            ),
            ShopItem(
                id: "item_6",
                name: "Howling Cat",
                description: "A blue cat that will have you in a chill state of mind for focusing.",
                cost: 300,
                category: "default",
                imageURL: "idk"
            ),
            ShopItem(
                id: "item_7",
                name: "Awesome Cat",
                description: "A blue cat that will have you in a chill state of mind for focusing.",
                cost: 3,
                category: "default",
                imageURL: "idk"
            ),
            ShopItem(
                id: "item_8",
                name: "Awesome Cat",
                description: "A blue cat that will have you in a chill state of mind for focusing.",
                cost: 3,
                category: "default",
                imageURL: "idk"
            )
        ]
        
        return defaultItems
    }
    
    func getSanJoseShopItems()->[ShopItem]{
        let sanJoseShopItems = [
            ShopItem(
                id: "mascot_Sammy",
                name: "Sammy",
                description: "The Spartan Spirit that will lead you for the journey to focusing.",
                cost: 10,
                category: "SJSU",
                imageURL: "idk"
            ),
            ShopItem(
                id: "item_9",
                name: "Hammy",
                description: "The Spartan Spirit that will lead you for the journey to focusing.",
                cost: 10,
                category: "SJSU",
                imageURL: "idk"
            ),
            ShopItem(
                id: "item_10",
                name: "Lammy",
                description: "The Spartan Spirit that will lead you for the journey to focusing.",
                cost: 10,
                category: "SJSU",
                imageURL: "idk"
            ),
            ShopItem(
                id: "item_12",
                name: "Nammy",
                description: "The Spartan Spirit that will lead you for the journey to focusing.",
                cost: 10,
                category: "SJSU",
                imageURL: "idk"
            )
        ]
        
        return sanJoseShopItems
    }
    
    func getAllShopItems() -> [ShopItem] {
        let defaultItems = getDefaultShopItems()
        let sanJoseItems = getSanJoseShopItems()
        
        let allItems = defaultItems + sanJoseItems
        return allItems
    }

}
