//
//  ContactVC.swift
//  pixel-city
//
//  Created by ABD on 15/07/2018.
//  Copyright © 2018 Caleb Stultz. All rights reserved.
//

import UIKit

class ContactVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }

   
}
