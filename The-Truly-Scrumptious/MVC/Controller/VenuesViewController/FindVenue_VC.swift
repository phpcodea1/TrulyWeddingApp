//
//  FindVenue_VC.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 23/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit
import CoreLocation

class FindVenue_VC: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate {

    
    
    var typeLat = ""
    
    var typeLong = ""
    
    var catId = ""
    var civilCeremony = ""
    var noOfSeat = ""
    
    
    var searchlat = ""
    var searchLong = ""
    
    var fromHome = ""
    
    
    @IBOutlet weak var venueCatTxt: UITextField!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var locationTXT: UITextField!
    
    @IBOutlet weak var seatLbl: UILabel!
    
    
    @IBOutlet weak var yesBtn: UIButton!
    
    @IBOutlet weak var noBtn: UIButton!
    
    let categoryPicker = UIPickerView()
    
    var selectedCountry = ""
    var selectedCountryId = ""
    
    var categoryArray = NSArray()
    
    
    @IBOutlet weak var capcitySlider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myColor : UIColor = UIColor.darkGray
        locationTXT.layer.borderColor = myColor.cgColor
        locationTXT.layer.borderColor = myColor.cgColor
        locationTXT.layer.borderWidth = 1.0
        locationTXT.layer.cornerRadius = 5
        
        locationTXT.delegate = self
        
        locationTXT.addTarget(self, action: #selector(searchHere), for: .editingChanged)
        
        venueCatTxt.layer.borderColor = myColor.cgColor
        venueCatTxt.layer.borderColor = myColor.cgColor
        venueCatTxt.layer.borderWidth = 1.0
        venueCatTxt.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
        catApiCall()
        self.showCategoryPicker()
        categoryPicker.delegate = self
        
       
        
       
    }
    
    @IBAction func clearFilter(_ sender: UIButton)
    {
        self.capcitySlider.setValue(0, animated: true)
        self.seatLbl.text = "\(Int(capcitySlider.value))"
        
        self.locationTXT.text = ""
        self.venueCatTxt.text = ""
        self.seatLbl.text = "0"
        
        DEFAULT.set("", forKey: "typeLat")
        DEFAULT.set("", forKey: "typeLong")
        DEFAULT.set("" , forKey: "selectedCountryId")
        DEFAULT.set("", forKey: "civilCeremony")
        DEFAULT.set("", forKey: "noOfSeat")
    }
    @objc func searchHere(textField:UITextField)
    {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(textField.text!) { (placemarks, error) in
            if error == nil
            {
            if let placemarks = placemarks,let location = placemarks.first?.location
            {
                 print("placemarks is \(placemarks)")
            }
            }
           
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        if textField.text! != ""
        {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(textField.text!) { (placemarks, error) in
            if error == nil
            {
                if let placemarks = placemarks,let lat = placemarks.first?.location?.coordinate.latitude ,let long = placemarks.first?.location?.coordinate.longitude
                {
                    
                    print("placemarks is \(placemarks)")
                    print("lat is \(lat)")
                    print("long is \(long)")
                    self.typeLat = "\(lat)"
                    self.typeLong = "\(long)"
                    
                }
                else
                {
                   Helper.helper.showAlertMessage(vc: self, titleStr: "Alert!", messageStr:"Please enter valid venue name")
                }
                
            }
            else
            {
               Helper.helper.showAlertMessage(vc: self, titleStr: "Alert!", messageStr:"Please enter valid venue name")
            }
          
        }
        }
        else
        {
            self.typeLat = ""
            self.typeLong = ""
            
        }
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        var dict = self.categoryArray.object(at: row) as! NSDictionary
        
        if let name = dict.value(forKey: "venue_category") as? String
        {
            self.selectedCountry = name
        }
        if let id = dict.value(forKey: "id") as? String
        {
            self.selectedCountryId = id
        }
        
        return self.selectedCountry
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var dict = self.categoryArray.object(at: row) as! NSDictionary
        
        if let name = dict.value(forKey: "venue_category") as? String
        {
            self.selectedCountry = name
        }
        if let id = dict.value(forKey: "id") as? String
        {
            self.selectedCountryId = id
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return categoryArray.count
    }
    
    //MARK: - Datepicker
    
    func showCategoryPicker(){
        
        
        
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.bordered, target: self, action: #selector(PreRegisterWeddingViewController.doneCountryPicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.bordered, target: self, action: #selector(PreRegisterWeddingViewController
            .cancelCountryPicker))
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
        venueCatTxt.inputAccessoryView = toolbar
        venueCatTxt.inputView = categoryPicker
    }
    @objc func doneCountryPicker()
    {
        venueCatTxt.text! = self.selectedCountry
        self.view.endEditing(true)
    }
    
