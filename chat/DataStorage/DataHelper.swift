//
//  DataHelper.swift
//  chat
//
//  Created by Tony on 16/04/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import Foundation

protocol DataHelper {
    func getChats() -> Chats
    func save(chats: Chats)
}

extension DataHelper {
    func getChats(from data: Data?) -> Chats {
        if let data = data {
            if let decodedChats = try? JSONDecoder().decode(Chats.self, from: data) {
                return decodedChats
            }
        }
        return Chats()
    }
    
    func getData(from chats: Chats) -> Data? {
       return try? JSONEncoder().encode(chats)
    }
}
