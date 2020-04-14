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

struct Chats {
    var charts: [Chat]
}

struct Chat {
    var messages: [Message]
}

struct Message: ChatDataItem {
    var message: String
    var messageTime: Date
    var isOutcoming: Bool
    
    var displayedMessageTime: String {
        let hours = Calendar.current.component(.hour, from: messageTime)
        let minutes = Calendar.current.component(.minute, from: messageTime)

        return "\(hours.printable):\(minutes.printable)"
    }
    
    init(message: String) {
        self.message = message
        self.messageTime = Date()
        self.isOutcoming = arc4random_uniform(2) == 0
    }
}
