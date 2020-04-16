//
//  EntryButton.swift
//  chat
//
//  Created by Tony on 13/04/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import UIKit

class EntryButton: UIButton {
    
    // MARK: - Properties
    
    private var shadowLayer: CAShapeLayer!
    
    // MARK: - Public
    
    func animatedAppearance() {
        move()
        flash()
    }

    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = UIColor.clear
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
          
            shadowLayer.path = UIBezierPath(roundedRect: bounds,
                                            cornerRadius: frame.height/2).cgPath
            shadowLayer.fillColor = UIColor.entryButtonFillColor.cgColor

            shadowLayer.shadowColor = UIColor.entryButtonShadowColor.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            shadowLayer.shadowOpacity = 0.5
            shadowLayer.shadowRadius = 9

            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
    
    // MARK: - Utility
    
    private func flash() {
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 1
        flash.fromValue = 0
        flash.toValue = 1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        layer.add(flash, forKey: nil)
    }
    
    private func move() {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 1
        
        let fromPoint = CGPoint(x: center.x, y: center.y + 30)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(shake, forKey: "position")
    }
}
