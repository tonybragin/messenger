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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        entryButton.animatedAppearance()
    }

}