    @objc func cancelCountryPicker()
    {
        self.view.endEditing(true)
    }
    
    
    @IBAction func backAction(_ sender: UIButton) {
        
        
        
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
//
//                vc.hideMainView = "Find your"
//
//
//                    let navVC = UINavigationController.init(rootViewController: vc)
//                    navVC.setNavigationBarHidden(true, animated: true)
//                   // SCANNERDATA = "X"
//                    if let window = UIApplication.shared.windows.first
//                    {
//                        window.rootViewController = navVC
//                        window.makeKeyAndVisible()
//                    }
    self.navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func byLocationAct(_ sender: UIButton) {
    }
    
    
    @IBAction func byNameAct(_ sender: UIButton)
    {
        
    }
    @IBAction func CivilYesAct(_ sender: UIButton)
    {
    self.civilCeremony = "1"
    yesBtn.backgroundColor = UIColor.init(red: 227/255, green: 227/255, blue: 227/255, alpha: 1)
         noBtn.backgroundColor = UIColor.init(red: 85/255, green: 85/255, blue: 85/255, alpha: 1)
    }
    
    
    @IBAction func civilNoAct(_ sender: UIButton)
    {
        self.civilCeremony = "0"
        noBtn.backgroundColor = UIColor.init(red: 227/255, green: 227/255, blue: 227/255, alpha: 1)
        yesBtn.backgroundColor = UIColor.init(red: 85/255, green: 85/255, blue: 85/255, alpha: 1)
    }
    @IBAction func sliderValue(_ sender: UISlider)
    {
        self.seatLbl.text = "\(Int(capcitySlider.value))"
    }
    @IBAction func searchAction(_ sender: UIButton)
    {
       // let vc = self.storyboard?.instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
         let vc = storyboard?.instantiateViewController(withIdentifier: "VenuePricing_VC") as! VenuePricing_VC
        
          DEFAULT.set(self.typeLat, forKey: "typeLat")
         DEFAULT.set(self.typeLong, forKey: "typeLong")
         DEFAULT.set(self.selectedCountryId , forKey: "selectedCountryId")
         DEFAULT.set(self.civilCeremony, forKey: "civilCeremony")
          DEFAULT.set("\(self.seatLbl.text!)", forKey: "noOfSeat")
        
//        vc.searchlat = self.typeLat
//        vc.searchLong = self.typeLong
//
//        vc.catId = self.selectedCountryId
//        vc.noOfSeat = "\(self.seatLbl.text!)"
//
//        vc.civilCeremony = self.civilCeremony
//
//
//        vc.backhide = "yes"
//        vc.viewHide = "yes"
//        vc.tittleChange = "header"
      
        
        
      
        if fromHome == "yes"
        {
            
            vc.backhide = "yes"
            vc.viewHide = "yes"
            vc.tittleChange = "header"
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else
        {
           self.navigationController?.popViewController(animated: true)
        }
        
        //self.navigationController?.pushViewController(vc, animated: true)
       
    }
    
  func catApiCall()
  {
    
        var userEmail = ""
        if let email = DEFAULT.value(forKey: "email") as? String
        {
            userEmail = email
        }
    
        
        let params:[String:Any] =
            [
                "email":userEmail]
        
        
        print(params)
        WebService.shared.apiDataPostMethod(url:VENUECATNAME, parameters: params) { (response, error) in
            if error == nil
            {
                
                
                
                if let status = (response as! NSDictionary).value(forKey: "status") as? String
                {
                    if status == "success"
                    {
                      if let data = (response as! NSDictionary).value(forKey: "data") as? NSArray
                      {
                        self.categoryArray = data
                        }
                    }
                    
                    
                }
                self.categoryPicker.reloadAllComponents()
                
            }
                
                
            else
            {
                Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr:"Error")
                
            }
            
        }
    
   
    }
    
    
}
