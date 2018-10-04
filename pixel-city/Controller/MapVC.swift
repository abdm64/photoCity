//
//  MapVC.swift
//  MapsKitApp
//
//  Created by ABD on 09/06/2018.
//  Copyright © 2018 ABD. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Alamofire
import AlamofireImage
import SwiftyJSON
import SDWebImage


class MapVC: UIViewController, UIGestureRecognizerDelegate, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    // Outlet
    @IBOutlet weak var blurEffect: UIVisualEffectView!
    @IBOutlet weak var barTxt: UILabel!
    @IBOutlet var popView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var pullUpViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var pullUpView: UIView!
    @IBOutlet weak var infoBtn: UIButton!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var cityNamePop : UILabel!
    @IBOutlet weak var searchButton: RoundBtn!
    @IBOutlet weak var collectionViewPop: UICollectionView!
    @IBOutlet weak var menuBtn: UIButton!
   
    @IBOutlet weak var btnCenter: NSLayoutConstraint!
    @IBOutlet weak var txtCenter: NSLayoutConstraint!
    
    // Var
    var locationManager = CLLocationManager()
    let authorizationStatus = CLLocationManager.authorizationStatus()
    let regionRadius: Double = 100000
    var annotationPassed : DroppablePin?
    var screenSize = UIScreen.main.bounds
    var nameCity : String? = ""
    var location : String? = ""
    var spinner: UIActivityIndicatorView?
    var flowLayout = UICollectionViewFlowLayout()
    var collectionView: UICollectionView?
    var imageUrlArray = [String]()
    var imageUrlArrayHD = [String]()
    var imageArray = [UIImage]()
    var imageTitles = [String]()
    var jsonViewArray = [String]()
    var jsonFavArray = [String]()
    var effect: UIVisualEffect!
    var coordinnat = CLLocationCoordinate2D()
    var annotationSearch : DroppablePin?
    var photoInfos = [PhotoJsonInfo]()
    let transition = CircularTransition()
    var circlePlace = Bool()
    var blurEffectView = UIVisualEffectView()
    
    @IBOutlet weak var barHight: NSLayoutConstraint!
    
    
  
    
    override func viewDidAppear(_ animated: Bool) {
        SDImageCache.shared().clearMemory()
        SDImageCache.shared().clearDisk(onCompletion: nil)
        dementionForPopView()
       // setUpView()
         isAppAlreadyLaunchedOnce()
       // howToUse()
        
        if UIScreen.main.bounds.width > 320 {
            barTxt.font = barTxt.font.withSize(17)
            if DeviceType.IS_IPHONEX {
                barTxt.font = barTxt.font.withSize(15)
                
            }
            
        } else {
            print("notIphone5")
        }
       
        
    
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Utilities.setUpViewX(hight: barHight, textHight: txtCenter, h: 15, btnCenter: btnCenter)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        configureLocationServices()
        circlePlace = true
      
        addLongPress()
       addTap()
        
        collectionViewPop.delegate = self
        collectionViewPop.dataSource = self
        
       // registerForPreviewing(with: self, sourceView: collectionViewPop)
        
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        collectionViewPop.visibleCells.forEach {
            transform(cell: $0)
        }
    }
   
   
    func addLongPress() {
        let longPressed = UILongPressGestureRecognizer(target: self, action: #selector(dropPin(sender:)))
        longPressed.minimumPressDuration = 0.7
        longPressed.delegate = self
        mapView.addGestureRecognizer(longPressed)
       
        
    }
    func addTap(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(animateOut))
        tap.numberOfTapsRequired = 1
        tap.delegate = self
        blurEffectView.addGestureRecognizer(tap)
        
        
    }
    override func viewDidLayoutSubviews() {
    
        dementionForPopView()
    
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let contactvc = segue.destination as! ContactVC
        contactvc.transitioningDelegate = self
        contactvc.modalPresentationStyle = .custom
    }
    
   
    func dementionForPopView(){
        let hieght = screenSize.size.height * 0.8
        let width = screenSize.size.width * 0.85
 
        self.popView.center = self.view.center
        self.popView.frame.size = CGSize(width: width, height: hieght)
        
    }
    
   
    
    
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @IBAction func centerMapBtnWasPressed(_ sender: Any) {
        if authorizationStatus == .authorizedAlways || authorizationStatus
            
            == .authorizedWhenInUse {
            UIView.animate(withDuration: 1) {
                self.centerMapOnUserLocation()
            }
            
           
            
        }
    }
    
    @IBAction func dismissBlur(_ sender: Any) {
      
        self.animateOut()
       UIApplication.shared.isNetworkActivityIndicatorVisible = false
        cancelAllSessions()
        
    }
    
    
    @IBAction func enterCityNameBtn(_ sender: Any) {
        self.removePin()
        cancelAllSessions()
        showAlertCityName()
    
}

    @IBAction func infoBtn(_ sender: Any) {
         performSegue(withIdentifier: "contact", sender: self)
       
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        if circlePlace == true {
            transition.startingPoint = infoBtn.center
            transition.circleColor = #colorLiteral(red: 0.3532904983, green: 0.4177474976, blue: 0.768464148, alpha: 1)
        } else if circlePlace == false {
             transition.startingPoint = self.view.center
             transition.circleColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        
        if circlePlace == true {
            transition.startingPoint = infoBtn.center
              transition.circleColor = #colorLiteral(red: 0.3532904983, green: 0.4177474976, blue: 0.768464148, alpha: 1)
        } else if circlePlace == false {
            transition.startingPoint = self.view.center
            transition.circleColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
     //   transition.circleColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        return transition
    }
    

} // Class




/////////////////////Extention///////////////





















extension MapVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let pinAnnotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "droppablePin")
        pinAnnotation.pinTintColor = #colorLiteral(red: 0.4400485754, green: 0.5003788471, blue: 0.903263092, alpha: 1)
        pinAnnotation.animatesDrop = true
        return pinAnnotation
    }
    
    func getAddressFromGeocodeCoordinate(coordinate: CLLocation) {
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(coordinate) { (placeMarket, error) in
            if error != nil {
                
                
                 print(error.debugDescription)
                
               
                
                
            } else {
                  let place = placeMarket![0]
                guard  let city =  place.locality else {return}
                self.nameCity = city
                self.cityNamePop.text = city
                
                
                            }
        }
    }
    func getCordinnaatFromCityName(cityName: String, completionHandler: @escaping(CLLocationCoordinate2D, NSError?) -> Void) {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(cityName) { (placemarks, error) in
            if error == nil {
                if let placemark = placemarks?[0] {
                    let location = placemark.location!
                    let cityname = placemark.locality
                    self.cityNamePop.text = cityname
                    self.location = cityname
                    completionHandler(location.coordinate, nil)
                    
                    return
                } else {
                    Utilities.alert(title: "Error", message: "Try Again ")
                     completionHandler((self.locationManager.location?.coordinate)! , error as NSError?)
                }
            }else {
               
               completionHandler((self.locationManager.location?.coordinate)! , error as NSError?)
                
            }
        }
       //

        
        
        
    }
    func centerMapOnUserLocation() {
        guard let coordinate = locationManager.location?.coordinate else { return }
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(coordinate, 20000, 20000)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    @objc func dropPin(sender: UILongPressGestureRecognizer) {
        
        removePin()
      
        
        cancelAllSessions()
        self.nameCity == ""
        imageUrlArray = []
        imageUrlArrayHD = []
        photoInfos = []
        imageArray = []
        imageTitles = []
        jsonViewArray = []
        jsonFavArray = []
        let touchPoint = sender.location(in: mapView)
        let touchCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        
        let annotation = DroppablePin(coordinate: touchCoordinate, identifier: "droppablePin")
        
        mapView.addAnnotation(annotation)
        
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(touchCoordinate, 30000,30000)
        mapView.setRegion(coordinateRegion, animated: true)
        
        let adressLocation = CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
        
        getAddressFromGeocodeCoordinate(coordinate: adressLocation)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
          
            self.showAlertMoveToPhoto(city: self.nameCity!)
           
        }
        
      
        
        
        retrieveUrls(forAnnotation: annotation) { (finished) in
            if finished {
                self.retrieveImages(handler: { (finished) in
                    if finished {
                        
                        self.collectionViewPop?.reloadData()
                    }
                })
            }
        }
        
        
        
    }
    
    
    
    func removePin() {
        for annotation in mapView.annotations {
            mapView.removeAnnotation(annotation)
        }
    }
     
    func retrieveUrls(forAnnotation annotation: DroppablePin, handler: @escaping (_ status: Bool) -> ()) {
        Alamofire.request(flickrUrl(forApiKey: apiKey, withAnnotation: annotation, andNumberOfPhotos: 100)).responseJSON { (response) in
            
            //  print(response.data.c)
            guard let json = response.result.value as? Dictionary<String, AnyObject> else { return }
            let photosDict = json["photos"] as! Dictionary<String, AnyObject>
            let photosDictArray = photosDict["photo"] as! [Dictionary<String, AnyObject>]
            
            //l
            for photo in photosDictArray {
                let postUrl = "https://farm\(photo["farm"]!).staticflickr.com/\(photo["server"]!)/\(photo["id"]!)_\(photo["secret"]!)_s_d.jpg"
                let postUrlHD = "https://farm\(photo["farm"]!).staticflickr.com/\(photo["server"]!)/\(photo["id"]!)_\(photo["secret"]!)_h_d.jpg"
              //  var array = [JSON]()
                let title1 = photo["title"] as! String
                let id = photo["id"] as! String
               
                
                
                Alamofire.request(getInfoFromAPi(forId: id)).responseJSON(completionHandler: { (response) in
                    
                    guard let infoJson : JSON = JSON(response.result.value) else {return
                        Utilities.alert(title: "Error", message: "There is Problem with Connection")
                    }
                    self.getNumOfView(data: infoJson, id: id)
                    
                })
               
                Alamofire.request(favFlickr(id: id)).responseJSON(completionHandler: { (respone) in
                    guard let favJSON : JSON = JSON(respone.result.value ?? "") else {return}
                    
                    self.getNumbFav(data: favJSON)
                   
                })
            
                                self.imageUrlArray.append(postUrl)
                                self.imageUrlArrayHD.append(postUrlHD)
                                self.imageTitles.append(title1)
                
            }
           
            handler(true)
          
            
            
        }
    }
    func getNumOfView(data : JSON , id : String){
        let viwesNumb = data["photo"]["views"].stringValue
        let title = data["photo"]["title"]["_content"].stringValue
        let location = data["photo"]["location"]["locality"]["_content"].stringValue
        let desc = data["photo"]["description"]["_content"].stringValue
        let date = data["photo"]["dates"]["taken"].stringValue
        let commentNumb =  data["photo"]["comments"]["_content"].stringValue
        let owner = data["photo"]["owner"]["path_alias"].stringValue
        
        let photoInfo = PhotoJsonInfo( title: title, location: location, desc: desc, date: date, viewNumb: viwesNumb, commentNumb: commentNumb, owner: owner, id: id)
       
        self.photoInfos.append(photoInfo)
        jsonViewArray.append(viwesNumb)
      
      
       
       
    }
    func getNumbFav(data : JSON) {
         let favNumb = data["photo"]["total"].stringValue
        jsonFavArray.append(favNumb)
     
            }
    
    func retrieveImages(handler: @escaping (_ status: Bool) -> ()) {
        
    }
    
    func cancelAllSessions() {
        Alamofire.SessionManager.default.session.getTasksWithCompletionHandler { (sessionDataTask, uploadData, downloadData) in
            sessionDataTask.forEach({ $0.cancel() })
            downloadData.forEach({ $0.cancel() })
        }
    }
}

