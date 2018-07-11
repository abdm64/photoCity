//
//  InteresetPhotoCell.swift
//  pixel-city
//
//  Created by ABD on 24/06/2018.
//  Copyright © 2018 Caleb Stultz. All rights reserved.
//

import UIKit

class InteresetPhotoCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 3.0
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 5, height: 10)
        self.clipsToBounds = false
    }
    
}
