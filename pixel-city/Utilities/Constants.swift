//
//  Constants.swift
//  MapsKitApp
//
//  Created by ABD on 11/06/2018.
//  Copyright © 2018 ABD. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> ()

let apiKey = "817aa5686324ef6de72adfe439b47350"
let U_R_L = "https://api.flickr.com/services/rest/?method=flickr.photos.getFavorites&api_key=61a9088a3b45514282cb69f26c04f4b7&photo_id=42401722335&page=1&per_page=1&format=json&nojsoncallback=1&api_sig=acbbadc1fcc1081b231ded57da264d7a"
let secret = "8c35595756c32445"
//api.flickr.com/services/rest/?method=flickr.photos.search&api_key=bfb8b88e1d8aad38ba160d5436987620&privacy_filter=1&safe_search=1&content_type=1&lat=59.3293&lon=18.0686°&radius=1000&radius_units=m&format=json&nojsoncallback=1


func flickrUrl(forApiKey key: String, withAnnotation annotation: DroppablePin, andNumberOfPhotos number: Int) -> String {
    return "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&privacy_filter=1&safe_search=1&content_type=1&lat=\(annotation.coordinate.latitude)&lon=\(annotation.coordinate.longitude)&radius=1&radius_units=mi&per_page=\(number)&format=json&nojsoncallback=1"
}
 //func flickr

func favFlickr(id : String) -> String{
    
   // print()
    return "https://api.flickr.com/services/rest/?method=flickr.photos.getFavorites&api_key=\(apiKey)&photo_id=\(id)&format=json&nojsoncallback=1"
}
func getInfoFromAPi(forId id : String)->String {
    
    return "https://api.flickr.com/services/rest/?method=flickr.photos.getInfo&api_key=\(apiKey)&photo_id=\(id)&format=json&nojsoncallback=1"
    
}

















