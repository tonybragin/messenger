//
//  OutcomingCollectionViewCell.swift
//  chat
//
//  Created by Tony on 13/04/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import UIKit

protocol MessageCollectionViewCell: UICollectionViewCell {
    func configure(with item: ChatDataItem)
}

class OutcomingCollectionViewCell: UICollectionViewCell, MessageCollectionViewCell {
    
    @IBOutlet weak var massageLabel: OutcomingMessageLabel!
    @IBOutlet weak var messageTimeLabel: UILabel!
    
    func configure(with item: ChatDataItem) {
        massageLabel.text = item.message
        messageTimeLabel.text = item.displayedMessageTime
    }
}

class IncomingCollectionViewCell: UICollectionViewCell, MessageCollectionViewCell {
    
    @IBOutlet weak var messageLabel: IncomingMessageLabel!
    @IBOutlet weak var messageTimeLabel: UILabel!
    
    func configure(with item: ChatDataItem) {
        messageLabel.text = item.message
        messageTimeLabel.text = item.displayedMessageTime
    }
}
