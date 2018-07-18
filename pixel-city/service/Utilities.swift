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
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        UIApplication.shared.delegate!.window!!.rootViewController!.present(alert, animated: true, completion: nil)
    }
    
    
}
