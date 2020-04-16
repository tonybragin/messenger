//
//  UserDefaultsHelper.swift
//  chat
//
//  Created by Tony on 16/04/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import Foundation

class UserDefaultsHelper: DataHelper {
    func getChats() -> Chats {
        let data = UserDefaults.standard.data(forKey: "chats")
        return getChats(from: data)
    }
    func save(chats: Chats) {
        if let data = getData(from: chats) {
            UserDefaults.standard.set(data, forKey: "chats")
            UserDefaults.standard.synchronize()
        }
    }
}
