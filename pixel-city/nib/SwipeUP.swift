//
//  SwipeUP.swift
//  pixel-city
//
//  Created by ABD on 17/09/2018.
//  Copyright © 2018 ABD. All rights reserved.
//

import UIKit

class SwipeUP: UIViewController {
    // Outlets
    @IBOutlet weak var viewDownload: viewBar!
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var hightUp: NSLayoutConstraint!
    @IBOutlet weak var labl: UILabel!
    @IBOutlet weak var hand: UIImageView!
    @IBOutlet weak var viewUp: viewBar!
    @IBOutlet weak var handUp: UIImageView!
    
    @IBOutlet weak var centerDownloadView: NSLayoutConstraint!
    @IBOutlet weak var labelDownload: UILabel!
    @IBOutlet weak var handDownload: UIImageView!
    // Var
    var up = true
    var passedHide = Bool()
    override func viewDidLayoutSubviews() {
        viewUp.layer.cornerRadius = 12
        viewUp.layer.masksToBounds = true
        viewDownload.layer.cornerRadius = 12
        viewDownload.layer.masksToBounds = true
        
       setupView(hide: passedHide)
//        if DeviceType.IS_IPHONE_5  {
//            
//        self.viewDownload.frame.size = CGSize(width: 200, height: 128)
//            print("iPhone5")
//        }
    

    }
    override func viewWillAppear(_ animated: Bool) {
//        if DeviceType.IS_IPHONE_5  {
//
//            self.viewDownload.frame.size = CGSize(width: 200, height: 128)
//            print("iPhone5")
//        }
    }
    override func viewDidAppear(_ animated: Bool) {
//        if DeviceType.IS_IPHONE_5  {
//
//            self.viewDownload.frame.size = CGSize(width: 200, height: 128)
//            print("iPhone5")
//        }
    }
    override func viewDidLoad() {
        
    
        super.viewDidLoad()
        self.viewUp.transform = CGAffineTransform.init(scaleX: 0.01, y: 0.01)
        self.viewUp.alpha = 0
        self.handUp.transform = CGAffineTransform.init(scaleX: 0.01, y: 0.01)
        self.handUp.alpha = 0
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        //swipeGest()
        if passedHide {
            
            
            //self.swipeGest()
        } else {
            tap()
        }
       
        
    }


    
    func swipeGest(){
        let siwpeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.dismissView))
        siwpeUp.direction = .up
        self.view.addGestureRecognizer(siwpeUp)
    }
    func tap(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.animationView))
        tap.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tap)
        
    }
    @objc func dismissView (){
        dismiss(animated: false, completion: nil)
        
        
    }
    @objc func animationView(){
       
        
        UIView.animate(withDuration: 0.5) {
            
//            self.hightUp.constant = 200
//            self.view.layoutIfNeeded()
            self.viewDownload.transform = CGAffineTransform.init(scaleX: 0.01, y: 0.01)
            self.viewDownload.alpha = 0
            self.hand.transform = CGAffineTransform.init(scaleX: 0.01, y: 0.01)
            self.hand.alpha = 0
            
            
            
        }
        UIView.animate(withDuration: 0.5) {
            //  self.view2.transform = CGAffineTransform.identity
            self.viewUp.transform = CGAffineTransform.init(scaleX: 1.01, y: 1.01)
            self.viewUp.alpha = 1
            self.handUp.transform = CGAffineTransform.init(scaleX: 1.01, y: 1.01)
            self.handUp.alpha = 1

            
        }
                    UIView.animate(withDuration: 1) {

                        self.hightUp.constant = 150
                        self.view.layoutIfNeeded()
        
        
                    }
        
      
        self.swipeGest()
    }
    
    func setupView(hide : Bool){
        if hide {
            
            viewDownload.alpha = 1
            hand.alpha = 0
            labelDownload.text = "Tap To Continue"
            centerDownloadView.constant = 0
            tap()
            
        }
        
        viewUp.alpha = 1
        handUp.alpha = 1
        
        
        
    }
    

}