extension MapVC: CLLocationManagerDelegate {
    func configureLocationServices() {
        if authorizationStatus == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        } else {
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        centerMapOnUserLocation()
    }
}

extension MapVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageUrlArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCellpop", for: indexPath) as? PhotoViewPopCell else { return PhotoViewPopCell() }
        
        
        if imageUrlArray.count == 0 {
            cityNamePop.text = "no Photo in this area"
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.animateOut()
                self.removePin()
                self.cancelAllSessions()
                self.imageUrlArray = []
                self.imageUrlArrayHD = []
                self.photoInfos = []
                self.imageArray = []
                self.imageTitles = []
                self.jsonViewArray = []
                self.jsonFavArray = []
                
                
            }
            
            Utilities.alert(title: "Error", message: "no Photo in this area Try Again")
        } else {
             cell.imageView.sd_setImage(with: URL(string:imageUrlArray[indexPath.row]), placeholderImage: #imageLiteral(resourceName: "ImageDownload"), options: [.continueInBackground, .progressiveDownload, .scaleDownLargeImages] , completed: nil)
        
            if jsonFavArray.count  > 1 || jsonViewArray.count > 1 {
                
                    cell.commentTxt.text = jsonFavArray[indexPath.row]
                    cell.likeText.text =  jsonViewArray[indexPath.row]
                
                
            } else {
                self.animateOut()
                self.removePin()
                cancelAllSessions()
                imageUrlArray = []
                imageUrlArrayHD = []
                photoInfos = []
                imageArray = []
                imageTitles = []
                jsonViewArray = []
                jsonFavArray = []
                Utilities.alert(title: "Error", message: "Check your internet Connection and  Try Again")
                
     
            }
            
            
            
        }
       
        
    
       
       
         transform(cell: cell)
        
        return cell
    }
  
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let photoInfoVc = storyboard?.instantiateViewController(withIdentifier: "photoInfo1") as! PhotoInfoVC
        photoInfoVc.modalPresentationStyle = .custom
        photoInfoVc.passedDate = photoInfos[indexPath.row].date
        photoInfoVc.passedDesc = photoInfos[indexPath.row].desc
        photoInfoVc.passedTitle = imageTitles[indexPath.row]
        photoInfoVc.passedLocation = photoInfos[indexPath.row].location
        photoInfoVc.passedCommentNumb = photoInfos[indexPath.row].commentNumb
        photoInfoVc.passedFavNumb = jsonFavArray[indexPath.row]
        photoInfoVc.passedViewNumb = photoInfos[indexPath.row].viewNumb
        photoInfoVc.passedUrl = imageUrlArrayHD[indexPath.row]
        photoInfoVc.passedOwner = photoInfos[indexPath.row].owner
        photoInfoVc.passedID = photoInfos[indexPath.row].id
        photoInfoVc.passedCityName = self.nameCity!
        photoInfoVc.modalPresentationStyle = .custom
        photoInfoVc.transitioningDelegate = self
        self.present(photoInfoVc, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        
        
        let numOfColums : CGFloat = 2

        let spaceBtweenCells : CGFloat = 2
        let padding : CGFloat = 10
        
        
        let cellDimension = ((collectionView.bounds.width - padding) - (numOfColums - 1) * spaceBtweenCells) / numOfColums
        
        
        return CGSize(width: cellDimension, height: cellDimension)
    }
    func transform(cell : UICollectionViewCell){
        let coverFrame = cell.convert(cell.bounds, to: self.view)
        let tranfrormOffsetY = collectionViewPop.bounds.height * 2/3
        let percent = getPercent(value: (coverFrame.minX - tranfrormOffsetY) / (collectionViewPop.bounds.height - tranfrormOffsetY))
        let maxScaleDiffrence : CGFloat = 0.2
        let scale = percent * maxScaleDiffrence
        cell.transform = CGAffineTransform(scaleX:  1 - scale, y: 1 - scale)
        
    }
    func getPercent(value : CGFloat)-> CGFloat{
        let lBound : CGFloat = 0
        let uBound : CGFloat = 1
        if value < lBound {
            return lBound
        } else if value > uBound {
            
            return uBound
        }
        return value
    }
}

