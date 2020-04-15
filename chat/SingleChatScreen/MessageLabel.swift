//
//  OutcomingMessageLabel.swift
//  chat
//
//  Created by Tony on 13/04/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import UIKit

class MessageLabel: UILabel {
    var topInset: CGFloat = 10
    var bottomInset: CGFloat = 10
    var leftInset: CGFloat = 10
    var rightInset: CGFloat = 10
    
    override func drawText(in rect: CGRect) {
       let insets = UIEdgeInsets(top: topInset,
                                 left: leftInset,
                                 bottom: bottomInset,
                                 right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
       get {
          var contentSize = super.intrinsicContentSize
          contentSize.height += topInset + bottomInset
          contentSize.width += leftInset + rightInset
          return contentSize
       }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.cornerRadius = 4
        layer.masksToBounds = false
    }
}

class OutcomingMessageLabel: MessageLabel {
    
    override var leftInset: CGFloat {
        get {
            return 30
        } set {
            super.leftInset = newValue
        }
    }
}

class IncomingMessageLabel: MessageLabel {
    
    override var rightInset: CGFloat {
        get {
            return 30
        } set {
            super.rightInset = newValue
        }
    }
}
