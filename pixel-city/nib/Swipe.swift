//
//  Swipe.swift
//  pixel-city
//
//  Created by ABD on 19/11/2018.
//  Copyright © 2018 Caleb Stultz. All rights reserved.
//

import UIKit

class Swipe: UIViewController {

    @IBOutlet weak var swipeView: viewBar!
    @IBOutlet weak var hightHand: NSLayoutConstraint!
    
     var screenSize = UIScreen.main.bounds
    override func viewDidLoad() {
        super.viewDidLoad()
         self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        swipeUp()
        swipeView.layer.cornerRadius = 12
        swipeView.layer.masksToBounds = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            self.animateHand()
        }
    }

    func animateHand(){
        UIView.animate(withDuration: 0.7) {
            self.hightHand.constant = (self.screenSize.height / 2) - 155
            self.view.layoutIfNeeded()
        }
        
        
    }
    func swipeUp(){
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(self.dismissView))
        
        swipe.direction = .up
        self.view.addGestureRecognizer(swipe)
        
        
        
    }
    
    
   @objc func dismissView(){
        
        dismiss(animated: false, completion: nil)
        
    }
    

}
