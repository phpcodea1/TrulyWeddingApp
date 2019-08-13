//
//  CameraPopupViewController.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 12/08/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit
import UserNotifications
import NotificationCenter

class CameraPopupViewController: UIViewController {

    var id = "1"
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func cameraButton(_ sender: UIButton)
    {
       
       NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: nil, userInfo: ["identifier":sender.tag])
        self.dismiss(animated: true, completion: nil)
    }
    
  
}
