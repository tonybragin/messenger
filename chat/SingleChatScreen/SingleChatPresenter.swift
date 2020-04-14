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
}

class SingleChatPresenter: SingleChatPresenterProtocol {
    
    private unowned var viewController: SingleChatViewControllerProtocol
    weak var keyboardAppearingDelegate: KeyboardAppearingDelegate?
    
    required init(viewController: SingleChatViewControllerProtocol) {
        self.viewController = viewController
        self.keyboardAppearingDelegate = viewController
    }
}
