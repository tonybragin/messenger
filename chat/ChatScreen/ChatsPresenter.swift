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
    
    func viewWillAppear()
    func addButtonTouched()
    func didSelectChat(at index: Int)
    func deleteChat(at index: Int)
}

class ChatsPresenter: ChatsPresenterProtocol {
    
    private unowned var viewController: ChatsViewControllerProtocol
    private var chats = DataStorage.shared.chats
    
    required init(viewController: ChatsViewControllerProtocol) {
        self.viewController = viewController
    }
    
    func viewWillAppear() {
        viewController.chatsData = chats.messagesToPresent()
    }
    
    func addButtonTouched() {
        viewController.performSegue(withIdentifier: "ChatsToSingleChat", sender: nil)
    }
    
    func didSelectChat(at index: Int) {
        viewController.performSegue(withIdentifier: "ChatsToSingleChat", sender: index)
    }
    
    func deleteChat(at index: Int) {
        chats.chats.remove(at: index)
        DataStorage.shared.save()
    }
}

extension ChatsViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? SingleChatViewControllerProtocol {
            destinationViewController.chatIndex = sender as? Int
        }
    }
}
