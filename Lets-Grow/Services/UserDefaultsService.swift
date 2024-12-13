//
//  UserDefaultsService.swift
//  Lets-Grow
//
//  Created by Alex Bhandari on 12/9/24.
//


import Foundation

class UserDefaultsService {
    private let usersKey = "usersDataKey"
    
    init(){
        
    }
    
    func loadUsersData() -> UsersData {
        let defaults = UserDefaults.standard
        if let data = defaults.data(forKey: usersKey) {
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let usersData = try decoder.decode(UsersData.self, from: data)
                print("Loaded UsersData: \(usersData)")
                return usersData
            } catch {
                print("Error decoding UsersData from UserDefaults: \(error.localizedDescription)")
                return UsersData(users: [])
            }
        } else {
            // No data yet, return empty
            let emptyData = UsersData(users: [])
            print("No existing UsersData found. Starting with empty data: \(emptyData)")
            return emptyData
        }
    }
    
    func saveUsersData(_ usersData: UsersData) {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            encoder.dateEncodingStrategy = .iso8601
            let data = try encoder.encode(usersData)
            UserDefaults.standard.set(data, forKey: usersKey)
            print("Successfully saved UsersData: \(usersData)")
        } catch {
            print("Failed to save UsersData: \(error.localizedDescription)")
        }
    }
}
