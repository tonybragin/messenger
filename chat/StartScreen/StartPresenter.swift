//
//  StartPresenter.swift
//  chat
//
//  Created by Tony on 15/04/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import UIKit

protocol StartPresenterProtocol {
    init(viewController: StartViewController)
    func entryButtonTouched()
}

class StartPresenter: StartPresenterProtocol {
    
    private unowned var viewController: StartViewController
    
    required init(viewController: StartViewController) {
        self.viewController = viewController
    }
    
    func entryButtonTouched() {
        let loader: LoaderViewController = UIStoryboard.makeViewController(storyboardName: "Main")
        loader.dismissCompletion = presentChatsViewController
        loader.modalTransitionStyle = .crossDissolve
        loader.modalPresentationStyle = .overCurrentContext
        viewController.present(loader, animated: true)
    }
    
    private func presentChatsViewController() {
        viewController.performSegue(withIdentifier: "StartToChats", sender: nil)
    }
}
