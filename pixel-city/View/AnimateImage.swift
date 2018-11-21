//
//  AnimateImage.swift
//  pixel-city
//
//  Created by ABD on 18/11/2018.
//  Copyright © 2018 Caleb Stultz. All rights reserved.
//

import UIKit

class AnimateImage: UIImageView {

    func animateHand(){
        UIView.animate(withDuration: 0.3) {
            self.transform  = CGAffineTransform.init(scaleX: 1.7, y: 1.7)
        }
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            UIView.animate(withDuration: 0.3, animations: {
                self.transform  = CGAffineTransform.init(scaleX: 1, y: 1)
            })
            
            
            
        }
        
    }

}
