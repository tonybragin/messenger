//
//  Charts.swift
//  chat
//
//  Created by Tony on 14/04/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import Foundation

protocol ChatDataItem {
    var message: String { get }
    var messageTime: Date { get }
    var isOutcoming: Bool { get }
    var displayedMessageTime: String { get }
}

class Chats: Codable {
    
    // MARK: - Properties
    
    private(set) var chats: [Chat] = []
    
    func messagesToPresent() -> [ChatDataItem] {
        var messages = [ChatDataItem]()
        for chat in chats {
            if let lastMessage = chat.messages.last {
                messages.append(lastMessage)
            }
        }
        return messages
    }
    
    // MARK: - Public
    
    func add(chat: Chat) {
        chats.insert(chat, at: 0)
    }
    
    func update(chat: Chat, at index: Int) {
        if chats[index] != chat {
            chats.remove(at: index)
            chats.insert(chat, at: 0)
        }
    }
    
    func remove(at index: Int) {
        chats.remove(at: index)
    }
}

struct Chat: Codable, Equatable {
    var messages: [Message]
}

struct Message: ChatDataItem, Codable, Equatable {
    
    // MARK: - Properties
    
    var message: String
    var messageTime: Date
    var isOutcoming: Bool
    
    var displayedMessageTime: String {
        let hours = Calendar.current.component(.hour, from: messageTime)
        let minutes = Calendar.current.component(.minute, from: messageTime)

        return "\(hours.printable):\(minutes.printable)"
    }
    
    // MARK: - Initialization 
    
    init(message: String) {
        self.message = message
        self.messageTime = Date()
        self.isOutcoming = arc4random_uniform(2) == 0
    }
}
