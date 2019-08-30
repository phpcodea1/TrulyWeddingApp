//
//  PreRegisterWeddingViewController.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 08/07/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

class PreRegisterWeddingViewController: UIViewController,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
   
    

    @IBOutlet weak var lbl: UILabel!
    
    @IBOutlet weak var firstNameTxl: UITextField!
    @IBOutlet weak var sureNameTxt: UITextField!
    
    @IBOutlet weak var emailTxt: UITextField!
    
    @IBOutlet weak var countryTxt: UITextField!
    
    @IBOutlet weak var firstAddressTxt: UITextField!
    
    @IBOutlet weak var townCityTxt: UITextField!
    
    @IBOutlet weak var secondAddressTxt: UITextField!
    
    @IBOutlet weak var postalCodeTxt: UITextField!
    
    @IBOutlet weak var weddingDateTxt: UITextField!
    @IBOutlet weak var venueTxt: UITextField!
    
    @IBOutlet weak var checkBtn: UIButton!
    @IBOutlet weak var attendingTxt: UITextField!
    @IBOutlet weak var bridgeOrGroomTxt: UITextField!
    
    @IBOutlet weak var whereLbl: UITextField!
    
     let datePicker = UIDatePicker()
    
    let countryPicker = UIPickerView()
    
    var ShowData = NSDictionary()
    
    var SHOWID = ""
    
    var selectedCountry = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lbl.text = "I accept the terms of service and agree that Truly Scrumptious may share my information with the venue and event exhibitors."
        
        let text = (lbl.text)!
        let underlineAttriString = NSMutableAttributedString(string: text)
        let range1 = (text as NSString).range(of: "terms of service")
        underlineAttriString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range1)
        
        underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: APPCOLOR, range: range1)
        
        
