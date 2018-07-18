//
//  Constants.swift
//  MapsKitApp
//
//  Created by ABD on 11/06/2018.
//  Copyright © 2018 ABD. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> ()

let apiKey = "2dc46d0d9202867a59d79c06642f436f"
let U_R_L = "https://api.flickr.com/services/rest/?method=flickr.photos.getFavorites&api_key=61a9088a3b45514282cb69f26c04f4b7&photo_id=42401722335&page=1&per_page=1&format=json&nojsoncallback=1&api_sig=acbbadc1fcc1081b231ded57da264d7a"


func flickrUrl(forApiKey key: String, withAnnotation annotation: DroppablePin, andNumberOfPhotos number: Int) -> String {
    return "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&lat=\(annotation.coordinate.latitude)&lon=\(annotation.coordinate.longitude)&radius=1&radius_units=mi&per_page=\(number)&format=json&nojsoncallback=1"
}
 //func flickr

func favFlickr(id : String) -> String{
    
   // print()
    return "https://api.flickr.com/services/rest/?method=flickr.photos.getFavorites&api_key=\(apiKey)&photo_id=\(id)&format=json&nojsoncallback=1"
}
func getInfoFromAPi(forId id : String)->String {
    
    return "https://api.flickr.com/services/rest/?method=flickr.photos.getInfo&api_key=\(apiKey)&photo_id=\(id)&format=json&nojsoncallback=1"
    
}

















