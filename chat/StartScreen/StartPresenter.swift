//
//  StartPresenter.swift
//  chat
//
//  Created by Tony on 15/04/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import UIKit

protocol StartPresenterProtocol {
    func entryButtonTouched()
}

class StartPresenter: StartPresenterProtocol {
    
    // MARK: - Properties
    
    private unowned var viewController: StartViewController
    
    // MARK: - Initialization
    
    init(viewController: StartViewController) {
        self.viewController = viewController
    }
    
    // MARK: - Public
    
    func entryButtonTouched() {
        let loader: LoaderViewController = UIStoryboard.makeViewController(storyboardName: "Main")
        loader.dismissCompletion = presentChatsViewController
        loader.modalTransitionStyle = .crossDissolve
        loader.modalPresentationStyle = .overCurrentContext
        viewController.present(loader, animated: true)
    }
    
    // MARK: - Utility
    
    private func presentChatsViewController() {
        viewController.performSegue(withIdentifier: "StartToChats", sender: nil)
    }
}
