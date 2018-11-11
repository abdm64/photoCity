//
//  extention.swift
//  pixel-city
//
//  Created by ABD on 28/06/2018.
//  Copyright © 2018 ABD. All rights reserved.
//

import Foundation
import MapKit
import SVProgressHUD
import  UIKit

extension MapVC  {
    
   
    func showAlertMoveToPhoto(city : String ){
        let alert = UIAlertController(title: "Show Photo", message: "You Drop a Pin in \(city) would you discover all the Photos  taken in \(city) !? ", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action : UIAlertAction) in
            SVProgressHUD.show(withStatus: "Please Wait")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                // change 2 to desired
                SVProgressHUD.dismiss()
                if self.imageUrlArray.count == 0 {
                    Utilities.alert(title: "Try Again", message: "There is no images in this area")
                } else {
                    self.animateIn()
                    self.collectionViewPop.reloadData()
                }
                
            }
            
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func isAppAlreadyLaunchedOnce()->Bool{
        let defaults = UserDefaults.standard
        
        if let isAppAlreadyLaunchedOnce = defaults.string(forKey: "isAppAlreadyLaunchedOnce"){
            print("App already launched : \(isAppAlreadyLaunchedOnce)")
            return true
        }else{
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            print("App launched first time")
        
            howToUse()
            return false
        }
    }
    func showAlertCityName() {
        
        self.cancelAllSessions()
        self.imageUrlArray = []
        self.imageUrlArrayHD = []
        self.photoInfos = []
        self.imageArray = []
        self.imageTitles = []
        self.jsonViewArray = []
        self.jsonFavArray = []

        let alert = UIAlertController(title: "Show Photo", message: "Please Enter name of the city to dicover Photos ", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Search", style: .default, handler: { (action : UIAlertAction) in
            guard  let textAlert = (alert.textFields?.first as! UITextField).text else {return
                Utilities.alert(title: "Error", message: "Enter Name Of city PLZ")
            }
           
            self.getCordinnaatFromCityName(cityName: textAlert) { (coordinate2D, error) in
                if error == nil {
                
                    self.removePin()
                    self.annotationSearch = DroppablePin(coordinate: coordinate2D, identifier: "droppablePin1")
                    let coordinateRegion = MKCoordinateRegionMakeWithDistance(coordinate2D, 40000, 40000)
                    self.mapView.setRegion(coordinateRegion, animated: true)
                    self.mapView.addAnnotation(self.annotationSearch!)
                
//
                    
                    
                    
                    
                } else {
                    print(error.debugDescription)
                }
            }
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                if self.annotationSearch != nil {
                self.retrieveUrls(forAnnotation: self.annotationSearch!) { (finished) in
                    
                        if finished {
                            self.retrieveImages(handler: { (finished) in
                                if finished {
                                    
                                    self.collectionViewPop?.reloadData()
                                }
                            })
                        }
                    }
                    // PrgrussHUD enable
                    SVProgressHUD.show(withStatus: "Please Wait")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.8) {
                        SVProgressHUD.dismiss()
                        self.animateIn()
                        self.collectionViewPop?.reloadData()
                        // dismiss ProgrussHud
                        
                        
                    }
                    
                }else {
                    Utilities.alert(title: "Error", message: "Try Again !!")
                    self.cityNamePop.text = "Enter city name"
                }
                
            }
                
                
            

           
           
            
                    }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addTextField { (textField) -> Void in
            //textField.textColor = UIColor.green
            textField.placeholder = "Enter City Name"
        }
        
        
        self.present(alert, animated: true, completion: nil)
        
        
        
    }
    
  
    
    func howToUse(){
        let howToUse = HowToUseVC()
        howToUse.modalPresentationStyle = .custom
       present(howToUse, animated: false, completion: nil)
        
        
        
    }
    
    
    
   
    
    
   
    
    
    
    
    
    
    
    
    
    
    
    
}
