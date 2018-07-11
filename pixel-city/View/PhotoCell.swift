//
//  PhotoCell.swift
//  pixel-city
//
//  Created by Caleb Stultz on 7/18/17.
//  Copyright © 2017 Caleb Stultz. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    var imageView: UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = false
        contentView.addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
