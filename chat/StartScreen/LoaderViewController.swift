//
//  LoaderViewController.swift
//  chat
//
//  Created by Tony on 15/04/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import UIKit

class LoaderViewController: UIViewController {
    
    // MARK: - Properties
    
    var dismissCompletion: (() -> Void)?
    
    // MARK: - Outlets

    @IBOutlet weak var activityImageView: UIImageView!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setDismissTimer()
        setAnimation()
    }
    
    // MARK: - Utility
    
    private func setDismissTimer() {
        let timer = Timer(timeInterval: 1, repeats: false) { [weak self] _ in
            self?.dismiss(animated: true, completion: self?.dismissCompletion)
        }
        RunLoop.current.add(timer, forMode: .common)
    }
    
    private func setAnimation() {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0
        rotateAnimation.toValue = CGFloat.pi * 5
        rotateAnimation.duration = 1
        activityImageView.layer.add(rotateAnimation, forKey: nil)
    }
}
