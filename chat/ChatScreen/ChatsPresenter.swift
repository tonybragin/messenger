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
        viewController.performSegue(withIdentifier: "ChatsToSingleChat", sender: nil)
    }
    
    func deleteChat(at index: Int) {
        
    }
    
    private func appendChatStub() {
        let message = String(repeating: "Bla ", count: 10)
        let chat = Message(message: message)
        
        viewController.chatsData.insert(chat, at: 0)
    }
}
