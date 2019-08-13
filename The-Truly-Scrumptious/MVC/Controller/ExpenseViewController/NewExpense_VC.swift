//
//  NewExpense_VC.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 20/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit
import IQKeyboardManager
class NewExpense_VC: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource{
   
  
    
    var expenseData = NSDictionary()
    var catName2 = ""
    var catId2 = ""
    var expense_id = ""
    var chooseCat = ""
    
    @IBOutlet weak var textview1: UITextView!
    
    
    @IBOutlet var UiViewOfPicker: UIView!

    @IBOutlet var venueTxt: UITextField!
    
    @IBOutlet var notesTxt: IQTextView!
    @IBOutlet var pickerView: UIPickerView!
    
    @IBOutlet var costTct: UITextField!
    @IBOutlet var nameOfExpTxt: UITextField!
    
    var categoryList = NSMutableArray()
    
    var pickerSelectedValue = ""
    var pickerSelectedCatId = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let myColor : UIColor = UIColor.lightGray
        textview1.layer.borderColor = myColor.cgColor
        textview1.layer.borderWidth = 0.5
        textview1.layer.cornerRadius = 10
        venueTxt.text = catName2
        
        if !(NetworkEngine.networkEngineObj.isInternetAvailable())
        {
            NetworkEngine.networkEngineObj.showInterNetAlert()
        }
        else
        {
            
           ALLCATEGORYAPI()
        }
        UiViewOfPicker.isHidden = true
    }
    
    @IBAction func goBack(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        var title1 = ""
        if let title = (self.categoryList.object(at: row) as! NSDictionary).value(forKey: "category_name") as? String
        {
            title1 = title
            
        }
     pickerSelectedValue = title1
        var id1 = ""
        if let id = (self.categoryList.object(at: row) as! NSDictionary).value(forKey: "id") as? String
        {
              self.pickerSelectedCatId = id
            
        }
     
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        var title1 = ""
     if let title = (self.categoryList.object(at: row) as! NSDictionary).value(forKey: "category_name") as? String
     {
        title1 = title
       
      }
         pickerSelectedValue = title1
        if let id = (self.categoryList.object(at: row) as! NSDictionary).value(forKey: "id") as? String
        {
            self.pickerSelectedCatId = id
            
        }
    return title1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryList.count
    }
    
    
    
    @IBAction func saveExpanceAction(_ sender: UIButton)
    {
        
        if (nameOfExpTxt.text?.count == 0) || (costTct.text?.count == 0) || (venueTxt.text?.count == 0) || (notesTxt.text?.count == 0)
            
        {
            Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Please enter all details.")
        }
            
        else
        {
            if CheckInternet.Connection()
            {
                self.ADDEXPENSEAPI()
            }
                
                
            else{
                Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Please Check The Internet Connection")
            }
        }
        
    }
    @IBAction func openPickerBtn(_ sender: Any)
    {
        self.chooseCat = "yes"
        UiViewOfPicker.isHidden = false
    }
    @IBAction func cancelPicker(_ sender: UIButton)
    {
         UiViewOfPicker.isHidden = true
    }
    
    
    @IBAction func donePicker(_ sender: Any)
    {
       
        venueTxt.text = pickerSelectedValue
        UiViewOfPicker.isHidden = true
    }
    
    func ADDEXPENSEAPI()
    {
        var userEmail = ""
        if let email = DEFAULT.value(forKey: "email") as? String
        {
            userEmail = email
        }
        var eventType = "celebaration"
        var eventID = "1"
        if let eventType1 = DEFAULT.value(forKey: "eventType") as? String
        {
            eventType = eventType1
        }
        if let eventID1 = DEFAULT.value(forKey: "eventID") as? String
        {
            eventID = eventID1
        }
        var catId = "2"
        if self.chooseCat == "yes"
        {
            
            catId = self.pickerSelectedCatId
        }
        else
        {
            catId = self.catId2
        }
        let params:[String:Any] =
            [
                "email":userEmail,
                "event_id":eventID,
                "event_type":eventType,
                "expense":nameOfExpTxt.text!,
                "cat_id": catId,
                "amount":costTct.text!,
                 "notes":notesTxt.text!
        ]
        
        
        print(params)
        WebService.shared.apiDataPostMethod(url:ADDEXPENSE, parameters: params) { (response, error) in
            if error == nil
            {
                
              
                if let data = (response as! NSDictionary).value(forKey: "data") as? NSDictionary
                {
               self.showMessage()
               
              
                }
                
            }
            else
            {
                Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr:"Error")
                
            }
            
        }
    }
    
    
    func ALLCATEGORYAPI()
    {
    
    
        WebService.shared.apiDataGetMethod(url:ALLCATEGORY) { (response, error) in
            if error == nil
            {
                
                
                if let data = (response as! NSDictionary).value(forKey: "data") as? NSArray
                {
              
                    
                    self.categoryList = data.mutableCopy() as! NSMutableArray
                    self.pickerView.reloadAllComponents()
                }
                
            }
            else
            {
                Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr:"Error")
                
            }
            
        }
    }

    func showMessage()
    {
        let optionMenu = UIAlertController(title: "Message!", message: "Added sucessfully!", preferredStyle: .alert)
        
       
        
        let deleteAction = UIAlertAction(title: "Ok", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
                  self.navigationController?.popViewController(animated: true)
        })
        
       
        optionMenu.addAction(deleteAction)
      
        self.present(optionMenu, animated: true, completion: nil)
    }
}
