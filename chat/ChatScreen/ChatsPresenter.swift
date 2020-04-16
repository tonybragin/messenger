//
//  ChatsPresenter.swift
//  chat
//
//  Created by Tony on 14/04/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import UIKit

protocol ChatsPresenterProtocol {
    func viewWillAppear()
    func addButtonTouched()
    func didSelectChat(at index: Int)
    func deleteChat(at index: Int)
}

class ChatsPresenter: ChatsPresenterProtocol {
    
    // MARK: - Properties
    
    private unowned var viewController: ChatsViewControllerProtocol
    private var chats = DataStorage.shared.chats
    
    // MARK: - Initialization
    
    init(viewController: ChatsViewControllerProtocol) {
        self.viewController = viewController
    }
    
    // MARK: - Public
    
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
        chats.remove(at: index)
        DataStorage.shared.save()
    }
}

// MARK: - Working with UIStoryboardSegue

extension ChatsViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? SingleChatViewControllerProtocol {
            destinationViewController.chatIndex = sender as? Int
        }
    }
}
