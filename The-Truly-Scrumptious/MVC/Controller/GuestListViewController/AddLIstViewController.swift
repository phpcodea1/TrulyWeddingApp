//
//  AddLIstViewController.swift
//  The-Truly-Scrumptious
//
//  Created by administrator on 22/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit
import TextFieldEffects
import Alamofire
import ObjectMapper
import IQKeyboardManager
class AddLIstViewController: UIViewController,UIGestureRecognizerDelegate,UIPickerViewDelegate,UIPickerViewDataSource  {
    
    
      @IBOutlet var UiViewOfPicker: UIView!
       @IBOutlet var pickerView: UIPickerView!
    var categoryList = NSMutableArray()
    
    var pickerSelectedValue = ""
    var pickerSelectedCatId = ""
    
    
    
    @IBOutlet var adultSegmt: UISegmentedControl!
    @IBOutlet var yesSegmt: UISegmentedControl!
    @IBOutlet var groupView: UIView!
    
    
    @IBOutlet var firstNameTxt: UITextField!
    
    @IBOutlet var groupNameTxt: UITextField!
    
    @IBOutlet weak var lastNameTxt: UITextField!
    
    @IBOutlet var tableNameTxt: UITextField!
    
    @IBOutlet var notes: IQTextView!
    
    @IBOutlet var emailTxt: UITextField!
    @IBOutlet var phoneNumberTxt: UITextField!
    @IBOutlet var mobileNameTxt: UITextField!
    
    
    
    @IBOutlet var addressTxt: UITextField!
    @IBOutlet var cityTownTxt: UITextField!
    @IBOutlet var stateTxt: UITextField!
    
    
    @IBOutlet var postalCodeTxt: UITextField!
    // @IBOutlet var notesTxt: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
       UiViewOfPicker.isHidden = true
       UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        
        // adultSegmt.layer.borderWidth = 1
        //adultSegmt.layer.borderColor = BORDERCOLOR.cgColor
        adultSegmt.layer.cornerRadius = adultSegmt.frame.height/2
        
        
        // attendSegmt.layer.borderWidth = 1
        // attendSegmt.layer.borderColor = BORDERCOLOR.cgColor
        adultSegmt.layer.cornerRadius = adultSegmt.frame.height/2
        
        if !(NetworkEngine.networkEngineObj.isInternetAvailable())
        {
            NetworkEngine.networkEngineObj.showInterNetAlert()
        }
        else
        {
            ALLCATEGORYAPI()
        }
        
        
        self.adultSegmt.layer.cornerRadius = adultSegmt.frame.height/2
        self.adultSegmt.layer.borderColor = BORDERCOLOR.cgColor
        self.adultSegmt.layer.borderWidth = 1
        self.adultSegmt.layer.masksToBounds = true
        
        
        self.yesSegmt.layer.cornerRadius = yesSegmt.frame.height/2
        self.yesSegmt.layer.borderColor = BORDERCOLOR.cgColor
        self.yesSegmt.layer.borderWidth = 1
        self.yesSegmt.layer.masksToBounds = true
        
        
        
        let Img1 = UITapGestureRecognizer(target: self, action: #selector(self.groupViewClick))
        Img1.delegate = self // This is not required
        groupView.addGestureRecognizer(Img1)
        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        var title1 = ""
        if let title = (self.categoryList.object(at: row) as! NSDictionary).value(forKey: "group_name") as? String
        {
            title1 = title
            
        }
        pickerSelectedValue = title1
        var id1 = ""
        if let id = (self.categoryList.object(at: row) as! NSDictionary).value(forKey: "id") as? String
        {
            self.pickerSelectedCatId = id
            
        }
         self.groupNameTxt.text = pickerSelectedValue
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        var title1 = ""
        if let title = (self.categoryList.object(at: row) as! NSDictionary).value(forKey: "group_name") as? String
        {
            title1 = title
            
        }
        pickerSelectedValue = title1
        if let id = (self.categoryList.object(at: row) as! NSDictionary).value(forKey: "id") as? String
        {
            self.pickerSelectedCatId = id
            
        }
        self.groupNameTxt.text = pickerSelectedValue
        
        return title1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryList.count
    }
    
    
    
    @IBAction func groupDropDown(_ sender: UIButton)
    {
        //Groupmenu()
        lastNameTxt.resignFirstResponder()
        firstNameTxt.resignFirstResponder()
        UiViewOfPicker.isHidden = false
    }
    