//        let range2 = (text as NSString).range(of: "privacy policy")
//        underlineAttriString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range2)
//
//        underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: APPCOLOR, range: range2)
        
        
        let range3 = (text as NSString).range(of: "share my information")
        underlineAttriString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range3)
        
        
        let range4 = (text as NSString).range(of: "share my information")
        underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: APPCOLOR, range: range4)
        

        lbl.attributedText = underlineAttriString
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTermTapped(gesture:)))
//        self.lbl.addGestureRecognizer(tap)
//        self.lbl.isUserInteractionEnabled = true
        
        showDatePicker()
        self.venueTxt.delegate = self
        self.whereLbl.delegate = self
        self.attendingTxt.delegate = self
        self.bridgeOrGroomTxt.delegate = self
        
    self.showCountryPicker()
        countryPicker.delegate = self
        
        
        //self.venueTxt.addTarget(self, action: #selector(VenueSelect), for: UIControl.Event.allTouchEvents)
    }
    
    let countries = NSLocale.isoCountryCodes.map { (code:String) -> String in
        let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
        return NSLocale(localeIdentifier: "en_US").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.selectedCountry = countries[row]
       return countries[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         self.selectedCountry = countries[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count
    }
    
   
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        if textField == self.venueTxt
        {
           VenueSelect()
        }
        else if textField == self.bridgeOrGroomTxt
        {
            
            bridgeOrGroom()
        }
        else if textField == whereLbl
        {
          OptionSelect()
        }
        else if textField == attendingTxt
        {
            attenddingOption()
        }
        
        
        
    }
    
    
    
    func OptionSelect()
    {
        let optionMenu = UIAlertController(title: "Message!", message: "Where did you here about today's show?", preferredStyle: .actionSheet)
        
        let saveAction1 = UIAlertAction(title: "Google", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            self.whereLbl.text = "Google"
            print("Saved")
        })
        
        let saveAction2 = UIAlertAction(title: "Facebook", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            print("Deleted")
            self.whereLbl.text = "Facebook"
        })
        
        let saveAction3 = UIAlertAction(title: "Other Social Media", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            self.whereLbl.text = "Other Social Media"
        })
        
        let saveAction4 = UIAlertAction(title: "News Paper", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            self.whereLbl.text = "News Paper"
            print("Deleted")
        })
        
        
        
        let cancelAction = UIAlertAction(title: "None of The above", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
             self.whereLbl.text = "None of The above"
         
        })
        
        let cancelAction2 = UIAlertAction(title: "Cancel", style: .cancel, handler:
        {
            (alert: UIAlertAction!) -> Void in
           
            print("Cancelled")
        })
        
        optionMenu.addAction(saveAction1)
        optionMenu.addAction(saveAction2)
        optionMenu.addAction(saveAction3)
        optionMenu.addAction(saveAction4)
        optionMenu.addAction(cancelAction)
        optionMenu.addAction(cancelAction2)
        self.present(optionMenu, animated: true, completion: nil)
        
    }
    func bridgeOrGroom()
    {
        let optionMenu = UIAlertController(title: "Message!", message: "Are you the bride or groom?", preferredStyle: .alert)
        
        let saveAction1 = UIAlertAction(title: "Bride", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            self.bridgeOrGroomTxt.text = "Bride"
            print("Saved")
        })
        
        let saveAction2 = UIAlertAction(title: "Groom", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            print("Deleted")
            self.bridgeOrGroomTxt.text = "Groom"
        })
        
        
        optionMenu.addAction(saveAction1)
        optionMenu.addAction(saveAction2)
        self.present(optionMenu, animated: true, completion: nil)
        
    }
    
   func VenueSelect()
   {
    let optionMenu = UIAlertController(title: "Message!", message: "Did you select Venue?", preferredStyle: .alert)
    
    let saveAction1 = UIAlertAction(title: "Yes", style: .default, handler:
    {
        (alert: UIAlertAction!) -> Void in
        self.venueTxt.text = "Yes"
        print("Saved")
    })
    
    let saveAction2 = UIAlertAction(title: "No", style: .default, handler:
    {
        (alert: UIAlertAction!) -> Void in
        print("Deleted")
        self.venueTxt.text = "No"
    })
    
   
    optionMenu.addAction(saveAction1)
    optionMenu.addAction(saveAction2)
    self.present(optionMenu, animated: true, completion: nil)
    
    }
    
    
    func attenddingOption()
    {
        let optionMenu = UIAlertController(title: "Message!", message: "Wedding Show attending?", preferredStyle: .alert)
        
        let saveAction1 = UIAlertAction(title: "Yes", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            self.attendingTxt.text = "Yes"
            print("Saved")
        })
        
        let saveAction2 = UIAlertAction(title: "No", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            print("Deleted")
            self.attendingTxt.text = "No"
        })
        
        
        optionMenu.addAction(saveAction1)
        optionMenu.addAction(saveAction2)
        self.present(optionMenu, animated: true, completion: nil)
        
    }
    
    //MARK: - Datepicker
    
    func showCountryPicker(){
        
        
     
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.bordered, target: self, action: #selector(PreRegisterWeddingViewController.doneCountryPicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.bordered, target: self, action: #selector(PreRegisterWeddingViewController
            .cancelCountryPicker))
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
        countryTxt.inputAccessoryView = toolbar
        countryTxt.inputView = countryPicker
    }
     @objc func doneCountryPicker()
     {
        countryTxt.text! = self.selectedCountry
        self.view.endEditing(true)
    }
    
    @objc func cancelCountryPicker()
    {
        self.view.endEditing(true)
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
  
        weddingDateTxt.inputAccessoryView = toolbar
        weddingDateTxt.inputView = datePicker
    }
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        //formatter.dateFormat = "dd/MMM/yyyy"
        
        formatter.dateFormat = "MMMM-dd-yyyy"
        var seletedDate = formatter.string(from: datePicker.date)
        weddingDateTxt.text! = self.convertDateFormater(seletedDate)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    

   
    @IBAction func goBack(_ sender: Any)
    {
        self.navigationController?.popViewController(animated:true)
    }
    
    @IBAction func checkAction(_ sender: UIButton)
    {
        
        
        if sender.image(for: .normal) == UIImage(named: "unCheck")
        {
            sender.setImage(UIImage(named: "Checkbox"), for: .normal)
        }
        else
        {
           sender.setImage(UIImage(named: "unCheck"), for: .normal)
        }
    }
    @IBAction func registerAction(_ sender: UIButton)
    {
        if (firstNameTxl.text?.count == 0)
        {
            Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Please enter first name.")
        }
        else if  (sureNameTxt.text?.count == 0)
        {
            Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Please enter surname.")
        }
        else if  (emailTxt.text?.count == 0)
        {
            Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Please enter email.")
        }
        else if (weddingDateTxt.text?.count == 0)
        {
            Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Please select wedding date.")
        }
            
        else if checkBtn.image(for: .normal) == UIImage(named: "unCheck")
        {
              Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Please accept Terms and Conditions.")
        }
        else
        {
    
            if !(NetworkEngine.networkEngineObj.isInternetAvailable())
            {
                NetworkEngine.networkEngineObj.showInterNetAlert()
            }
            else
            {
               self.PreRegisterAPI()
            }
        }
    }
    
    func PreRegisterAPI()
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
        
        let params:[String:Any] =
            [
                "email":userEmail,
                "show_id":self.SHOWID,
                "first_name":firstNameTxl.text!,
                "sur_name":sureNameTxt.text!,
                "user_email":emailTxt.text!,
                "address_1":firstAddressTxt.text!,
                "address_2":secondAddressTxt.text!,
                "town_city":townCityTxt.text!,
                "country":countryTxt.text!,
                "postal_code":postalCodeTxt.text!,
                "wedding_date":self.convertDateFormater2(weddingDateTxt.text!),
                "booked_your_venue":venueTxt.text!,
                "hear_about_show":whereLbl.text!,
                "bride_or_groom":bridgeOrGroomTxt.text!,
                "show_attend":attendingTxt.text!
        ]
        
        
        print(params)
        WebService.shared.apiDataPostMethod(url:PREREGISTERWEDDINGSHOW, parameters: params) { (response, error) in
            if error == nil
            {
                
                
                
                if let status = (response as! NSDictionary).value(forKey: "status") as? String
                {
                    if status == "success"
                    {
                        self.navigationController?.popViewController(animated: true)
                    }
                    else
                    
                    {
                       Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr:(response as! NSDictionary).value(forKey: "message") as! String)
                    }
                   
                }
                    
                }
                
            
            else
            {
                Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr:"Error")
                
            }
            
        }
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
    
    func HearAbout()
    {
        
        let optionMenu = UIAlertController(title: nil, message: "Select No of Seat", preferredStyle: .actionSheet)
        
        let saveAction1 = UIAlertAction(title: "1", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            self.whereLbl.text = "1"
            print("Saved")
        })
        
        let saveAction2 = UIAlertAction(title: "2", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            print("Deleted")
            self.whereLbl.text = "2"
        })
        
        let saveAction3 = UIAlertAction(title: "3", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            self.whereLbl.text = "3"
        })
        
        let saveAction4 = UIAlertAction(title: "4", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            self.whereLbl.text = "4"
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
     
        
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
        
    }
    //  lbl.text = "I accept the terms of service and agree that Truly Scrumptious may share my information with the venue and event exhibitors."
 
    
    @IBAction func termService(_ sender: UIButton)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "StaticPageViewController") as! StaticPageViewController
        vc.openpath = "http://112.196.9.211:8230/wp/service-standards/"
        vc.titleShow = "Term of Services"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func shareInfo(_ sender: UIButton)
    {
       
        let vc = storyboard?.instantiateViewController(withIdentifier: "StaticPageViewController") as! StaticPageViewController
        vc.openpath = "http://112.196.9.211:8230/wp/contact-us/"
        vc.titleShow = "Share your inforamtion"
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}

