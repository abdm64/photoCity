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

class MapVC: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var blurEffect: UIVisualEffectView!
    
    @IBOutlet var popView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var pullUpViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var pullUpView: UIView!
    
    @IBOutlet weak var cityNamePop : UILabel!
    static let instance = MapVC()
    

    var locationManager = CLLocationManager()
    let authorizationStatus = CLLocationManager.authorizationStatus()
    let regionRadius: Double = 100000
    var annotationPassed : DroppablePin?
    var screenSize = UIScreen.main.bounds
    var nameCity : String? = ""
    
    var spinner: UIActivityIndicatorView?
    var progressLbl: UILabel?
    
    var flowLayout = UICollectionViewFlowLayout()
    var collectionView: UICollectionView?
    
    var imageUrlArray = [String]()
    var imageArray = [UIImage]()
    var imageTitles = [String]()
    var effect: UIVisualEffect!
    var coordinnat = CLLocationCoordinate2D()
    var annotationSearch : DroppablePin?
   
   // let blurEffectView = UIVisualEffectView()
    var blurEffectView = UIVisualEffectView()
    
    override func viewDidAppear(_ animated: Bool) {
        dementionForPopView()
         isAppAlreadyLaunchedOnce()
        let theImageView = UIImageView(image: UIImage(named:"search")!.withRenderingMode(.alwaysTemplate))
        theImageView.tintColor = UIColor.white
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        configureLocationServices()
        // let blurEffect = UIBlurEffect(style: .light)
        
        //addDoubleTap()
        addLongPress()
        let theImageView = UIImageView(image: UIImage(named:"search")!.withRenderingMode(.alwaysTemplate))
        theImageView.tintColor = UIColor.white
       
        
       // showAlertFirstLaunch()
       
        
       let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
            layout.itemSize = CGSize(width: screenSize.size.width/3, height: 100)
            layout.minimumInteritemSpacing = 0
            layout.scrollDirection = .horizontal
            
        
            layout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: CGRect(x: pullUpView.bounds.origin.x
            , y: pullUpView.bounds.origin.y, width: screenSize.size.width, height: screenSize.size.height) , collectionViewLayout: layout)
        
        collectionView?.register(PhotoCell.self, forCellWithReuseIdentifier: "photoCell")
        collectionView?.delegate = self
       // collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        
        registerForPreviewing(with: self, sourceView: collectionView!)
        
        pullUpView.addSubview(collectionView!)
    }
    
   
    func addLongPress() {
        let longPressed = UILongPressGestureRecognizer(target: self, action: #selector(dropPin(sender:)))
        longPressed.minimumPressDuration = 0.7
        longPressed.delegate = self
        mapView.addGestureRecognizer(longPressed)
       
        
    }
    override func viewDidLayoutSubviews() {
       // print(self.popView.sizeToFit())
        dementionForPopView()
    
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc = segue.destination as! PhotoVC
        
        //vc.annotation3 = annotation1
        vc.annotationInterests = annotationPassed
        //vc.titleTxt.text = nameCity
        vc.cityName = nameCity
    }
    func addSwipe() {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(animateViewDown))
        swipe.direction = .down
        pullUpView.addGestureRecognizer(swipe)
    }
   
    func dementionForPopView(){
        let hieght = screenSize.size.height * 0.8
        let width = screenSize.size.width * 0.85
        //self.popView.sizeThatFits(CGSize(width: width, height: hieght))
//        UIView.animate(withDuration: 0.3) {
//            self.view.layoutIfNeeded()
//        }
        self.popView.center = self.view.center
        self.popView.frame.size = CGSize(width: width, height: hieght)
        
    }
    
   
    @objc func animateViewDown() {
        cancelAllSessions()
        pullUpViewHeightConstraint.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func addSpinner() {
        spinner = UIActivityIndicatorView()
        spinner?.center = CGPoint(x: (screenSize.width / 2) - ((spinner?.frame.width)! / 2), y: 150)
        spinner?.activityIndicatorViewStyle = .whiteLarge
        spinner?.color = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        spinner?.startAnimating()
        collectionView?.addSubview(spinner!)
    }
    
    func removeSpinner() {
        if spinner != nil {
            spinner?.removeFromSuperview()
            
        }
    }
    
    func addProgressLbl() {
        progressLbl = UILabel()
        progressLbl?.frame = CGRect(x: (screenSize.width / 2) - 120, y: 175, width: 240, height: 40)
        progressLbl?.font = UIFont(name: "Avenir Next", size: 14)
        progressLbl?.textColor = #colorLiteral(red: 0.2530381978, green: 0.2701380253, blue: 0.3178575337, alpha: 1)
        progressLbl?.textAlignment = .center
        collectionView?.addSubview(progressLbl!)
    }
    
    func removeProgressLbl() {
        if progressLbl != nil {
            progressLbl?.removeFromSuperview()
        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @IBAction func centerMapBtnWasPressed(_ sender: Any) {
        if authorizationStatus == .authorizedAlways || authorizationStatus
            
            == .authorizedWhenInUse {
                centerMapOnUserLocation()
           
            
        }
    }
    
    @IBAction func dismissBlur(_ sender: Any) {
        
        self.animateOut()
        
    }
    
    
    @IBAction func enterCityNameBtn(_ sender: Any) {
        showAlertCityName()
    
}



} // Class




/////////////////////Extention///////////////





















extension MapVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let pinAnnotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "droppablePin")
        pinAnnotation.pinTintColor = #colorLiteral(red: 0.9771530032, green: 0.7062081099, blue: 0.1748393774, alpha: 1)
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
                    
                    completionHandler(location.coordinate, nil)
                    
                    return
                }
            }
        }
       // completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)

        
        
        
    }
    func centerMapOnUserLocation() {
        guard let coordinate = locationManager.location?.coordinate else { return }
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(coordinate, 20000, 20000)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    @objc func dropPin(sender: UILongPressGestureRecognizer) {
        
        removePin()
        print("LongPressAdded")
        
        cancelAllSessions()
        
        imageUrlArray = []
        imageArray = []
        imageTitles = []
        
        
        collectionView?.reloadData()
        
   //     animateIn()
        
        
        addProgressLbl()
        
        
        
        let touchPoint = sender.location(in: mapView)
        let touchCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        
        let annotation = DroppablePin(coordinate: touchCoordinate, identifier: "droppablePin")
        mapView.addAnnotation(annotation)
        // self.annotation1 = DroppablePin(coordinate: touchCoordinate, identifier: "droppablePin")
        self.annotationPassed = DroppablePin(coordinate: touchCoordinate, identifier: "droppablePin")
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(touchCoordinate, 30000,30000)
        mapView.setRegion(coordinateRegion, animated: true)
        // performSegue(withIdentifier:"name", sender: self)
        let adressLocation = CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
        
        getAddressFromGeocodeCoordinate(coordinate: adressLocation)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // change 2 to desired number of seconds
            // Your code with delay
            self.showAlertMoveToPhoto(city: self.nameCity!)
           // print("####" + self.nameCity!)
        }
        
       // print("####" + nameCity!)
        retrieveUrls(forAnnotation: annotation) { (finished) in
            if finished {
                self.retrieveImages(handler: { (finished) in
                    if finished {
                        self.removeSpinner()
                        self.removeProgressLbl()
                        self.collectionView?.reloadData()
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
        Alamofire.request(flickrUrl(forApiKey: apiKey, withAnnotation: annotation, andNumberOfPhotos: 15)).responseJSON { (response) in
            
            //  print(response.data.c)
            guard let json = response.result.value as? Dictionary<String, AnyObject> else { return }
            let photosDict = json["photos"] as! Dictionary<String, AnyObject>
            let photosDictArray = photosDict["photo"] as! [Dictionary<String, AnyObject>]
            
            //l
            for photo in photosDictArray {
                let postUrl = "https://farm\(photo["farm"]!).staticflickr.com/\(photo["server"]!)/\(photo["id"]!)_\(photo["secret"]!)_h_d.jpg"
                
                let title1 = photo["title"] as! String
                
                
                
                self.imageUrlArray.append(postUrl)
                
                self.imageTitles.append(title1)
            }
            
            handler(true)
            //print(self.imageTitles)
            //print(self.imageTitles)
            // print(self.imageUrlArray)
        }
    }
    
    
    func retrieveImages(handler: @escaping (_ status: Bool) -> ()) {
        //        for url in imageUrlArray {
        //            Alamofire.request(url).responseImage(completionHandler: { (response) in
        //                guard let image = response.result.value else { return }
        //                self.imageArray.append(image)
        //                self.progressLbl?.text = "\(self.imageArray.count)/10 IMAGES DOWNLOADED"
        //                //self.imageUrlArray.count
        //
        //                if self.imageArray.count ==  15 {
        //                    handler(true)
        //                }
        //            })
        //        }
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

extension MapVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCellpop", for: indexPath) as? PhotoViewPopCell else { return UICollectionViewCell() }
        let imageFromIndex = imageArray[indexPath.row]
        
        let imageView = UIImageView(image: imageFromIndex)
        imageView.contentMode = .scaleToFill
        
        cell.addSubview(imageView)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let popVC = storyboard?.instantiateViewController(withIdentifier: "PopVC") as? PopVC else { return }
        popVC.initData(forImage: imageArray[indexPath.row], forText: imageTitles[indexPath.row])
        print(indexPath.row)
        present(popVC, animated: true, completion: nil)
    }
}

extension MapVC: UIViewControllerPreviewingDelegate {
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let indexPath = collectionView?.indexPathForItem(at: location), let cell = collectionView?.cellForItem(at: indexPath) else { return nil }
        
        guard let popVC = storyboard?.instantiateViewController(withIdentifier: "PopVC") as? PopVC else { return nil }
        
        popVC.initData(forImage: imageArray[indexPath.row], forText: imageTitles[indexPath.row])
        
        previewingContext.sourceRect = cell.contentView.frame
        return popVC
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        show(viewControllerToCommit, sender: self)
    }
}

extension MapVC : PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    
    
    
}



extension  MapVC {
    
    
    func createBlurEffect(){
        //let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        UIView.animate(withDuration: 0.7) {
            self.blurEffectView.effect = UIBlurEffect(style: .dark)
        }
        //blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame.size = CGSize(width: screenSize.width, height: screenSize.height)
        
       // blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.view.addSubview(blurEffectView)
      
        
    }
    
    func animateIn(){
        createBlurEffect()
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
    func animateOut(){
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



















