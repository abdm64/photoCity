//
//  PhotoInfiVC.swift
//  pixel-city
//
//  Created by ABD on 16/07/2018.
//  Copyright © 2018 Caleb Stultz. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import AlamofireImage
import SDWebImage

class PhotoInfoVC: UIViewController {
    // Outltes
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dateTxt: UILabel!
    @IBOutlet weak var locationTxt: UILabel!
    @IBOutlet weak var titleTxt: UILabel!
    @IBOutlet weak var DescTxt: UILabel!
    @IBOutlet weak var CommentBtn: UIButton!
    var photoInfo = PhotoJsonInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureInfo(info: photoInfo)
    }
    

   
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    func configureInfo(info : PhotoJsonInfo) {
        dateTxt.text = info.date
        locationTxt.text = info.location
        titleTxt.text = info.title
        DescTxt.text = info.desc
       CommentBtn.titleLabel?.text = "Comment\((info.comment))"
        imageView.sd_setImage(with: URL(string : info.url), placeholderImage: #imageLiteral(resourceName: "ImageDownload"), options: [.continueInBackground, .progressiveDownload, .scaleDownLargeImages] , completed: nil)
        
    }
    
}
