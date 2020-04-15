//
//  ViewController.swift
//  chat
//
//  Created by Tony on 13/04/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var entryButton: EntryButton!
    
    private var presenter: StartPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = StartPresenter(viewController: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        entryButton.animatedAppearance()
    }

    @IBAction func entryButtonTouched(_ sender: UIButton) {
        presenter.entryButtonTouched()
    }
}

