//
//  SingleChatPresenter.swift
//  chat
//
//  Created by Tony on 14/04/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import Foundation

protocol SingleChatPresenterProtocol: KeyboardAppearingSupport {
    func viewDidLoad()
    func viewWillDisappear()
    func sendMessageButtonTouched(text: String)
}

class SingleChatPresenter: SingleChatPresenterProtocol {
    
    // MARK: - Properties
    private unowned var viewController: SingleChatViewControllerProtocol
    weak var keyboardAppearingDelegate: KeyboardAppearingDelegate?
    private var chats = DataStorage.shared.chats
    private var chat: Chat!
    
    // MARK: - Initialization
    
    init(viewController: SingleChatViewControllerProtocol) {
        self.viewController = viewController
        self.keyboardAppearingDelegate = viewController
    }
    
    // MARK: - Public
    
    func viewDidLoad() {
        if let index = viewController.chatIndex {
            chat = chats.chats[index]
        } else {
            chat = Chat(messages: [Message]())
        }
        viewController.chatData = chat.messages
    }
    
    func viewWillDisappear() {
        if let index = viewController.chatIndex {
            chats.update(chat: chat, at: index)
        } else {
            if !chat.messages.isEmpty {
                chats.add(chat: chat)
            }
        }
        DataStorage.shared.save()
    }
    
    func sendMessageButtonTouched(text: String) {
        let trimmedString = text.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmedString.isEmpty {
            chat.messages.append(Message(message: trimmedString))
            viewController.chatData = chat.messages
        }
    }
}
