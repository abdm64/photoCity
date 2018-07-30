//
//  ContactVC.swift
//  pixel-city
//
//  Created by ABD on 15/07/2018.
//  Copyright © 2018 Caleb Stultz. All rights reserved.
//

import UIKit
import MessageUI
import Social
import StoreKit
import SVProgressHUD

class ContactVC: UIViewController, MFMailComposeViewControllerDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var constraint: NSLayoutConstraint!
    
    @IBOutlet weak var labelText: UILabel!
    
    @IBOutlet weak var contactWidth: NSLayoutConstraint!
    
    @IBOutlet weak var rateWidth: NSLayoutConstraint!
    
    @IBOutlet weak var shareWidth: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    swipeUp()
       
    }
    

     override var preferredStatusBarStyle: UIStatusBarStyle {return .default}
   

    
    
    
    @IBAction func rateAppBtn(_ sender: Any) {
      //  SVProgressHUD.show(withStatus: "Please Wait")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
            
            
            if #available( iOS 10.3,*){
                SKStoreReviewController.requestReview()
            } else {
                
                
                UIApplication.shared.open(URL(string : "itms-apps://itunes.apple.com/app/id1406164043")!, options: [:]) { (done) in
                   
                    
                }
            }
            
        }
    }
    
    @IBAction func share(_ sender: Any) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let textToShare = "Check out my app on app Store"
        
        if let myWebsite = URL(string: "http://itunes.apple.com/app/id1406164043") {//Enter link to your app here
            let objectsToShare = [textToShare, myWebsite, image ?? #imageLiteral(resourceName: "AZER")] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            //Excluded Activities
            activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
            //
            
            activityVC.popoverPresentationController?.sourceView = sender as! UIView
            self.present(activityVC, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func mail(_ sender: Any) {
        if MFMailComposeViewController.canSendMail() {
        mail()
        } else {
            Utilities.alert(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.")
        }
        print("feedBack pressed")
    }
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    func rateApp(id : Int) {
        
       
    }
    func share(id : Int){
        
        
    }
    func mail(){
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        
        // Configure the fields of the interface.
        composeVC.setToRecipients(["abdm64@live.com"])
        composeVC.setSubject("Photo map FeedBack")
        composeVC.setMessageBody(" ", isHTML: false)
        
        // Present the view controller modally.
        self.present(composeVC, animated: true, completion: nil)
       
        
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        
        controller.dismiss(animated: true, completion: nil)
    }
    @objc func dismissView(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func swipeUp(){
        let siwpeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.dismissView))
        siwpeUp.direction = .up
        siwpeUp.delegate = self
        self.view.addGestureRecognizer(siwpeUp)
    }
   
}
