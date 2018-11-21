//
//  DroppablePin.swift
//  pixel-city
//
//  Created by ABD on 18/07/2018.
//  Copyright © 2018 ABD. All rights reserved.
//

import UIKit
import MapKit


class DroppablePin: NSObject, MKAnnotation {
    dynamic var coordinate: CLLocationCoordinate2D
    var identifier: String
    
    init(coordinate: CLLocationCoordinate2D, identifier: String) {
        self.coordinate = coordinate
        self.identifier = identifier
        super.init()
    }
    
    func shakeColor(){
        let animation = CABasicAnimation(keyPath: "shakeColor")
        animation.duration = 0.15
        animation.repeatCount = 5
        
        
    }
    func addPulse(image : UIImageView){
        
        
        let pulse = Pulsing(numberOfPulses: 1, radius: 110, position: image.center)
        pulse.animationDuration = 0.8
        pulse.backgroundColor = UIColor.blue.cgColor
        
       // image.layer.insertSublayer(pulse, below: image.center)
        
        
        
    }
}
