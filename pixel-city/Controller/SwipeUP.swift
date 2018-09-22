//
//  SwipeUP.swift
//  pixel-city
//
//  Created by ABD on 17/09/2018.
//  Copyright © 2018 Caleb Stultz. All rights reserved.
//

import UIKit

class SwipeUP: UIViewController {
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var hightUp: NSLayoutConstraint!

    @IBOutlet weak var viewUp: viewBar!
    // Var
    var up = true
    override func viewDidLayoutSubviews() {
        viewUp.layer.cornerRadius = 12
        viewUp.layer.masksToBounds = true
    }
    override func viewDidLoad() {
        up = true
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6){
            self.swipUp()
            
        }
        if self.up == false  &&  self.hightUp.constant == 200{
            self.hightUp.constant = 100
            self.view.layoutIfNeeded()
            self.up = true
            print(self.up)
        }

       swipeGest()
    }

    func swipUp() {
        
            UIView.animate(withDuration: 0.5) {
                if self.up == true {
                self.hightUp.constant = 200
                self.view.layoutIfNeeded()
                    
                    self.up = false
                    print(self.up)
                }
            
        }
        
        
        
    }
    func swipeGest(){
        let siwpeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.dismissView))
        siwpeUp.direction = .up
       // siwpeUp.delegate = self
        self.view.addGestureRecognizer(siwpeUp)
    }
    @objc func dismissView (){
        dismiss(animated: false, completion: nil)
        
        
    }
    

}
