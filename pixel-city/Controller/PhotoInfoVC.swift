//
//  PhotoInfiVC.swift
//  pixel-city
//
//  Created by ABD on 16/07/2018.
//  Copyright © 2018 ABD. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import AlamofireImage
import SDWebImage
import SVProgressHUD
import MapKit
import Firebase
import FirebaseDatabase

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
    @IBOutlet weak var imageHight: NSLayoutConstraint!
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
    let boldDesc = "Description"
    var screenSize = UIScreen.main.bounds
    var blockedArray = [String]()
     var databaseHandler : DatabaseHandle?
    
    override func viewWillAppear(_ animated: Bool) {
        Utilities.setUpViewXContact(hight: barHight, textHight: cityNamePositionH, h : 0.0, g: 0)
    howToUse()
        isAppAlreadyLaunchedOnce()
        hightOfPhoto.constant = 0.4 * screenSize.size.height
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        configureInfo()
        imageView.isUserInteractionEnabled = true
        addTap()
        swipeUp()
       
      
        
    }
    override func viewDidAppear(_ animated: Bool) {
        imageView.contentMode = .scaleAspectFill
        SDImageCache.shared().clearMemory()
        SDImageCache.shared().clearDisk(onCompletion: nil)
//        if let x = UserDefaults.standard.object(forKey: "zouzou") as? [String] {
//            blockedArray = x
//        }
         retriveDataFromCloud()
        print(self.blockedArray)
       
    }

   
    @IBAction func dismiss(_ sender: Any) {
        let image = imageView.image!
     SVProgressHUD.show(withStatus: "Downloding")
      
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
             SVProgressHUD.dismiss()
            UIImageWriteToSavedPhotosAlbum(image.af_imageAspectScaled(toFill: CGSize(width: self.screenSize.size.width, height: self.screenSize.size.height)), self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
            
        }
       
        
        
        
    }
    //MARK: - Add image to Library
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
//            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
//            ac.addAction(UIAlertAction(title: "OK", style: .default))
//            present(ac, animated: true)
            SVProgressHUD.showError(withStatus: "Error")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                SVProgressHUD.dismiss()
                
                
            }
        } else {
//            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
//            ac.addAction(UIAlertAction(title: "OK", style: .default))
//            present(ac, animated: true)
           
            SVProgressHUD.showSuccess(withStatus: "Saved")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                SVProgressHUD.dismiss()
                
                
            }
            
        }
    }
    func configureInfo() {
        var date = UILabel()
        date.text = "Date"
        date.font =  UIFont.systemFont(ofSize: 15)
        
        //date.text = "Date"
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

       
        if   hightOfPhoto.constant == 0.4 * screenSize.size.height {
            UIView.animate(withDuration: 0.25) {
                self.hightOfPhoto.constant = 0.75 * self.screenSize.size.height
                self.view.layoutIfNeeded()
            }
            
        } else if   hightOfPhoto.constant == 0.75 * screenSize.size.height {
            UIView.animate(withDuration: 0.25) {
                 self.hightOfPhoto.constant = 0.4 * self.screenSize.size.height
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
       
       
        
       
       
       
     
        let alert = UIAlertController(title: "Report image", message: "You may found the content of this  image inappropriate  you can report it and we will remove it from our system in maximun 24 hours ", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Report", style: .destructive, handler: { (action : UIAlertAction) in
            if self.blockedArray.contains(self.passedUrl) {
                
            } else {
                
             
                
                
               
                var ref: DatabaseReference!
                
                ref = Database.database().reference()
                 ref.updateChildValues([String(self.blockedArray.count): self.passedUrl])
                

                
                
            }
            
           
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        
        
        self.present(alert, animated: true, completion: nil)
        
    }
    func retriveDataFromCloud(){
        var ref: DatabaseReference!
        ref = Database.database().reference()
        databaseHandler  = ref?.observe(.value, with: { (snapshot) in
            // Code execute when link add
            
            // Take data from snapshoyt and added to Blocked array
            let link = snapshot.value as? [String]
            
            
            if let actuelLink = link {
                self.blockedArray = actuelLink
            }
            
            
            
            
            
            
        })
       
    }
    
    @IBAction func commentPressed(_ sender: Any) {
//        let webVC = storyboard?.instantiateViewController(withIdentifier: "webVc") as! WebVC
//        webVC.passedUrl = createUrl(id: passedID, owner: passedOwner)
//        self.present(webVC, animated: true, completion: nil)
    }
    
    
    @IBAction func getDirection(_ sender: Any) {
        MapVC.intance.showDirection(coordinate: convertCoordinate(lon: 3.042048, lat: 36.752887))
        dismissView()
        
    }
    func convertCoordinate(lon : Double , lat : Double) -> CLLocationCoordinate2D {
        var coordinate =  CLLocationCoordinate2D()
            coordinate.latitude = lat
            coordinate.longitude = lon
        
        return coordinate
    }
    func howToUse(){
        let howToUseInfo = HowToUsePhotoInfo()
        howToUseInfo.modalPresentationStyle = .custom
        //swipeUp.setupView(hide: false)
       // swipeUp.passedHide = false
        present(howToUseInfo, animated: false, completion: nil)
        
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