    @objc func groupViewClick()
    {
       // Groupmenu()
        lastNameTxt.resignFirstResponder()
        firstNameTxt.resignFirstResponder()
        UiViewOfPicker.isHidden = false
    }
    @IBAction func openPickerBtn(_ sender: Any)
    {
        
    }
    @IBAction func cancelPicker(_ sender: UIButton)
    {
        UiViewOfPicker.isHidden = true
    }
    
    
    @IBAction func donePicker(_ sender: Any)
    {
        
        groupNameTxt.text = pickerSelectedValue
        UiViewOfPicker.isHidden = true
    }
    
    
    @IBAction func saveGuestList(_ sender: UIButton)
    {
        validation()
    }
    @IBAction func goBack(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    func validation()
    {
        if (firstNameTxt.text?.count == 0) || (lastNameTxt.text?.count == 0)
            
        {
            Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Please enter Name")
        }
        else if (emailTxt.text?.count == 0)
            
        {
            Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Please enter Email.")
        }
        else
        {
            if CheckInternet.Connection()
            {
                self.AddGuestListAPI()
            }
                
                
            else{
                Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Please Check The Internet Connection")
            }
        }
    }
    
    func AddGuestListAPI()
    {
        
        var userEmail = "jass@gmail.com"
        var userage = "adult"
        if let email = DEFAULT.value(forKey: "email") as? String
        {
            userEmail = email
        }
        if adultSegmt.selectedSegmentIndex == 0
        {
            userage = "Adult"
        }
        else if adultSegmt.selectedSegmentIndex == 1
        {
            userage = "Child"
        }else
        {
            userage = "Baby"
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
            "guest_email":emailTxt.text!,
            "first_name":firstNameTxt.text!,
            "last_name":lastNameTxt.text!,
            "group_id":self.pickerSelectedCatId,
            "age_level":userage,
            "phone_number":phoneNumberTxt.text!,
            "mobile_number":mobileNameTxt.text!,
            "address":addressTxt.text!,
            "city_town":cityTownTxt.text!,
            "state":stateTxt.text!,
            "zipcode":postalCodeTxt.text!,
            "notes":notes.text!,
            "event_id":eventID,
            "event_type":eventType]
        
        WebService.shared.apiDataPostMethod(url:addGuestURL, parameters: params) { (response, error) in
            if error == nil
            {
                
                print("Response in api = \(response)")
                
                if let resp = response as? NSDictionary
                {
                    if resp.value(forKey: "message") as! String == "successfully"
                    {
                        //Helper.helper.showAlertMessage(vc: self, titleStr: "Message!", messageStr:"Add guest successfully!")
                        self.navigationController?.popViewController(animated: true)
                    }
                }
                
                /*
                 self.loginModelData = Mapper<LoginModel>().map(JSONObject: response)
                 
                 if self.loginModelData?.status == "success"
                 {
                 
                 
                 let tokenObj = self.loginModelData?.data?.userPass ?? ""
                 defaultValues.setValue(tokenObj, forKey: AppLoginToken)
                 defaultValues.synchronize()
                 //
                 //                    let name = self.loginModelData?.data?.name
                 //                    defaultValues.set(name, forKey: "name")
                 //
                 
                 let email = self.loginModelData?.data?.userEmail
                 defaultValues.set(email, forKey: "email")
                 //
                 //                    let mobileNumber = self.loginModelData?.data?.mobileNumber
                 //                    defaultValues.set(mobileNumber, forKey: "mobileNumber")
                 //
                 //                    let weddingDate = self.loginModelData?.data?.weddingDate
                 //                    defaultValues.set(weddingDate, forKey: "WeddingDate")
                 //
                 //
                 
                 let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SubHome_VC") as! SubHome_VC
                 
                 self.navigationController?.pushViewController(vc, animated: true)
                 
                 
                 //                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabViewController") as! TabViewController
                 //
                 //
                 //                    let navVC = UINavigationController.init(rootViewController: vc)
                 //                    navVC.setNavigationBarHidden(true, animated: true)
                 //                    if let window = UIApplication.shared.windows.first
                 //                    {
                 //                        window.rootViewController = navVC
                 //                        window.makeKeyAndVisible()
                 //                    }
                 //
                 }
                 else if self.loginModelData?.status == "fail"
                 {
                 Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr:self.loginModelData?.message ?? "")
                 
                 }
                 
                 */
            }
        }
        
        
        
    }
    
    func Groupmenu()
    {
        let optionMenu = UIAlertController(title: nil, message: "Select group", preferredStyle: .actionSheet)
        
        let saveAction1 = UIAlertAction(title: "Couples", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            self.groupNameTxt.text = "Couples"
            print("Saved")
        })
        
        let saveAction2 = UIAlertAction(title: "Family friends of my partner", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            print("Deleted")
            self.groupNameTxt.text = "Family friends of my partner"
        })
        
        let saveAction3 = UIAlertAction(title: "Family friends of Rajesh", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            self.groupNameTxt.text = "Family friends of Rajesh"
        })
        
        let saveAction4 = UIAlertAction(title: "Mutual friends", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            self.groupNameTxt.text = "Mutual friends"
            print("Deleted")
        })
        
        let saveAction5 = UIAlertAction(title: "Partner's coworkers", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            self.groupNameTxt.text = "Partner's coworkers"
            print("Saved")
        })
        let saveAction6 = UIAlertAction(title: "Partner's family", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            self.groupNameTxt.text = "Partner's family"
            print("Deleted")
        })
        
        let saveAction7 = UIAlertAction(title: "Partner's friends", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            self.groupNameTxt.text = "Partner's friends"
            print("Deleted")
        })
        
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:
        {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        optionMenu.addAction(saveAction1)
        optionMenu.addAction(saveAction2)
        optionMenu.addAction(saveAction3)
        optionMenu.addAction(saveAction4)
        optionMenu.addAction(saveAction5)
        optionMenu.addAction(saveAction6)
        optionMenu.addAction(saveAction7)
        
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    
    func ALLCATEGORYAPI()
    {
        
        
        WebService.shared.apiDataGetMethod(url:GUESTGROUPNAME) { (response, error) in
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
}
