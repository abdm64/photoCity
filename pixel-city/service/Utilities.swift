//
//  Utilities.swift
//  pixel-city
//
//  Created by ABD on 18/07/2018.
//   Copyright © 2018 ABDM64. All rights reserved.

import Foundation
import UIKit


struct Utilities {
    
    
    static func alert(title: String?, message: String) {
        let alert = UIAlertController(title: title ?? "PhotoMapView", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        UIApplication.shared.delegate!.window!!.rootViewController!.present(alert, animated: true, completion: nil)
    }
    
    static func setUpViewX(hight : NSLayoutConstraint, textHight : NSLayoutConstraint, h: CGFloat){
        if DeviceType.IS_IPHONE_5 || DeviceType.IS_IPHONE_6_7 || DeviceType.IS_IPHONE_6P_7P {
            print("not iphoneX")
            hight.constant = 75.0
            textHight.constant = 0
            
            
        } else {
          
            hight.constant = 85.0
           
            textHight.constant = h
            
        }
        
        
        
    }
    
    
}
