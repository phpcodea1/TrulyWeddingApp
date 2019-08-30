//
//  SupplierRequestDetailsViewController.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 17/08/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

class SupplierRequestDetailsViewController: UIViewController
{
    @IBOutlet weak var phoneBtn2: UIButton!
    @IBOutlet weak var emailBtn1: UIButton!
    @IBOutlet weak var messgeTxt: UITextField!
    @IBOutlet weak var guestNumberTxt: UITextField!
    @IBOutlet weak var eventTxt: UITextField!
    @IBOutlet weak var phonetxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var nameTxt: UITextField!
    
    @IBOutlet weak var titleLbl: UILabel!
    var vendorId = ""
    var contactType = ""
    var titleText = ""
    
    var CAT_ID = ""
    let datePicker = UIDatePicker()
    var mainDict = NSDictionary()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        print(mainDict)
        if let event_date = mainDict.value(forKey: "event_date") as? String
        {
            eventTxt.text = event_date
        }
        if let guest_list = mainDict.value(forKey: "guest_list") as? String
        {
            guestNumberTxt.text = guest_list
        }
        
        if let message = mainDict.value(forKey: "message") as? String
        {
            messgeTxt.text = message
        }
        if let mobile_no = mainDict.value(forKey: "phone") as? String
        {
            phonetxt.text = mobile_no
        }
        
        if let name = mainDict.value(forKey: "name") as? String
        {
            nameTxt.text = name
        }
        
        if let email = mainDict.value(forKey: "email") as? String
        {
            emailTxt.text = email
        }
        
        if let contact_type = mainDict.value(forKey: "contact_type") as? String
        {
           
            if contact_type == "1"
            {
                emailBtn1.setImage(UIImage(named: "radioFill"), for: .normal)
                phoneBtn2.setImage(UIImage(named: "radioBlank"), for: .normal)
            }
            else
            {
                phoneBtn2.setImage(UIImage(named: "radioFill"), for: .normal)
                 emailBtn1.setImage(UIImage(named: "radioBlank"), for: .normal)
            }
        }
        
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func goBack(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }

}
