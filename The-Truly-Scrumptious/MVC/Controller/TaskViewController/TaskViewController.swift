//
//  TaskViewController.swift
//  The-Truly-Scrumptious
//
//  Created by administrator on 16/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet var descrptionTXT: UITextView!
    
    @IBOutlet var taskName: UITextField!
    @IBOutlet var catName: UITextField!
    @IBOutlet var UiViewOfPicker: UIView!
     @IBOutlet var pickerView: UIPickerView!
    
    var categoryList = NSMutableArray()
    
    var pickerSelectedValue = ""
    var pickerSelectedCatId = ""
    
    
    var TaskData = NSDictionary()
     var fromEdit = ""
    var task_Id = ""
    var Edit_cat_Id = ""
    var open_picker = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myColor : UIColor = UIColor.lightGray
        descrptionTXT.layer.borderColor = myColor.cgColor
        descrptionTXT.layer.borderWidth = 0.5
        descrptionTXT.layer.cornerRadius = 10
        if !(NetworkEngine.networkEngineObj.isInternetAvailable())
        {
            NetworkEngine.networkEngineObj.showInterNetAlert()
        }
        else
        {
            ALLCATEGORYAPI()
        }
       
        UiViewOfPicker.isHidden = true
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if TaskData.count>0
        {
            var dict = TaskData
            
            if let task_category_name = dict.value(forKey: "task_category_name") as? String
            {
               catName.text! = task_category_name
            }
            
            if let task_name = dict.value(forKey: "description") as? String
            {
                descrptionTXT.text! = task_name
            }
            if let created_at = dict.value(forKey: "task_name") as? String
            {
                taskName.text! = created_at
            }
            if let cat_id = dict.value(forKey: "cat_id") as? String
            {
                Edit_cat_Id = cat_id
            }
            if let id = dict.value(forKey: "id") as? String
            {
                task_Id = id
            }
            
            
        }
    }
    
    @IBAction func goBack(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func openPickerBtn(_ sender: Any)
    {
        open_picker = "yes"
        UiViewOfPicker.isHidden = false
    }
    @IBAction func cancelPicker(_ sender: UIButton)
    {
        UiViewOfPicker.isHidden = true
    }
    
    
    @IBAction func donePicker(_ sender: Any)
    {
        
     catName.text = pickerSelectedValue
        UiViewOfPicker.isHidden = true
    }
    
    
    @IBAction func saveAction(_ sender: UIButton)
    {
        if !(NetworkEngine.networkEngineObj.isInternetAvailable())
        {
            NetworkEngine.networkEngineObj.showInterNetAlert()
        }
        else if (descrptionTXT.text?.count == 0) || (taskName.text?.count == 0) || (catName.text?.count == 0)
            
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
                if self.fromEdit == "yes"
                {
                    
                    self.EditTASKAPI()
                }
                else
                {
                    AddTASKAPI()
                }
            }
            
           
            
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        var title1 = ""
        if let title = (self.categoryList.object(at: row) as! NSDictionary).value(forKey: "task_category_name") as? String
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
        if let title = (self.categoryList.object(at: row) as! NSDictionary).value(forKey: "task_category_name") as? String
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
    
    
    @IBAction func menuIcon(_ sender: UIButton)
    {
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let saveAction = UIAlertAction(title: "Edit task", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            print("Saved")
        })
        
        let deleteAction = UIAlertAction(title: "Delete task", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            print("Deleted")
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:
        {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(saveAction)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    
    func ALLCATEGORYAPI()
    {
        
        
        WebService.shared.apiDataGetMethod(url:ALLTASKCAT) { (response, error) in
            if error == nil
            {
                
                
                if let data = (response as! NSDictionary).value(forKey: "data") as? NSArray
                {
                    
                    
                    self.categoryList = data.mutableCopy() as! NSMutableArray
//                    for i in 0..<self.categoryList.count
//                    {
//                        var dict = self.categoryList.object(at: i) as! NSDictionary
//                        var category_name = dict.value(forKey: "category_name") as! String
//                        if self.catName2 == category_name
//                        {
//                            self.pickerView.selectRow(i, inComponent: 0, animated: true)
//                        }
//
//
//                    }
                    
                    self.pickerView.reloadAllComponents()
                }
                
            }
            else
            {
                Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr:"Error")
                
            }
            
        }
    }
    func AddTASKAPI()
    {
        
        var userEmail = "jass@gmail.com"
        var userage = "adult"
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
        
        let params:[String:Any] = [
            "email":userEmail,
            "event_id":eventID,
            "event_type":eventType,
            "taskname":taskName.text!,
            "cat_id":pickerSelectedCatId,
            "description":descrptionTXT.text!]
        
        WebService.shared.apiDataPostMethod(url:ADDTASK, parameters: params) { (response, error) in
            if error == nil
            {
                
                print("Response in api = \(response)")
                
                if let resp = response as? NSDictionary
                {
                    if resp.value(forKey: "message") as! String == "successfully"
                    {
                        
                        self.navigationController?.popViewController(animated: true)
                    }
                }
                
               
            }
        }
    }
    
    func EditTASKAPI()
    {
        
        var userEmail = "jass@gmail.com"
        var userage = "adult"
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
        var catID = ""
        if let eventID1 = DEFAULT.value(forKey: "eventID") as? String
        {
            eventID = eventID1
        }
        if open_picker == "yes"
        {
             catID = self.pickerSelectedCatId
            
        }
        else
        {
          catID = self.Edit_cat_Id
        }
        
        let params:[String:Any] = [
            "email":userEmail,
            "task_id":self.task_Id,
            "task_name":taskName.text!,
            "cat_id":catID,
            "description":descrptionTXT.text!]
        
        WebService.shared.apiDataPostMethod(url:EDITTASK, parameters: params) { (response, error) in
            if error == nil
            {
                
                print("Response in api = \(response)")
                
                if let resp = response as? NSDictionary
                {
                    if resp.value(forKey: "message") as! String == "Update Successfully"
                    {
                        
                        self.navigationController?.popViewController(animated: true)
                    }
                }
                
                
            }
        }
    }
}
