//
//  HowToUsePhotoInfo.swift
//  pixel-city
//
//  Created by ABD on 15/11/2018.
//  Copyright © 2018 Caleb Stultz. All rights reserved.
//

import UIKit

class HowToUsePhotoInfo: UIViewController {
    // Outlets
    
    @IBOutlet weak var handDownload: UIImageView!
    @IBOutlet weak var viewDownload: viewBar!
    @IBOutlet weak var viewSwipe: viewBar!
    @IBOutlet weak var viewReport: viewBar!
    @IBOutlet weak var handReport: UIImageView!
    @IBOutlet weak var handSwipe: UIImageView!
    @IBOutlet weak var hightHandSwipe: NSLayoutConstraint!
    // Var
    
    var numTap = Int()
    var screenSize = UIScreen.main.bounds
    
    
    override func viewDidLayoutSubviews() {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        numTap = 0
        // Do any additional setup after loading the view.
         self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
         self.handReport.transform = CGAffineTransform.init(rotationAngle: CGFloat(M_PI))
        prepareAnimation()
        setupView()
        addTap()
        if numTap != 1  && numTap != 0{
            self.swipeUp()
        }
        
        
    }
    func setupView(){
       
        //self.view.backgroundColor = UIColor.clear
        viewDownload.layer.cornerRadius = 12
        viewSwipe.layer.cornerRadius = 12
        viewReport.layer.cornerRadius = 12
        viewDownload.layer.masksToBounds = true
        viewSwipe.layer.masksToBounds = true
        viewReport.layer.masksToBounds = true
        
        
        
        
    }
    func prepareAnimation(){
        self.viewSwipe.alpha = 0
        self.handSwipe.alpha = 0
        self.viewSwipe.transform =  CGAffineTransform.init(scaleX: 0.01, y: 0.01)
        self.handSwipe.transform =  CGAffineTransform.init(scaleX: 0.01, y: 0.01)
        
        
        
    }
    func animationIN(){
        UIView.animate(withDuration: 0.5) {
            self.viewSwipe.transform = CGAffineTransform.init(scaleX: 1.01, y: 1.01)
            self.viewSwipe.alpha = 1
            self.handSwipe.transform = CGAffineTransform.init(scaleX: 1.01, y: 1.01)
            self.handSwipe.alpha = 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            UIView.animate(withDuration: 0.5, animations: {
                self.hightHandSwipe.constant = (self.screenSize.height / 2) - 155
                self.view.layoutIfNeeded()
            })
        }
        
        
    }
    func animateOut(){
        
        UIView.animate(withDuration: 0.4, animations: {
            self.viewDownload.transform = CGAffineTransform.init(scaleX: 0.01, y: 0.01)
            self.viewReport.transform = CGAffineTransform.init(scaleX: 0.01, y: 0.01)
            self.handDownload.transform = CGAffineTransform.init(scaleX: 0.01, y: 0.01)
            self.handDownload.transform = CGAffineTransform.init(scaleX: 0.01, y: 0.01)
            self.viewDownload.alpha = 0
            self.viewReport.alpha = 0
            self.handReport.alpha = 0
            self.handDownload.alpha = 0
            
            
        }) { (secess) in
            self.viewDownload.removeFromSuperview()
            self.handDownload.removeFromSuperview()
            self.viewReport.removeFromSuperview()
            self.handReport.removeFromSuperview()
            
        }
        self.swipeUp()
    }
     @objc func animation(_ recognizer: UITapGestureRecognizer){
        numTap += 1
        if numTap == 1 {
            self.animateOut()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.animationIN()
            }
        } else   {
            self.dismiss()
           // self.swipeUp()
        }
       
        
        
    }
  @objc  func dismiss(){
        dismiss(animated: false, completion: nil)
    }
    @objc  func dismissView(){
        dismiss(animated: false, completion: nil)
    }
    
    func addTap(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(HowToUsePhotoInfo.animation(_:)))
        tap.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tap)
        
    }
    func swipeUp(){
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(self.dismissView))
        swipe.direction = .up
        self.view.addGestureRecognizer(swipe)
    }


    
}
