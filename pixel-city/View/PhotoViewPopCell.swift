//
//  PhotoViewPopCell.swift
//  pixel-city
//
//  Created by ABD on 10/07/2018.
//  Copyright © 2018 Caleb Stultz. All rights reserved.
//

import UIKit

class PhotoViewPopCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        setView()
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var likeText: UILabel!
    @IBOutlet weak var commentTxt: UILabel!
    
    @IBOutlet weak var greyView: UIView!
    
    func setView(){
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    
        
        
    }
    func setUpCell(){
        let favImage = UIImageView(image: UIImage(named: "a"))
        let viewImage = UIImageView(image: UIImage(named: "b"))
        
        
        

        
    }

}
