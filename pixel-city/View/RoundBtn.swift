//
//  RoundBtn.swift
//  pixel-city
//
//  Created by ABD on 02/07/2018.
//  Copyright © 2018 Caleb Stultz. All rights reserved.
//

import UIKit

class RoundBtn: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateCornerRadius()
    }
    
    @IBInspectable var rounded: Bool = false {
        didSet {
            updateCornerRadius()
        }
    }
    
    func updateCornerRadius() {
        
        self.layer.cornerRadius = rounded ? frame.size.height / 2 : 0
        self.layer.shadowOpacity = 0.75
        self.layer.shadowRadius = 3.0
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowColor = UIColor(red: 157/255, green: 157/255, blue: 157/255, alpha: 1.0).cgColor
    }

}
