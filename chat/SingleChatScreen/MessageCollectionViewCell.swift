//
//  MessageCollectionViewCell.swift
//  chat
//
//  Created by Tony on 13/04/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import UIKit

class MessageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var messageLabel: MessageLabel!
    @IBOutlet weak var messageTimeLabel: UILabel!
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        messageLabel.preferredMaxLayoutWidth = (layoutAttributes.size.width - contentView.layoutMargins.left - contentView.layoutMargins.left) * 0.6
        layoutAttributes.bounds.size.height = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        return layoutAttributes
    }
    
    func configure(with item: ChatDataItem) {
        messageLabel.text = item.message
        messageTimeLabel.text = item.displayedMessageTime
    }
}
