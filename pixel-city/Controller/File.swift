//
//  File.swift
//  pixel-city
//
//  Created by ABD on 27/07/2018 024917658
//

import Foundation


//
//  InterestsVC.swift
//  pixel-city
//
//  Created by ABD on 23/06/2018.
//  Copyright © 2018 Caleb Stultz. All rights reserved.
//

//import UIKit
//import Alamofire
//import AlamofireImage
//import SDWebImage
//
//
//class PhotoVC: UIViewController {
//    var annotationInterests : DroppablePin?
//    @IBOutlet weak var titleTxt: UILabel!
//    @IBOutlet weak var collectionView: UICollectionView!
//    @IBOutlet weak var labelTxt : UILabel!
//    var cityName: String?
//    @IBOutlet weak var spinner: UIActivityIndicatorView!
//
//    @IBOutlet weak var progressLbl: UILabel!
//
//    var imageUrlArray = [String]()
//    var imageArray = [UIImage]()
//    var imageTitles = [String]()
//    let cellScalling: CGFloat = 0.6
//    let screenSize = UIScreen.main.bounds.size
//    var cellWidth = CGFloat()
//    var cellHight = CGFloat()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//       // self.automaticallyAdjustsScrollViewInsets = false
//        //  labelTxt.text = imageTitles[0]
//      //  SDImageCache.shared().clearMemory
//        titleTxt.text = cityName
//        SDImageCache.shared().clearMemory()
//        SDImageCache.shared().clearDisk(onCompletion: nil)
//        if imageTitles.count > 0{
//            labelTxt.text = imageTitles[0]
//
//        }
//        configureCell()
//        retrieveUrls(forAnnotation: annotationInterests!) { (sucees) in
//            if sucees {
//                self.retrieveImages(handler: { (finished) in
//                    if finished {
//                        self.collectionView.reloadData()
//                    }
//                })
//            }
//        }
//
//
//    }
//
//    func retrieveUrls(forAnnotation annotation: DroppablePin, handler: @escaping (_ status: Bool) -> ()) {
//        Alamofire.request(flickrUrl(forApiKey: apiKey, withAnnotation: annotation, andNumberOfPhotos: 15)).responseJSON { (response) in
//
//            guard let json = response.result.value as? Dictionary<String, AnyObject> else { return }
//            let photosDict = json["photos"] as! Dictionary<String, AnyObject>
//            let photosDictArray = photosDict["photo"] as! [Dictionary<String, AnyObject>]
//
//            //l
//            for photo in photosDictArray {
//                let postUrl = "https://farm\(photo["farm"]!).staticflickr.com/\(photo["server"]!)/\(photo["id"]!)_\(photo["secret"]!)_h_d.jpg"
//                let title1 = photo["title"] as! String
//
//
//
//                self.imageUrlArray.append(postUrl)
//                self.imageTitles.append(title1)
//            }
//
//            handler(true)
//
//            UIApplication.shared.isNetworkActivityIndicatorVisible = true
//            self.removeSpinner()
//            self.progressLbl.removeFromSuperview()
//            self.collectionView?.reloadData()
//        }
//    }
//
//
//    func retrieveImages(handler: @escaping (_ status: Bool) -> ()) {
//        for url in imageUrlArray {
//            Alamofire.request(url).responseImage(completionHandler: { (response) in
//                guard let image = response.result.value else { return }
//
//                self.imageArray.append(image)
//                self.progressLbl?.text = "\(self.imageArray.count)/20 IMAGES DOWNLOADED"
//                    print(self.imageArray.count)
//
//                if self.imageArray.count == self.imageUrlArray.count {
//                    handler(true)
//                  //  UIApplication.shared.isNetworkActivityIndicatorVisible = false
//                }
//            })
//        }
//    }
//
//    @IBAction func donePressed(_ sender: Any) {
//        imageUrlArray = []
//        imageArray = []
//        imageTitles = []
//
//        self.dismiss(animated: true, completion: nil)
//        cancelAllSessions()
//    }
//
//    func cancelAllSessions() {
//        Alamofire.SessionManager.default.session.getTasksWithCompletionHandler { (sessionDataTask, uploadData, downloadData) in
//            sessionDataTask.forEach({ $0.cancel() })
//            downloadData.forEach({ $0.cancel() })
//        }
//    }
//
//    func removeSpinner() {
//        if spinner != nil {
//            spinner?.removeFromSuperview()
//        }
//    }
//} //Class

//extension PhotoVC: UICollectionViewDelegate, UICollectionViewDataSource {
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return imageUrlArray.count
//    }
//
//
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//
//
//        //labelTxt.text = imageTitles[indexPath.row]
//
//
//
//
//
//    }
//
//
//
//
//
//
//
//
//}
//


//extension UIImageView {
//    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
//        contentMode = mode
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard
//                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
//                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
//                let data = data, error == nil,
//                let image = UIImage(data: data)
//                else { return }
//            DispatchQueue.main.async() {
//                self.image = image
//            }
//            }.resume()
//    }
//    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
//        guard let url = URL(string: link) else { return }
//        downloadedFrom(url: url, contentMode: mode)
//    }
//}

//extension PhotoVC: UIScrollViewDelegate  {
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        let cellwidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
//        var offset = targetContentOffset.pointee
//        let index = (offset.x + scrollView.contentInset.left) / cellwidthIncludingSpacing
//        let roundedIndex = round(index)
//        let intIndex = Int(index)
//       // print(roundedIndex)
//        offset = CGPoint(x: roundedIndex * cellwidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
//        targetContentOffset.pointee = offset
//         labelTxt.text = imageTitles[intIndex]
//    }
//    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
//
//    }
//
//}














