//
//  photoInfo.swift
//  pixel-city
//
//  Created by ABD on 17/07/2018.
//  Copyright © 2018 Caleb Stultz. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SDWebImage

class PhotoInfoService {
    static let instance = PhotoInfoService()
    var photoInfos = [PhotoJsonInfo]()
    //var ids = []
    
    func findAllPhotoInfo(id : String,completion: @escaping CompletionHandler ){
        
        Alamofire.request(favFlickr(id: id), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            if response.result.error == nil {
                
                
                guard let data = response.data else {return}
                if let  json = JSON(data).array {
                    for item in json {
                        let date = item["taken"].stringValue
                        let views = item["views"].stringValue
                        let location = item["location"].stringValue
                        let title = item["title"].stringValue
//
                        let photoInfo = PhotoJsonInfo(url: nil, title: title, location: location, desc: nil, comment: nil, id: id, date: date, favNumb: nil, viewNumb: nil)
                        self.photoInfos.append(photoInfo)
                    }
                    completion(true)
                     print(self.photoInfos)
                    
                    
                }
                
                
                
                
            }
        }
        
    }

    
    
}
