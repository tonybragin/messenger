//
//  SingleChatPresenter.swift
//  chat
//
//  Created by Tony on 14/04/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import Foundation

protocol SingleChatPresenterProtocol: KeyboardAppearingSupport {
    init(viewController: SingleChatViewControllerProtocol)
    
    func sendMessageButtonTouched(text: String)
}

class SingleChatPresenter: SingleChatPresenterProtocol {
    
    private unowned var viewController: SingleChatViewControllerProtocol
    weak var keyboardAppearingDelegate: KeyboardAppearingDelegate?
    
    required init(viewController: SingleChatViewControllerProtocol) {
        self.viewController = viewController
        self.keyboardAppearingDelegate = viewController
    }
    
    func sendMessageButtonTouched(text: String) {
        func formated() -> String {
            return text
        }
        let formatedText = formated()
        if !formatedText.isEmpty {
            appendChatStub(text: formatedText)
        }
    }
    
    private func appendChatStub(text: String) {
        let message = Message(message: text)
        viewController.chatData.append(message)
    }
}
