//
//  SendRequestSupplierViewController.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 16/08/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

class SendRequestSupplierViewController: UIViewController {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showDatePicker()
        
        
        self.contactType = "1"
        // Do any additional setup after loading the view.
        self.emailBtn1.setImage(UIImage(named: "radioFill"), for: .normal)
    }
    @IBAction func sendRequest(_ sender: UIButton)
    {
        if  (nameTxt.text?.count == 0) || (emailTxt.text?.count == 0||phonetxt.text?.count == 0) || (messgeTxt.text?.count == 0)  || (eventTxt.text?.count == 0)
        {
            Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Please enter all details.")
        }
        else
        {
        
            if !(NetworkEngine.networkEngineObj.isInternetAvailable())
            {
                NetworkEngine.networkEngineObj.showInterNetAlert()
            }
            else
            {
                
                self.SendRequestAPI()
            }
            
        }    }
    
    @IBAction func RadioAct(_ sender: UIButton)
    {
        if sender.tag == 1
        {
            contactType = "1"
            if emailBtn1.currentImage == UIImage(named: "radioFill")
            {
                emailBtn1.setImage(UIImage(named: "radioBlank"), for: .normal)
                phoneBtn2.setImage(UIImage(named: "radioFill"), for: .normal)
                
            }
            else
            {
                emailBtn1.setImage(UIImage(named: "radioFill"), for: .normal)
                phoneBtn2.setImage(UIImage(named: "radioBlank"), for: .normal)
            }
        }
        else
        {
            contactType = "2"
            if phoneBtn2.currentImage == UIImage(named: "radioFill")
            {
                emailBtn1.setImage(UIImage(named: "radioFill"), for: .normal)
                phoneBtn2.setImage(UIImage(named: "radioBlank"), for: .normal)
                
            }
            else
            {
                emailBtn1.setImage(UIImage(named: "radioBlank"), for: .normal)
                phoneBtn2.setImage(UIImage(named: "radioFill"), for: .normal)
            }
        }
        
        
        
    }
    
    @IBAction func goBack(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    func SendRequestAPI()
    {
        
        var userEmail = ""
        if let email = DEFAULT.value(forKey: "email") as? String
        {
            userEmail = email
        }
        var eventType = "wedding"
        if let eventType1 = DEFAULT.value(forKey: "eventType") as? String
        {
            eventType = eventType1
        }
        var eventID = "1"
        if let eventType1 = DEFAULT.value(forKey: "eventID") as? String
        {
            eventID = eventType1
        }
        var params:[String:Any] = [:]
        var api = ""
      
            params =
                [
                    "email":userEmail,
                    "customer_email":emailTxt.text!,
                    "supplier_id":self.vendorId,
                    "name":nameTxt.text!,
                    "mobile_no":phonetxt.text!,
                    "event_date":self.convertDateFormater2(self.eventTxt.text!),
                    "message":messgeTxt.text!,
                    "contact_type":self.contactType,
                    "event_id":eventID,
                    "event_type":eventType,
                    "cat_id":self.CAT_ID
                    
            ]
            api = SUPPLIERREQUESTPRICING
        
        
        
    
        WebService.shared.apiDataPostMethod(url:api, parameters: params) { (response, error) in
            if error == nil
            {
                
                if let resp = response as? NSDictionary
                {
                    if let resp = resp.value(forKey: "message") as? String
                    {
                        if resp  == "successfully"
                        {
                            self.navigationController?.popViewController(animated: true)
                        }
                        
                        
                    }
                    else
                    {
                        if let msg = resp.value(forKey: "message") as? String
                        {
                            Helper.helper.showAlertMessage(vc: self, titleStr: "Message!", messageStr:msg)
                        }
                        
                    }
                }
                
            }
            else
            {
                Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr:"Error")
                
            }
            
        }
    }
    //MARK: - Datepicker
    
    func showDatePicker(){
        
        datePicker.datePickerMode = .date
        datePicker.minimumDate = Calendar.current.date(byAdding: .year, value: 0, to: Date())
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.bordered, target: self, action: #selector(PreRegisterWeddingViewController.donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.bordered, target: self, action: #selector(PreRegisterWeddingViewController
            .cancelDatePicker))
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
        eventTxt.inputAccessoryView = toolbar
        eventTxt.inputView = datePicker
    }
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        //formatter.dateFormat = "dd/MMM/yyyy"
        
        formatter.dateFormat = "MMMM-dd-yyyy"
        var seletedDate = formatter.string(from: datePicker.date)
        eventTxt.text! = self.convertDateFormater(seletedDate)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    func convertDateFormater(_ date: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM-dd-yyyy"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "dd MMMM yyyy"
        return  dateFormatter.string(from: date!)
        
    }
    
    func convertDateFormater2(_ date: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return  dateFormatter.string(from: date!)
        
}
}
