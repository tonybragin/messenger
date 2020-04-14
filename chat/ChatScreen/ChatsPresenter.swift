//
//  ChatsPresenter.swift
//  chat
//
//  Created by Tony on 14/04/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import UIKit

protocol ChatsPresenterProtocol {
    init(viewController: ChatsViewControllerProtocol)
    
    func addButtonTouched()
    func didSelectChat(at index: Int)
    func deleteChat(at index: Int)
}

class ChatsPresenter: ChatsPresenterProtocol {
    
    private unowned var viewController: ChatsViewControllerProtocol
    
    required init(viewController: ChatsViewControllerProtocol) {
        self.viewController = viewController
    }
    
    func addButtonTouched() {
        appendChatStub()
    }
    
    func didSelectChat(at index: Int) {
        
    }
    
    func deleteChat(at index: Int) {
        
    }
    
    private func appendChatStub() {
        let date = Date()
        let hours = Calendar.current.component(.hour, from: date)
        let minutes = Calendar.current.component(.minute, from: date)
        let seconds = Calendar.current.component(.second, from: date)
        
        let lastMessage = String(repeating: "Bla ", count: seconds)
        let lastMessageTime = "\(hours):\(minutes)"
        let chat = ChatsViewController.ChatsDataItemStub(lastMessage: lastMessage,
                                                         lastMessageTime: lastMessageTime)
        
        viewController.chatsData.append(chat)
    }
}
