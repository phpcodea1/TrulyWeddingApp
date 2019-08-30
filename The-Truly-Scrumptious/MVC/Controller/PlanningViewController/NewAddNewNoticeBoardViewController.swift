//
//  NewAddNewNoticeBoardViewController.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 19/08/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit
import IQKeyboardManager

class NewAddNewNoticeBoardViewController: UIViewController {

    @IBOutlet weak var titleTxt: UITextField!
    @IBOutlet weak var descText: IQTextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descText.layer.borderWidth = 1
        
        descText.layer.borderColor = UIColor.black.cgColor
   
    }
    
    @IBAction func addBoard(_ sender: UIButton)
    {
        if  (titleTxt.text?.count == 0) || (descText.text?.count == 0)
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
                
                self.AddNoticeAPI()
            }
        }
        
    }
    
    @IBAction func goBack(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
   
    
    
    func AddNoticeAPI()
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
      
       
            params =
                [
                    "email":userEmail,
                    "description":descText.text!,
                    "title":self.titleTxt.text!
                    
            ]
        
        
       
        
        print(params)
        WebService.shared.apiDataPostMethod(url:ADDNOTICEBOARD, parameters: params) { (response, error) in
            if error == nil
            {
                
                if let resp = response as? NSDictionary
                {
                    if let resp = resp.value(forKey: "status") as? String
                    {
                        if resp  == "success"
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
}
