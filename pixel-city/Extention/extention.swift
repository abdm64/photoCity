//
//  extention.swift
//  pixel-city
//
//  Created by ABD on 28/06/2018.
//  Copyright © 2018 Caleb Stultz. All rights reserved.
//

import Foundation
import MapKit

extension MapVC  {
    
    func showAlertFirstLaunch() {
        let alert = UIAlertController(title: "How To Use", message: "You have map of the world so drop hold tap at anywar in the map to discover all the phot taken in the place ", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { (action : UIAlertAction) in
            
        }))
        
        
        
        
        self.present(alert, animated: true, completion: nil)
        
        
        
        
    }
    func showAlertMoveToPhoto(city : String){
        let alert = UIAlertController(title: "Show Photo", message: "You Drop a pin in \(city) would you show the pictures taken in \(city) !!? ", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { (action : UIAlertAction) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) { // change 2 to desired
                self.animateIn()
                self.collectionViewPop.reloadData()
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
            showAlertFirstLaunch()
            return false
        }
    }
    func showAlertCityName() {
        
        self.cancelAllSessions()
        self.imageUrlArray = []
        self.imageArray = []
        self.imageTitles = []
        self.jsonViewArray = []
        self.jsonFavArray = []

        let alert = UIAlertController(title: "Show Photo", message: "Enter the name of the city ", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Search", style: .default, handler: { (action : UIAlertAction) in
            guard  let textAlert = (alert.textFields?.first as! UITextField).text else {return}
           // textAlert.
            print(textAlert)
            self.getCordinnaatFromCityName(cityName: textAlert) { (coordinate2D, error) in
                if error == nil {
                    
                // self.annotationSearch?.coordinate()
                    self.removePin()
                    self.annotationSearch = DroppablePin(coordinate: coordinate2D, identifier: "droppablePin1")
                    let coordinateRegion = MKCoordinateRegionMakeWithDistance(coordinate2D, 40000, 40000)
                    self.mapView.setRegion(coordinateRegion, animated: true)
                    self.mapView.addAnnotation(self.annotationSearch!)
                  //  self.annotationSearch = self.annotationPassed
//
                    
                    
                    
                    
                } else {
                    print(error.debugDescription)
                }
            }
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.retrieveUrls(forAnnotation: self.annotationSearch!) { (finished) in
                    if finished {
                        self.retrieveImages(handler: { (finished) in
                            if finished {
                                
                                self.collectionViewPop?.reloadData()
                            }
                        })
                    }
                }
                
                
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                // change 2 to desired number of seconds
                self.animateIn()
                self.collectionViewPop?.reloadData()
                

            }
            //textAlert.capitalized
           self.cityNamePop.text = textAlert.capitalized
            
                    }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addTextField { (textField) -> Void in
            //textField.textColor = UIColor.green
            textField.placeholder = "Enter CityName"
        }
        
        
        self.present(alert, animated: true, completion: nil)
        
        
        
    }
    
    
    
    
}