//extension MapVC: UIViewControllerPreviewingDelegate {
//
//    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
//        guard let indexPath = collectionViewPop.indexPathForItem(at: location), let cell = collectionViewPop.cellForItem(at: indexPath) else { return nil }
//         previewingContext.sourceRect = cell.contentView.frame
//
//        let sb = UIStoryboard(name: "Main", bundle: nil)
//        guard let popVC = sb.instantiateViewController(withIdentifier: "photoInfo1") as? PhotoInfoVC else { return nil }
//
//
//
//
//
//            popVC.imageView.sd_setImage(with: URL(string :imageUrlArrayHD[indexPath.row]))
//            popVC.DescTxt.text = photoInfos[indexPath.row].desc
//
//
//
//        return popVC
//    }
//
//    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
//        show(viewControllerToCommit, sender: self)
//    }
//}





extension  MapVC {
    
    
    func createBlurEffect(){
        
        UIView.animate(withDuration: 0.7) {
            self.blurEffectView.effect = UIBlurEffect(style: .dark)
        }
       
        blurEffectView.frame.size = CGSize(width: screenSize.width, height: screenSize.height)
        self.view.addSubview(blurEffectView)
      
        
    }
    
    func animateIn(){
        circlePlace = false
        createBlurEffect()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self.view.addSubview(popView)
        popView.center = self.view.center
        popView.transform = CGAffineTransform.init(scaleX: 1.2, y: 1.2)
        popView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.blurEffect.effect = self.effect
            self.popView.alpha = 1
            self.popView.transform = CGAffineTransform.identity
        }
        
    }
   @objc func animateOut(){
        circlePlace = true
        UIView.animate(withDuration: 0.4, animations: {
            self.popView.transform = CGAffineTransform.init(scaleX: 1.2, y: 1.2)
            self.popView.alpha = 0
           self.blurEffectView.effect = nil
            
        }) { (seccess) in
            self.popView.removeFromSuperview()
            self.blurEffectView.removeFromSuperview()
        }
        
        
    }

    
    
    override func viewWillLayoutSubviews() {
        dementionForPopView()
    }
    
   
    
}



















