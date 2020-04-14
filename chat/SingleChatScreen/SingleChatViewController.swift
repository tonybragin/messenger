//
//  SingleChatViewController.swift
//  chat
//
//  Created by Tony on 13/04/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import UIKit

protocol SingleChatViewControllerProtocol: UIViewController, KeyboardAppearingDelegate {

}

class SingleChatViewController: UIViewController, SingleChatViewControllerProtocol {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var messageViewBottomConstraint: NSLayoutConstraint!
    
    private var presenter: SingleChatPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SingleChatPresenter(viewController: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.addKeyboardObservers()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter.removeKeyboardObservers()
    }

}

extension SingleChatViewController: KeyboardAppearingDelegate {
    func keyboardWillShow(with rect: CGRect, duration: TimeInterval) {
        var bottomOffset: CGFloat = 0
        if #available(iOS 11.0, *) {
            bottomOffset = view.safeAreaInsets.bottom
        }
        UIView.animate(withDuration: duration) { [weak self] in
            self?.messageViewBottomConstraint.constant = rect.height - bottomOffset
            self?.view.layoutIfNeeded()
        }
    }
    
    func keyboardWillHide(with rect: CGRect, duration: TimeInterval) {
        UIView.animate(withDuration: duration) { [weak self] in
            self?.messageViewBottomConstraint.constant = 0
            self?.view.layoutIfNeeded()
        }
    }
    
    
}
