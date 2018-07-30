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

class PhotoInfoVC: UIViewController, UIGestureRecognizerDelegate {
    // Outltes
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dateTxt: UILabel!
    @IBOutlet weak var locationTxt: UILabel!
    @IBOutlet weak var titleTxt: UILabel!
    @IBOutlet weak var DescTxt: UILabel!
    
    @IBOutlet weak var viewNumb: UILabel!
    @IBOutlet weak var favNumb: UILabel!
    @IBOutlet weak var CommentBtn: UIButton!
    @IBOutlet weak var hightOfPhoto: NSLayoutConstraint!
    
    // Var
    var passedDate = ""
    var passedTitle = ""
    var passedLocation = ""
    var passedDesc = ""
    var passedID = ""
    var passedFram = ""
    var passedSecret = ""
    var passedServer = ""
    var passedUrl = ""
    var passedCommentNumb = ""
    var passedFavNumb = ""
    var passedViewNumb = ""
    var passedOwner = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureInfo()
        imageView.isUserInteractionEnabled = true
        addTap()
        swipeUp()
       print(createUrl(id: passedID, owner: passedOwner))
    }
    override func viewDidAppear(_ animated: Bool) {
        imageView.contentMode = .scaleAspectFill
        SDImageCache.shared().clearMemory()
        SDImageCache.shared().clearDisk(onCompletion: nil)
       
    }

   
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    func configureInfo() {
        dateTxt.text =  "Date : \(passedDate)"
        locationTxt.text = "Location : \(passedLocation)"
        titleTxt.text = "Title : \(passedTitle)"
        DescTxt.text = "Desc : \(passedDesc)"
        CommentBtn.setTitle("Comments : \((passedCommentNumb))", for: .normal)
        favNumb.text = passedFavNumb
        viewNumb.text = passedViewNumb
        imageView.sd_setImage(with: URL(string :passedUrl), placeholderImage: #imageLiteral(resourceName: "ImageDownload"), options: [.continueInBackground, .progressiveDownload, .scaleDownLargeImages] , completed: nil)
        
    }
    
    @objc func configurePhotoHight(){
        
       
        if hightOfPhoto.constant == CGFloat(250) {
            UIView.animate(withDuration: 0.25) {
                self.hightOfPhoto.constant = 450
                self.view.layoutIfNeeded()
            }
            
        } else if hightOfPhoto.constant == CGFloat(450) {
            UIView.animate(withDuration: 0.25) {
                self.hightOfPhoto.constant = 250
                self.view.layoutIfNeeded()
                
            }
            
        }
        
    }
    @objc func dismissView(){
        self.dismiss(animated: true, completion: nil)
    }
    func addTap(){
        let tapPress = UITapGestureRecognizer(target: self, action: #selector(self.configurePhotoHight))
        tapPress.numberOfTapsRequired = 1
        tapPress.delegate = self
        imageView.addGestureRecognizer(tapPress)
    }
    func swipeUp(){
        let siwpeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.dismissView))
        siwpeUp.direction = .up
        siwpeUp.delegate = self
        self.view.addGestureRecognizer(siwpeUp)
    }
    
    @IBAction func shareBtnPressed(_ sender: Any) {

        let textToShare = "check Out the Photo On Flicker"
        
        if let myWebsite = URL(string: createUrl(id: passedID, owner: passedOwner)) {//Enter link to your app here
            let objectsToShare = [textToShare, myWebsite] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            //Excluded Activities
            activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
            //
            
            activityVC.popoverPresentationController?.sourceView = sender as! UIView
            self.present(activityVC, animated: true, completion: nil)
        }
        
    }
    func createUrl(id : String, owner : String) -> String {
        let url = "https:www.flickr.com/photos/\(owner)/\(id)/"
        
        return url
    }
    
}
