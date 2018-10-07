//
//  PopViewC.swift
//  pixel-city
//
//  Created by ABD on 10/07/2018.
//  Copyright © 2018 ABD. All rights reserved.
//

import UIKit

class PopViewC: UIView {
   

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateCornerRadius()
    }
    func updateCornerRadius() {
        
        self.layer.cornerRadius = 7
        
    }
}
