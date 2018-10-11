//
//  PopVC.swift
//  MapsKitApp
//
//  Created by ABD on 12/06/2018.
//  Copyright © 2018 ABD. All rights reserved.
//

//import UIKit
//
//class PopVC: UIViewController, UIGestureRecognizerDelegate {
//
//    @IBOutlet weak var popImageView: UIImageView!
//
//    @IBOutlet weak var titleLbl: UILabel!
//
//
//    var passedImage: UIImage!
//    var titlePassed : String!
//
//    func initData(forImage image: UIImage,forText text : String) {
//        self.passedImage = image
//        self.titlePassed = text
//
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        popImageView.image = passedImage
//        titleLbl.text = titlePassed
//        addDoubleTap()
//        swipeDown()
//    }
//
//    func addDoubleTap() {
//        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(screenWasDoubleTapped))
//        doubleTap.numberOfTapsRequired = 2
//        doubleTap.delegate = self
//        view.addGestureRecognizer(doubleTap)
//    }
//    func swipeDown(){
//        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(screenWasDoubleTapped))
//        swipeDown.direction = .down
//        swipeDown.delegate = self
//        view.addGestureRecognizer(swipeDown)
//
//    }
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .default
//    }
//    @objc func screenWasDoubleTapped() {
//        dismiss(animated: true, completion: nil)
//    }
//
//}
