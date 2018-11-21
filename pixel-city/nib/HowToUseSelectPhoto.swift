//
//  HowToUseSelectPhoto.swift
//  pixel-city
//
//  Created by ABD on 18/11/2018.
//  Copyright © 2018 Caleb Stultz. All rights reserved.
//

import UIKit

class HowToUseSelectPhoto: UIViewController {
    
    
    
    @IBOutlet weak var viewTap: viewBar!
    @IBOutlet weak var hand: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        viewTap.layer.cornerRadius = 12
        viewTap.layer.masksToBounds = true
        addTap()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            
           self.animateHand()
            
        }

        
    }
    
    func addTap(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(HowToUsePhotoInfo.dismissView))
        tap.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tap)

        
        
    }


    @objc  func dismissView(){
        dismiss(animated: false, completion: nil)
    }
    func animateHand(){
        UIView.animate(withDuration: 0.3) {
            self.hand.transform  = CGAffineTransform.init(scaleX: 1.7, y: 1.7)
        }
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            UIView.animate(withDuration: 0.3, animations: {
                 self.hand.transform  = CGAffineTransform.init(scaleX: 1, y: 1)
            })
            
            
            
        }
        
    }

}
