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
    @IBOutlet weak var cityNameTxt: UILabel!
    @IBOutlet weak var barHight: NSLayoutConstraint!
    @IBOutlet weak var cityNamePositionH: NSLayoutConstraint!
    
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
    var passedCityName = ""
    
    
    override func viewWillAppear(_ animated: Bool) {
        Utilities.setUpViewXS(hight: barHight, textHight: cityNamePositionH, h : 0.0, g: 0)
        //howToUse()
        isAppAlreadyLaunchedOnce()
    }
    
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
        DescTxt.text = "Descrption : \(passedDesc)"
        CommentBtn.setTitle("Comments : \((passedCommentNumb))", for: .normal)
        favNumb.text = passedFavNumb
        viewNumb.text = passedViewNumb
        
            cityNameTxt.text = passedLocation  //passedCityName
        
        
        imageView.sd_setImage(with: URL(string :passedUrl), placeholderImage: #imageLiteral(resourceName: "ImageDownload"), options: [.continueInBackground, .progressiveDownload, .scaleDownLargeImages] , completed: nil)
        
    }
    
    func initData( date : String, location : String, title : String, desc : String, fav : String, view : String, forurl urlData : String) {
        
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
    
    @IBAction func commentPressed(_ sender: Any) {
//        let webVC = storyboard?.instantiateViewController(withIdentifier: "webVc") as! WebVC
//        webVC.passedUrl = createUrl(id: passedID, owner: passedOwner)
//        self.present(webVC, animated: true, completion: nil)
    }
    func howToUse(){
        let swipeUp = SwipeUP()
        swipeUp.modalPresentationStyle = .custom
        present(swipeUp, animated: false, completion: nil)
        
        print("howToUse")
        
    }
    func isAppAlreadyLaunchedOnce()->Bool{
        let defaults = UserDefaults.standard
        
        if let isAppAlreadyLaunchedOnce = defaults.string(forKey: "isAppAlreadyLaunchedOncePhotoVC"){
           
            return true
        }else{
            defaults.set(true, forKey: "isAppAlreadyLaunchedOncePhotoVC")
           
            
            self.howToUse()
            return false
        }
    }
    
    func createUrl(id : String, owner : String) -> String {
        let url = "https:www.flickr.com/photos/\(owner)/\(id)/"
        
        return url
    }
    
}
