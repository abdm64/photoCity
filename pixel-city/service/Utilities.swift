//
//  Utilities.swift
//  pixel-city
//
//  Created by ABD on 18/07/2018.
//  Copyright © 2018 Caleb Stultz. All rights reserved.
//
import Foundation
import UIKit


struct Utilities {
    
    
    static func alert(title: String?, message: String) {
        let alert = UIAlertController(title: title ?? "PhotoMapView", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        UIApplication.shared.delegate!.window!!.rootViewController!.present(alert, animated: true, completion: nil)
    }
    
    static func setUpViewX(hight : NSLayoutConstraint, textHight : NSLayoutConstraint, h: CGFloat, btnCenter : NSLayoutConstraint){
        if  DeviceType.IS_IPHONE_6P_7P {
            print("not iphoneX")
            hight.constant = 75.0
            textHight.constant = 10
            btnCenter.constant = 10
            
        } else if DeviceType.IS_IPHONEX  || DeviceType.IS_IPHONEXMAX   || DeviceType.IS_IPHONEXR {
          
            hight.constant = 85.0
            btnCenter.constant = h
            textHight.constant = h
            
        } else if DeviceType.IS_IPHONE_5 || DeviceType.IS_IPHONE_6_7 {
            hight.constant = 65.0
            textHight.constant = 10
            btnCenter.constant = 10
        }
        
        
        
    }
    static func setUpViewXContact(hight : NSLayoutConstraint, textHight : NSLayoutConstraint, h: CGFloat, g : CGFloat){
        if DeviceType.IS_IPHONE_6P_7P {
            
            hight.constant = 75.0
            textHight.constant = g // 10 OK for about and map VC
            
            
        } else  if DeviceType.IS_IPHONEX || DeviceType.IS_IPHONEXMAX || DeviceType.IS_IPHONEXR {
            
            hight.constant = 85.0
           
            textHight.constant = h
            
        } else if DeviceType.IS_IPHONE_5 || DeviceType.IS_IPHONE_6_7 {
            hight.constant = 65.0
            textHight.constant = g
        }
        
        
        
    }
    
    
}
