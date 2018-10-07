//
//  RoundBtn.swift
//  pixel-city
//
//  Created by ABD on 02/07/2018.
//  Copyright © 2018 ABD. All rights reserved.
//

import UIKit

class RoundBtn: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        
        gurdianet()
    }
    
    @IBInspectable var rounded: Bool = false {
        didSet {
           // gurdianet()
            updateCornerRadius()
            
        }
    }
    
    func updateCornerRadius() {
        
        //self.layer.cornerRadius = rounded ? frame.size.height / 2 : 0
        self.layer.shadowOpacity = 0.75
        self.layer.shadowRadius = 3.0
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowColor = UIColor(red: 157/255, green: 157/255, blue: 157/255, alpha: 1.0).cgColor
    }
    @IBInspectable var topColor: UIColor = #colorLiteral(red: 0.3647058824, green: 0.4039215686, blue: 0.8784313725, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var bottomColor: UIColor = #colorLiteral(red: 0.1725490196, green: 0.831372549, blue: 0.8470588235, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
   func gurdianet() {

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    


} //
import UIKit
@IBDesignable
class RoundedButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 6.0 {
        
        didSet{
            
            self.layer.cornerRadius = cornerRadius
            
            
            
        }
        
        
    }
    override func awakeFromNib() {
        self.setUpView()
    }
    
    func setUpView(){
        
        self.layer.cornerRadius = cornerRadius
        
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
}
