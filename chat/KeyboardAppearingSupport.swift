//
//  KeyboardAppearingSupport.swift
//  chat
//
//  Created by Tony on 14/04/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import UIKit

protocol KeyboardAppearingSupport: class {
    var keyboardAppearingDelegate: KeyboardAppearingDelegate? { get set }
    
    func addKeyboardObservers()
    func removeKeyboardObservers()
}

protocol KeyboardAppearingDelegate: class {
    func keyboardWillShow(with rect: CGRect, duration: TimeInterval)
    func keyboardWillHide(with rect: CGRect, duration: TimeInterval)
}

extension KeyboardAppearingSupport {
    
    func addKeyboardObservers() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification,
                                               object: nil,
                                               queue: nil) { [weak self] notification  in
            guard let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
                let keyboardRect = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
                    return
            }
            
            self?.keyboardAppearingDelegate?.keyboardWillShow(with: keyboardRect,
                                                              duration: animationDuration)
        }
    
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification,
                                               object: nil,
                                               queue: nil) { [weak self] notification  in
            guard let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
            let keyboardRect = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
                return
            }
            
            self?.keyboardAppearingDelegate?.keyboardWillHide(with: keyboardRect,
                                                              duration: animationDuration)
        }
    }
    
    func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
}
