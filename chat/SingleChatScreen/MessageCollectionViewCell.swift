//
//  MessageCollectionViewCell.swift
//  chat
//
//  Created by Tony on 13/04/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import UIKit

class MessageCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var messageLabel: MessageLabel!
    @IBOutlet weak var messageTimeLabel: UILabel!
    
    // MARK: - Public
    
    func configure(with item: ChatDataItem) {
        messageLabel.text = item.message
        messageTimeLabel.text = item.displayedMessageTime
    }
    
    // MARK: - Layout
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        messageLabel.preferredMaxLayoutWidth = (layoutAttributes.size.width - contentView.layoutMargins.left - contentView.layoutMargins.left) * 0.6
        layoutAttributes.bounds.size.height = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        return layoutAttributes
    }
}
