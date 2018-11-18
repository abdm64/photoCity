//
//  HowToUseVC.swift
//  pixel-city
//
//  Created by ABD on 06/08/2018.
//  Copyright © 2018 ABD. All rights reserved.
//

import UIKit

class HowToUseVC: UIViewController {
    // Outlets
    @IBOutlet weak var view2: viewBar!
    @IBOutlet weak var view1: viewBar!
    
    @IBOutlet weak var handImage: UIImageView!
    @IBOutlet weak var arrow: UIImageView!
    
    @IBOutlet weak var hand: UIImageView!
    @IBOutlet weak var view3: viewBar!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var howToUseTxt: UILabel!
    
    @IBOutlet weak var handC: NSLayoutConstraint!
    @IBOutlet weak var widthView: NSLayoutConstraint!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var hightView: NSLayoutConstraint!
    
    @IBOutlet weak var alignHand: NSLayoutConstraint!
    // var
    var tap : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
        addTouch()
        tap = 0
        
    }
    override func viewWillAppear(_ animated: Bool) {
       
    }
    override func viewDidLayoutSubviews() {
        view1.layer.cornerRadius = 12
        view2.layer.cornerRadius = 12
        view3.layer.cornerRadius = 12
        view3.layer.masksToBounds = true
        view1.layer.masksToBounds = true
        view2.layer.masksToBounds = true
    }

   
    

    
    @IBAction func dismiss(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
    func setUpView (){
        
         self.view.backgroundColor = UIColor.clear
      //  howToUseTxt.text = "Tap To Contune"
        
        
        view1.alpha = 0
        view2.alpha = 0
        arrow.alpha = 0
        hand.alpha = 0
        self.hand.transform = CGAffineTransform.init(scaleX: 0.01, y: 0.01)
        self.view2.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        self.view1.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        self.arrow.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        self.hand.transform = self.handImage.transform.rotated(by: CGFloat.init(M_PI))
       
        
    }
    func animateView1(){
        UIView.animate(withDuration: 0.5) {
          //  self.view2.transform = CGAffineTransform.identity
            self.view1.transform = CGAffineTransform.init(scaleX: 1.01, y: 1.01)
            self.view1.alpha = 1
            
        }
    }
    func animateView2(){
        UIView.animate(withDuration: 0.5) {
            //  self.view2.transform = CGAffineTransform.identity
            
           
                
                self.view2.transform = CGAffineTransform.init(scaleX: 1.01, y: 1.01)
                self.view2.alpha = 1
                
                self.arrow.transform = CGAffineTransform.init(scaleX: 1.01, y: 1.01)
                self.arrow.alpha = 1
            
           
        }
    }
    func animateOut(){
        
        UIView.animate(withDuration: 0.4, animations: {
            self.view1.transform = CGAffineTransform.init(scaleX: 1.2, y: 1.2)
            self.view1.alpha = 0
           
            
        }) { (seccess) in
            self.view1.removeFromSuperview()
           
        }
        
        
    }
    func addTouch(){
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(HowToUseVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
        
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
       
        
        tap += 1
        if tap == 1 {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.howToUseTxt.text = "How To Use"
                self.animateView1()
                
                
            }
            
        } else if tap == 2 {
            self.animateOut()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.howToUseTxt.text = "Welcome to City Photos"
                self.animateView2()
                 self.handImage.transform = self.handImage.transform.rotated(by: CGFloat.init(M_PI))
                
            }
            
        }else if tap == 3 {
            cityNameLabel.text = "Discover Photo around YOU !!"
            
            UIView.animate(withDuration: 0.5) {
                self.hightView.constant = 160
                self.handC.constant = -(UIScreen.main.bounds.width/2 - 43)
                self.alignHand.constant = 95
                self.view.layoutIfNeeded()
            }

            
        } else if tap == 4 {
            dismiss(animated: false, completion: nil)
            
        }
        
        
    }
    
}

