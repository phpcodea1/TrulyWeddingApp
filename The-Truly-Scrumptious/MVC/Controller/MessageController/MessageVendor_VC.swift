//
//  MessageVendor_VC.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 20/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit
 import TextFieldEffects

class MessageVendor_VC: UIViewController {

    
    var tittle:String = ""
    @IBOutlet weak var nameTextfiled: HoshiTextField!
    
    @IBOutlet weak var emailTextfiled: HoshiTextField!
    
    @IBOutlet weak var phoneNumberTextfiled: HoshiTextField!
    
    @IBOutlet var headerLabel: UILabel!
    
    @IBOutlet weak var meassageTXT: HoshiTextField!
    @IBOutlet weak var eventDatetextfiled: HoshiTextField!
    
    @IBOutlet weak var venueTxt: HoshiTextField!
    
    @IBOutlet weak var phoneNumberButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textfiledImages()
        if tittle == "yes"
        {
            self.headerLabel.text! = "Message Suppliers"
        }
        else{
             self.headerLabel.text! = "Message Venue"
        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func dismissAction(_
        sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func emailAction(_ sender: UIButton) {
        
        emailButton.isSelected = true
        phoneNumberButton.isSelected = false
    }
    
    @IBAction func phoneNumberAction(_ sender: UIButton) {
        emailButton.isSelected = false
        phoneNumberButton.isSelected = true
    }
    
    
    @IBAction func sendAction(_ sender: UIButton) {
    }
    
    
    
    func textfiledImages()
    {
        let imgViewForDropDown = UIImageView()
        imgViewForDropDown.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        imgViewForDropDown.image = UIImage(named: "user-1")
        nameTextfiled.rightView = imgViewForDropDown
        nameTextfiled.rightViewMode = .always
        
        let imgViewForDropDown1 = UIImageView()
        imgViewForDropDown1.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        imgViewForDropDown1.image = UIImage(named: "email-2")
        emailTextfiled.rightView = imgViewForDropDown1
        emailTextfiled.rightViewMode = .always
        
        let imgViewForDropDown2 = UIImageView()
        imgViewForDropDown2.frame = CGRect(x: 0, y: 0, width: 17, height: 17)
        imgViewForDropDown2.image = UIImage(named: "smartphone")
        phoneNumberTextfiled.rightView = imgViewForDropDown2
        phoneNumberTextfiled.rightViewMode = .always
        
        let imgViewForDropDown3 = UIImageView()
        imgViewForDropDown3.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        imgViewForDropDown3.image = UIImage(named: "calendar")
        eventDatetextfiled.rightView = imgViewForDropDown3
        eventDatetextfiled.rightViewMode = .always
        
        let imgViewForDropDown4 = UIImageView()
        imgViewForDropDown4.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        imgViewForDropDown4.image = UIImage(named: "Home-icon")
        venueTxt.rightView = imgViewForDropDown4
        venueTxt.rightViewMode = .always
        
    }
    
    
    
    
}
