//
//  ExpenseViewController.swift
//  The-Truly-Scrumptious
//
//  Created by administrator on 17/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit
import Alamofire
import Foundation
import SVProgressHUD
import SDWebImage

class ExpenseViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
     var categoryList = NSMutableArray()
    var pickerSelectedValue = ""
    var pickerSelectedCatId = ""
    
    @IBOutlet weak var hideView: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet var notesTxt: UITextView!
    var expenseData = NSDictionary()
    var catName2 = ""
     var catId2 = ""
    @IBOutlet var catName: UITextField!
    
    @IBOutlet var payMentLineView: UIView!
    @IBOutlet var expanseName: UITextField!
    
    @IBOutlet var expanseAmount: UITextField!
    
    
    // for picker
    
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var UiViewOfPicker: UIView!
    
    
    
    // for payment
    var fromButton = ""
    
    @IBOutlet var dateUiView: UIView!
    
    @IBOutlet var datePicker: UIDatePicker!
    
    @IBOutlet var datePaidTxt: UITextField!
    
    @IBOutlet var payerTxt: UITextField!
    @IBOutlet var amountTxt: UITextField!
    @IBOutlet var dueDateTxt: UITextField!
    
    var expense_id = ""
    var chooseCat = ""
    @IBOutlet var paidSegm: UISegmentedControl!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        catName.text = catName2
        datePicker.minimumDate = Date()
          dateUiView.isHidden = true
        UiViewOfPicker.isHidden = true
        self.payMentLineView.isHidden = true
        if !(NetworkEngine.networkEngineObj.isInternetAvailable())
        {
            NetworkEngine.networkEngineObj.showInterNetAlert()
        }
        else
        {
            ALLCATEGORYAPI()
        }
        self.view2.isHidden = true
        self.hideView.isHidden = true
        notesTxt.layer.borderWidth = 2
        notesTxt.layer.borderColor = UIColor.init(red: 211/255, green: 202/255, blue: 195/255, alpha: 1).cgColor
        
        if let expense_name = expenseData.value(forKey: "expense_name") as? String
        {
            expanseName.text! = expense_name
        }
        if let notes = expenseData.value(forKey: "notes") as? String
        {
            notesTxt.text! = notes
        }
        if let amount = expenseData.value(forKey: "amount") as? String
        {
            expanseAmount.text! = amount
        }
        if let id = expenseData.value(forKey: "id") as? String
        {
            self.expense_id = id
        }
    }
    @IBAction func savePaymentAction(_ sender: UIButton)
    {
       
        if !(NetworkEngine.networkEngineObj.isInternetAvailable())
        {
            NetworkEngine.networkEngineObj.showInterNetAlert()
        }
        else if (payerTxt.text?.count == 0) || (dueDateTxt.text?.count == 0) || (datePaidTxt.text?.count == 0) || (expanseAmount.text?.count == 0)
            
        {
            Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Please enter all details.")
        }
        else
        {
        EXPANSEPAYMENTAPI()
        }
    }
    
    @IBAction func datePaidButton(_ sender: Any)
    {
        self.fromButton = "datepaid"
        self.dateUiView.isHidden = false
    }
    
    @IBAction func dueDateButton(_ sender: Any)
    {
        self.fromButton = "datedue"
        self.dateUiView.isHidden = false
    }
    @IBAction func datePickerCancel(_ sender: UIButton)
    {
        self.dateUiView.isHidden = true
    }
    
    @IBAction func datePickerDone(_ sender: UIButton)
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        
        
       if self.fromButton == "datedue"
        {
           //dueDateTxt.text = "\(datePicker.date)"
        dueDateTxt.text = formatter.string(from: datePicker.date)
        }
        else
        
       {
       
        datePaidTxt.text = formatter.string(from: datePicker.date)
        }
        self.dateUiView.isHidden = true
    }
    
    @IBAction func goBack(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func ArrowAction(_ sender: UIButton)
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
        
        catName.text = pickerSelectedValue
        UiViewOfPicker.isHidden = true
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
    
    
    @IBAction func saveExpanseAtion(_ sender: UIButton)
    {
        
        if !(NetworkEngine.networkEngineObj.isInternetAvailable())
        {
            NetworkEngine.networkEngineObj.showInterNetAlert()
        }
        else if (expanseAmount.text?.count == 0) || (expanseName.text?.count == 0) || (notesTxt.text?.count == 0)
            
        {
            Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Please enter all details.")
        }
        else
        {
           UPDATEEXPENSEAPI()
        }
    }
    
    @IBAction func expenseAction(_ sender: UIButton) {
        self.view2.isHidden = true
        self.payMentLineView.isHidden = true
        self.view1.isHidden = false
        self.hideView.isHidden = true
    }
    
    
    @IBAction func paymentsAction(_ sender: UIButton) {
        self.view2.isHidden = false
        self.view1.isHidden = true
        self.payMentLineView.isHidden = false
        self.hideView.isHidden = false
    }
    
    
    func ALLCATEGORYAPI()
    {
        
        
        WebService.shared.apiDataGetMethod(url:ALLCATEGORY) { (response, error) in
            if error == nil
            {
                
                
                if let data = (response as! NSDictionary).value(forKey: "data") as? NSArray
                {
                    
                    
                    self.categoryList = data.mutableCopy() as! NSMutableArray
                    for i in 0..<self.categoryList.count
                    {
                        var dict = self.categoryList.object(at: i) as! NSDictionary
                        var category_name = dict.value(forKey: "category_name") as! String
                        if self.catName2 == category_name
                        {
                           self.pickerView.selectRow(i, inComponent: 0, animated: true)
                        }
                        
                        
                    }
                    
                    self.pickerView.reloadAllComponents()
                }
                
            }
            else
            {
                Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr:"Error")
                
            }
            
        }
    }
    
    func UPDATEEXPENSEAPI()
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
                "expense_id":self.expense_id,
                "event_type":eventType,
                "expense":expanseName.text!,
                "cat_id": catId,
                "amount":expanseAmount.text!,
                "notes":notesTxt.text!
        ]
        
        
        print(params)
        WebService.shared.apiDataPostMethod(url:UPDATEEXPENSE, parameters: params) { (response, error) in
            if error == nil
            {
                
                
                if let data1 = (response as! NSDictionary).value(forKey: "message") as? String
                {
                    if data1 == "successfully"
                    {
                        self.showMessage()
                        
                    }
                    
                    
                    
                }
                
            }
            else
            {
                Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr:"Error")
                
            }
            
        }
    }
    func EXPANSEPAYMENTAPI()
    {
        SVProgressHUD.show()
        SVProgressHUD.setBorderColor(UIColor.white)
        SVProgressHUD.setForegroundColor(UIColor.white)
        SVProgressHUD.setBackgroundColor(UIColor.black)
        
        var eventType = "celebaration"
        var eventID = "1"
        var userEmail = ""
        if let email = DEFAULT.value(forKey: "email") as? String
        {
            userEmail = email
        }
        
        if let eventType1 = DEFAULT.value(forKey: "eventType") as? String
        {
            eventType = eventType1
        }
        
        var userPaid = "1"
       
        if paidSegm.selectedSegmentIndex == 0
        {
            userPaid = "1"
        }
        else
        {
           userPaid = "0"
        }
        
        
        let params:[String:Any] = [
            "email":userEmail,
            "paid_status":userPaid,
            "paid_amount":expanseAmount.text!,
            "payer":payerTxt.text!,
            "date_paid":self.convertDateFormater2(datePaidTxt.text!),
            "due_date":self.convertDateFormater2(dueDateTxt.text!),
            "expense_id":self.expense_id,
        ]
        
        
        print(params)
        print("para in save = \(params)")
        Alamofire.request(EXPANSEPAYMENT, method: .post, parameters: params, encoding: URLEncoding.httpBody).responseString
            {
                response in
                switch response .result {
                case .success:
                    
                    
                    var a = response.result.value as! String
                    var b = response.result.value as! String
                    var data = a.replacingOccurrences(of: " ", with: "")
                    var data3 = a.replacingOccurrences(of: "900", with: "")
                    var data2 = b.replacingOccurrences(of: "null", with: "")
                    
                    
                    if let data = data3.data(using: String.Encoding.utf8)
                    {
                        print("data in \(data)")
                        do {
                            if let dict = try JSONSerialization.jsonObject(with: data, options:.mutableLeaves) as? [String: Any]
                            {
                                print("dic t converted \(dict)")
                                if let msg = dict["message"] as? String
                                {
                                    if msg == "successfully"
                                    {
                                     self.showMessage()
                                    }
                                    else
                                    {
                                        Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr:"Error")
                                    }
                                }
                               
                                
                             
                            }
                            
                            
                            
                            
                            SVProgressHUD.dismiss()
                        }
                        catch
                        {
                            
                            SVProgressHUD.dismiss()
                            
                        }
                    }
                    else
                    {
                        print("else resp \(response)")
                    }
                    
                    
                    
                    
                    SVProgressHUD.dismiss()
                    
                case .failure(let error):
                    
                    print(error)
                    SVProgressHUD.dismiss()
                }
                // SVProgressHUD.dismiss()
        }
        
         //SVProgressHUD.dismiss()
    }
    func showMessage()
    {
        let optionMenu = UIAlertController(title: "Message!", message: "sucessfully!", preferredStyle: .alert)
        
        
        
        let deleteAction = UIAlertAction(title: "Ok", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            self.navigationController?.popViewController(animated: true)
        })
        
        
        optionMenu.addAction(deleteAction)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    func convertDateFormater2(_ date: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if date != nil
        {
            return  dateFormatter.string(from: date!)
        }
        else
        {
            return  ""
        }
        
    }

}
