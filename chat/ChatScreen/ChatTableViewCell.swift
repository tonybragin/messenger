//
//  ChatTableViewCell.swift
//  chat
//
//  Created by Tony on 13/04/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lastMessageLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func layoutSubviews() {
        DispatchQueue.main.async { [weak self] in
            self?.layer.cornerRadius = 18
            self?.layer.masksToBounds = true
            self?.layer.borderColor = UIColor.white.cgColor
            self?.layer.borderWidth = 10
        }
    }
    
    func configure(with item: ChatDataItem) {
        lastMessageLabel.text = item.message
        timeLabel.text = item.displayedMessageTime
    }

}
