//
//  ClickHome_VC.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 20/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

class ClickHome_VC: UIViewController {

     var isChoosenType = true
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func HomeBtnAct(_ sender: UIButton)
    {

       // let view =  self.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController") as? TabBarViewController
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func dropDownAction(_ sender: UIButton) {
        
//        if isChoosenType {
//            sender.setImage(UIImage(named:"check-mark-1"), for: .normal)
//            self.viewHeight.constant = 200
//            isChoosenType = false
//
//    }
        
//        else{
//            sender.setImage(UIImage(named:"dropdown-errow"), for: .normal)
//            self.viewHeight.constant = 0
//        }
//
}
    
    @IBAction func reviewsAction(_ sender: UIButton) {
        let vc =  self.storyboard?.instantiateViewController(withIdentifier: "ReviewViewController") as! ReviewViewController
        vc.backHidden = "yes"
        vc.fromVenue = "no"
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func photosAction(_ sender: UIButton) {
        
//        let view =  self.storyboard?.instantiateViewController(withIdentifier: "ReviewViewController") as? ReviewViewController
//        self.navigationController?.pushViewController(view!, animated: true)
        
    }
    
}
