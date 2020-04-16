//
//  DataStorage.swift
//  chat
//
//  Created by Tony on 16/04/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import Foundation

class DataStorage {
    
    static var shared = DataStorage()
    
    private(set) var chats = Chats()
    
    private init() {
        getChatsFromUserDefaults()
    }
    
    func save() {
        saveChatsToUserDefaults()
    }
    
    private func getChatsFromUserDefaults() {
        if let decoded = UserDefaults.standard.data(forKey: "chats") {
            if let decodedChats = try? JSONDecoder().decode(Chats.self, from: decoded) {
                chats = decodedChats
            }
        }
    }
    
    private func saveChatsToUserDefaults() {
        if let encodedData = try? JSONEncoder().encode(chats) {
            UserDefaults.standard.set(encodedData, forKey: "chats")
            UserDefaults.standard.synchronize()
        }
    }
}
