//
//  MessageTextView.swift
//  chat
//
//  Created by Tony on 13/04/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import UIKit

class MessageTextView: UITextView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 5
        layer.masksToBounds = true
    }
    
    func showPlaceholder() {
        text = "Введите сообщение..."
        textColor = UIColor.messageTextViewPlaceholderTextColor
        font = UIFont.messageTextViewPlaceholderTextFont
    }
    
    func hidePlaceholder() {
        text = ""
        textColor = UIColor.black
        font = UIFont.messageTextViewTextFont
    }
}
