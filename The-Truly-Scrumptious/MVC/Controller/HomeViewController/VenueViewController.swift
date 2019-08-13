//
//  VenueViewController.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 14/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import MapKit
import CoreLocation

class VenueViewController: UIViewController,UIGestureRecognizerDelegate,CLLocationManagerDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var colorView: UIView!
    var countdownTimer: Timer!
    var totalTime = 60

    var total_budget = ""
    
    @IBOutlet var profileImg1: UIImageView!    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var budgetView: UIView!
    @IBOutlet weak var TodolistView: UIView!
    @IBOutlet weak var guestListView: UIView!
    @IBOutlet weak var hideView: UIView!
    @IBOutlet var scrollView1: UIScrollView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet var ViewHegiht: NSLayoutConstraint!
//  @IBOutlet weak var searchTXT: UITextField!
    @IBOutlet weak var supplierTXT: UITextField!
    @IBOutlet weak var weddingLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var changeImage: UIImageView!
    @IBOutlet var celibrationView: UIView!
    @IBOutlet var wedingView: UIView!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet var image123: UIImageView!
    @IBOutlet weak var celbrationButon: UIButton!
    @IBOutlet weak var weddingButton: UIButton!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var minsLabel: UILabel!
    @IBOutlet weak var secsLabel: UILabel!
    @IBOutlet weak var weedingUIVeiw: UIView!
    @IBOutlet weak var celebrationUiView: UIView!
    @IBOutlet weak var girlProfileBtn: UIButton!
    @IBOutlet weak var boysProfileBtn: UIButton!
    @IBOutlet weak var weedingGirlImage: UIImageView!
    @IBOutlet weak var weddingBoysImage: UIImageView!
    @IBOutlet weak var weddingCoupNameLbl: UILabel!
    
    var locationManager = CLLocationManager()
    var timer = Timer()
    var startTime = TimeInterval()
    var dataDict = NSDictionary()
    var ischoose = "Wedding"
    var ischoose1 = "Celebration"
    var tittle2:String = ""
    var image:String = ""
    var name:String = ""
    var hideMainView:String = "Hide"
    var viewProfileModel:ViewProfileModel!
    var profileData:ViewData?
    
    @IBOutlet weak var dayTitle: UILabel!
    
 //    homeLabel total
    
    
    @IBOutlet weak var todoLbl: UILabel!
    
    @IBOutlet weak var totalToDoLbl: UILabel!
    
    @IBOutlet weak var budgetLbl: UILabel!
    
    @IBOutlet weak var totalBudgetLbl: UILabel!
    
    @IBOutlet weak var totalGuestLbl: UILabel!
    
    @IBOutlet weak var guestLbl: UILabel!
    
    
    var typeLat = ""
    
   var typeLong = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DEFAULT.removeObject(forKey: "noOfSeat")
        DEFAULT.removeObject(forKey: "civilCeremony")
        DEFAULT.removeObject(forKey: "selectedCountryId")
        DEFAULT.removeObject(forKey: "typeLong")
        DEFAULT.removeObject(forKey: "typeLat")
        DEFAULT.synchronize()
        
        
       // supplierTXT.delegate = self
        
       // supplierTXT.addTarget(self, action: #selector(searchHere), for: .editingChanged)
        
        
        
        print("")
        
        if !(NetworkEngine.networkEngineObj.isInternetAvailable())
        {
            NetworkEngine.networkEngineObj.showInterNetAlert()
        }
        else
        {
            viewprofileAPI()
        }
      
        
      //  self.nameLabel.text! = displayName ?? ""
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        days()
        updateTime()
        timer = Timer.scheduledTimer(timeInterval:0.5, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
       
        
//        let myColor : UIColor = UIColor.darkGray
//        supplierTXT.layer.borderColor = myColor.cgColor
//        supplierTXT.layer.borderColor = myColor.cgColor
//        supplierTXT.layer.borderWidth = 1.0
//        supplierTXT.layer.cornerRadius = 5
        let myColor1 : UIColor = UIColor.darkGray
//        searchTXT.layer.borderColor = myColor1.cgColor
//        searchTXT.layer.borderColor = myColor1.cgColor
//        searchTXT.layer.borderWidth = 1.0
//        searchTXT.layer.cornerRadius = 5
        
       
        
        var eventType = "celebaration"
        var eventID = "1"
        if let eventType1 = DEFAULT.value(forKey: "eventType") as? String
        {
            eventType = eventType1
            
            
        }
        if eventType == "wedding"
        {
            self.weedingUIVeiw.isHidden = false
             self.celebrationUiView.isHidden = true
        }
        else
        {
            self.celebrationUiView.isHidden = false
            self.weedingUIVeiw.isHidden = true
        }
        
        if let color = DEFAULT.value(forKey: "CHOOSECOLOR") as? String
        {
            if color == "1"
            {
                self.colorView.backgroundColor = COLOR1
            }
            else if color == "2"
            {
                self.colorView.backgroundColor = COLOR2
            }
            else if color == "3"
            {
                self.colorView.backgroundColor = COLOR3
            }
            else if color == "4"
            {
                self.colorView.backgroundColor = COLOR4
            }
            else if color == "5"
            {
                self.colorView.backgroundColor = COLOR5
            }
            else if color == "6"
            {
                self.colorView.backgroundColor = COLOR6
            }
            else
            {
                self.colorView.backgroundColor = COLOR7
            }
            
        }
       
    }
    
    @IBAction func searchButton(_ sender: UIButton)
    {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
       
                vc.searchlat = self.typeLat
                 vc.searchLong = self.typeLong
        
                self.navigationController?.pushViewController(vc, animated: true)
            
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        DEFAULT.removeObject(forKey: "noOfSeat")
        DEFAULT.removeObject(forKey: "civilCeremony")
        DEFAULT.removeObject(forKey: "selectedCountryId")
        DEFAULT.removeObject(forKey: "typeLong")
        DEFAULT.removeObject(forKey: "typeLat")
        DEFAULT.synchronize()
    print("Home appear data=  ")
        
        print(DEFAULT.value(forKey: "email") as! String)
        print(DEFAULT.value(forKey: "eventType") as! String)
        print(DEFAULT.value(forKey: "eventID") as! String)
        
       
        
       // self.supplierTXT.text = ""
        
        if !(NetworkEngine.networkEngineObj.isInternetAvailable())
        {
            NetworkEngine.networkEngineObj.showInterNetAlert()
        }
        else
        {
           viewprofileAPI()
        }
        
        
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        var eventType = "celebaration"
        var eventID = "1"
        if let eventType1 = DEFAULT.value(forKey: "eventType") as? String
        {
            eventType = eventType1
            
            
        }
        if eventType == "wedding"
        {
            self.weedingUIVeiw.isHidden = false
            self.celebrationUiView.isHidden = true
            
        }
        else
        {
            self.celebrationUiView.isHidden = false
            self.weedingUIVeiw.isHidden = true
        }
        
        if let color = DEFAULT.value(forKey: "CHOOSECOLOR") as? String
        {
            if color == "1"
            {
                self.colorView.backgroundColor = COLOR1
            }
            else if color == "2"
            {
                self.colorView.backgroundColor = COLOR2
            }
            else if color == "3"
            {
                self.colorView.backgroundColor = COLOR3
            }
            else if color == "4"
            {
                self.colorView.backgroundColor = COLOR4
            }
            else if color == "5"
            {
                self.colorView.backgroundColor = COLOR5
            }
            else if color == "6"
            {
                self.colorView.backgroundColor = COLOR6
            }
            else
            {
                self.colorView.backgroundColor = COLOR7
            }
            
        }
        
        
        
    }
    
    @IBAction func weddingProfileAction(_ sender: UIButton)
    {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "WeddingViewController") as! WeddingViewController
        vc.allData = self.dataDict
        vc.timerCount = "yes"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func updateTime()
    {
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day]
        formatter.maximumUnitCount = 0
        //formatter.unitsStyle = .brief
       // daysLabel.text = String(describing: formatter)
        
       // daysLabel.text = formatter.string(from: Date(), to: datePicker.date) ?? ""
       // UserDefaults.standard.string(forKey: "daysLabel")
        
        //defaultValues.synchronize()
        
        //  hrsLabel.text = formatter.string(from: Date(), to: datePicker.date) ?? ""
        
        
        
        let date = Date()
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([.day, .hour, .minute, .second], from: date)
        
        let currentDate = calendar.date(from: components)
        
        let userCalendar = Calendar.current
        
        var birthdayDate = DateComponents()
        //Get user's birthday
        
        birthdayDate.month = 10
        birthdayDate.day = 30
        birthdayDate.hour = 24
        birthdayDate.minute = 60
        birthdayDate.second = 60
        
        
        let birthday = userCalendar.date(from: birthdayDate as DateComponents)
        let BirthdayDifference = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate!, to: birthday!)
        
        let daysLeft = BirthdayDifference.day
        let hoursLeft = BirthdayDifference.hour
        let minutesLeft = BirthdayDifference.minute
        let secondsLeft = BirthdayDifference.second
        
        
        hoursLabel.text = String(hoursLeft!)
        minsLabel.text = String(minutesLeft!)
        secsLabel.text = String(secondsLeft!)
        
    }
    @objc func createCountdown(){
        
        
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .hour, .minute, .second], from: date)
        let currentDate = calendar.date(from: components)
        let userCalendar = Calendar.current
        var birthdayDate = DateComponents()
        
        //Get user's birthday
        birthdayDate.month = 10
        birthdayDate.day = 30
        birthdayDate.hour = 24
        birthdayDate.minute = 60
        birthdayDate.second = 60
        
        
        let birthday = userCalendar.date(from: birthdayDate as DateComponents)
        let BirthdayDifference = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate!, to: birthday!)
        //        let daysLeft = BirthdayDifference.day
        //        let hoursLeft = BirthdayDifference.hour
        //        let minutesLeft = BirthdayDifference.minute
        //        let secondsLeft = BirthdayDifference.second
        
        
        
    }
    
    
//
    // MARK :- Dates Difference
    func days()
    {
        let dateRangeStart = Date()
        let dateRangeEnd = Date().addingTimeInterval(12345678)
        let components = Calendar.current.dateComponents([.weekOfYear, .month], from: dateRangeStart, to: dateRangeEnd)
        
        print(dateRangeStart)
        print(dateRangeEnd)
        print("difference is \(components.month ?? 0) months and \(components.weekOfYear ?? 0) weeks")
        
        
        let months = components.month ?? 0
//      /  self.daysLabel.text = "\(months)"
    
    }
    
   
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let _ :CLLocation = locations[0] as CLLocation
        
        if let lastLocation = locations.last {
            let geocoder = CLGeocoder()
            
            geocoder.reverseGeocodeLocation(lastLocation) { [weak self] (placemarks, error) in
                if error == nil {
                    if let firstLocation = placemarks?[0],
                        let cityName = firstLocation.locality
                        
                    {
                        self?.weddingLabel.text! = cityName
                        self?.locationManager.stopUpdatingLocation()
                    }
                }
            }
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
    
    @IBAction func profilAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }

    
    
    
    
    func viewprofileAPI()
    {
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
        if let eventID1 = DEFAULT.value(forKey: "eventID") as? String
        {
            eventID = eventID1
        }

        
        let params:[String:Any] = [
            "email":userEmail,
            "event_id":eventID,
            "event_type":eventType
        ]
        
        
        print(params)
        WebService.shared.apiDataPostMethod(url:viewProfileURL, parameters: params) { (response, error) in
            if error == nil
            {
                self.viewProfileModel = Mapper<ViewProfileModel>().map(JSONObject: response)
                
                if self.viewProfileModel?.status == "success"
                {
                    if let data = (response as! NSDictionary).value(forKey: "data") as? NSDictionary
                    {
                        self.dataDict = data
                    }
                   
                    
                   
                    
                    
                    if let venue = self.viewProfileModel?.data?.personName
                    {
                        self.nameLabel.text! = venue
                        self.name = venue

                    }
                    if let venue1 = self.viewProfileModel?.data?.anotherPersonName
                    {

                        self.weddingCoupNameLbl.text! = venue1

                    }
                    if let weddingDate = self.viewProfileModel?.data?.celebrationDate
                    {
                        self.dateLabel.text! = self.convertDateFormater(weddingDate)
                        
                        self.dateDiff(dateStr: weddingDate)
                    }
                    
                    if let bannerImg = self.viewProfileModel.data?.celebrationBannerImage
                    {
                        let img = URL(string: bannerImg)
                        self.changeImage.sd_setImage(with: img, placeholderImage: nil)
                    }
                    if let profileImg = self.viewProfileModel.data?.celebrationProfileImage
                    {
                        let img = URL(string: profileImg)
                        
                        
                        self.image123.layer.borderWidth = 1.0
                        self.image123.layer.masksToBounds = false
                        self.image123.layer.cornerRadius = self.image123.frame.size.height/2
                        self.image123.layer.borderColor = UIColor.clear.cgColor
                        self.image123.clipsToBounds = true
                        
    
                        self.image123.sd_setImage(with: img, placeholderImage: nil)
                    }
                    
                    
                    if let dict = response as? NSDictionary
                    {
                        if let dataDict = (dict.value(forKey: "data")) as? NSDictionary
                        {
                            
                            if let id = dataDict.value(forKey: "id") as? String
                                
                            {
                                
                                DEFAULT.set(id, forKey: "eventID")
                                DEFAULT.synchronize()
                                
                            }
                            
                            if let event_type = dataDict.value(forKey: "event_type") as? String
                                
                            {
                                
                                DEFAULT.set(event_type, forKey: "eventType")
                                DEFAULT.synchronize()
                                
                            }
                            
                            
                            if let parnter = dataDict.value(forKey: "parnter") as? String
                                {
                                    self.nameLabel.text! = parnter
                                 }
                            if let total_budget1 = dataDict.value(forKey: "total_budget") as? String
                            {
                                self.total_budget = total_budget1
                            }
                            
                            // home label here
                            
                            
                            // budget
                            
                            if let total_expense = dataDict.value(forKey: "total_expense") as? String
                            {
                                self.budgetLbl.text =  total_expense
                            }
                            if let total_budget1 = dataDict.value(forKey: "total_budget") as? String
                            {
                                self.totalBudgetLbl.text =  " of " + total_budget1
                            }
                            
                            if let total_expense = dataDict.value(forKey: "total_expense") as? String
                            {
                                self.budgetLbl.text =  total_expense
                            }
                            else
                            {
                               self.budgetLbl.text =  "\(0)"
                            }
                            
                            // guest
                            if let total_guest = dataDict.value(forKey: "total_guest") as? String
                            {
                                self.totalGuestLbl.text =  " of " + total_guest
                            }
                            
                            if let attend_guest = dataDict.value(forKey: "attend_guest") as? String
                            {
                                self.guestLbl.text =  attend_guest
                            }
                            else
                            {
                                self.guestLbl.text =  "\(0)"
                            }
                            // list
                            
                            if let total_task = dataDict.value(forKey: "total_task") as? String
                            {
                                self.totalToDoLbl.text =  " of " + total_task
                            }
                            
                            if let pending_task = dataDict.value(forKey: "pending_task") as? String
                            {
                                self.todoLbl.text =  pending_task
                            }
                            else
                            {
                                self.todoLbl.text =  "\(0)"
                            }
                            
                            if let id = dataDict.value(forKey: "id") as? String
                                
                            {
                                
                                DEFAULT.set(id, forKey: "eventID")
                                DEFAULT.synchronize()
                               
                            }
                            
                            if let event_type = dataDict.value(forKey: "event_type") as? String
                                
                            {
                               
                                DEFAULT.set(event_type, forKey: "eventType")
                                DEFAULT.synchronize()
                               
                            }
                          
                            
                            
                            
                            
                            if let person_name = dataDict.value(forKey: "person_name") as? String
                            {
                                DEFAULT.set(person_name, forKey: "PERSONNAME")
                                DEFAULT.synchronize()
                            }
                            
                            if let wedding_date = dataDict.value(forKey: "wedding_date") as? String
                            {
                                
                                self.dateLabel.text! = self.convertDateFormater(wedding_date)
                                self.dateDiff(dateStr: wedding_date)
                            }
                            
                            if let parnter = dataDict.value(forKey: "parnter_image") as? String
                            {
                                let img = URL(string: parnter)
                                self.image123.layer.borderWidth = 1.0
                                self.image123.layer.masksToBounds = false
                                self.image123.layer.cornerRadius = self.image123.frame.size.height/2
                                // + self.profileImg2.frame.height/2
                                self.image123.layer.borderColor = UIColor.clear.cgColor
                                self.image123.clipsToBounds = true
                                self.image123.sd_setImage(with: img, placeholderImage: nil)
                                
                            }
                            self.weedingGirlImage.layer.borderWidth = 1.0
                            self.weedingGirlImage.layer.masksToBounds = false
                            self.weedingGirlImage.layer.cornerRadius = self.weedingGirlImage.frame.size.height/2
                            // + self.profileImg2.frame.height/2
                            self.weedingGirlImage.layer.borderColor = UIColor.clear.cgColor
                            self.weedingGirlImage.clipsToBounds = true
                            
                            if let parnter = dataDict.value(forKey: "parnter_image") as? String
                            {
                                let img = URL(string: parnter)
                                self.weedingGirlImage.sd_setImage(with: img, placeholderImage:nil)
                            }
                            
                            
                            
                            self.weddingBoysImage.layer.borderWidth = 1.0
                            self.weddingBoysImage.layer.masksToBounds = false
                            self.weddingBoysImage.layer.cornerRadius = self.weedingGirlImage.frame.size.height/2
                            // + self.profileImg2.frame.height/2
                            self.weddingBoysImage.layer.borderColor = UIColor.clear.cgColor
                            self.weddingBoysImage.clipsToBounds = true
                            
                            if let myself_image = dataDict.value(forKey: "myself_image") as? String
                            {
                                let img = URL(string: myself_image)
                                
                                self.weddingBoysImage.sd_setImage(with: img, placeholderImage: nil)
                                
                                
                            }
                            if let wedding_banner_image = dataDict.value(forKey: "wedding_banner_image") as? String
                            {
                                let img = URL(string: wedding_banner_image)
                                self.changeImage.sd_setImage(with: img, placeholderImage: nil)
                            }
                            var eventType = "celebaration"
                            var name = "Amar"
                            if let eventType1 = DEFAULT.value(forKey: "eventType") as? String
                            {
                                eventType = eventType1
                            }
                            if let eventType1 = DEFAULT.value(forKey: "another_person_name") as? String
                            {
                                name = eventType1
                                self.weddingCoupNameLbl.text! = name
                            }
                            if let eventType1 = DEFAULT.value(forKey: "name") as? String
                            {
                                name = eventType1
                          
                            }
                            if eventType == "wedding"
                            {
                                if let my_name = dataDict.value(forKey: "my_name") as? String
                                {
                                    
                                  name = my_name
                                }
                                
                                if let partner_name = dataDict.value(forKey: "partner_name") as? String
                                {
                                    
//                                    self.weddingCoupNameLbl.text! = partner_name + " & " + name
//                                    self.nameLabel.text! = partner_name + " & " + name
                                    self.weddingCoupNameLbl.text! = name + " & " + partner_name
                                    DEFAULT.set(name, forKey: "FIRSTNAME")
                                     DEFAULT.set(partner_name, forKey: "SECONDNAME")
                                    
                                    DEFAULT.synchronize()
                                    
                                   self.nameLabel.text! = name + " & " + partner_name
                                }
                            }
                            else
                            {
                                self.celebrationUiView.isHidden = false
                                self.weedingUIVeiw.isHidden = true
                            }
                        }
                        
                    }
                  
                }
                    
                    
                else
                {
                    Helper.helper.showAlertMessage(vc:self, titleStr: "Notification", messageStr: error?.localizedDescription ?? "")
                    
                }
                
                
            }
            
        }
        
    }
    
   
    @IBAction func homeAction(_ sender: UIButton) {
        
    }
    @IBAction func menuHomeAction(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FindVenue_VC") as! FindVenue_VC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func menuAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FindVenue_VC") as! FindVenue_VC
        vc.fromHome = "yes"
       
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func editProfileAction(_ sender: UIButton) {
        
        
  
        var eventType = "celebration"
        var eventID = "1"
        if let eventType1 = DEFAULT.value(forKey: "eventType") as? String
        {
            eventType = eventType1
        }
        if eventType.lowercased() == "wedding"
        {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "WeddingViewController") as! WeddingViewController
            vc.allData = self.dataDict
            vc.timerCount = "yes"
            vc.fromEdit = "yes"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else
        {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CelebrationViewController") as! CelebrationViewController
            vc.allData = self.dataDict
            vc.celetimerCount = "yes"
            vc.fromEdit = "yes"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
//        self.hideView.isHidden = true
//        profileButton.isHidden = false
//        self.scrollView1.isScrollEnabled  = true
    }
    
    
    
    
    @objc func handleTap()
    {
        
        
    }
    @objc func handleTap2()
    {
        
    }
    
    @IBAction func ToDoAction(_ sender: UIButton) {
        
        print("fedwgefhnf")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CheckListViewController") as! CheckListViewController
        vc.fromBack = "yes"
        self.navigationController?.pushViewController(vc, animated: true)
        
        
        
    }
    @IBAction func GuestAction(_ sender: UIButton) {
        
        print("fedwgefhnf")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "GuestListViewController") as! GuestListViewController
        vc.fromBack = "yes"
        self.navigationController?.pushViewController(vc, animated: true)
        
        
        
    }
    @IBAction func weddingAction(_ sender: UIButton) {
        
        print("fedwgefhnf")
        self.headerLabel.text! = "Home"
        //self.nameLabel.text! = "Taylor & Johnson"
        self.weddingLabel.text! = "Wedding  & Occassions"
        self.profileImg1.isHidden = false
        // self.hideView.isHidden = true
        self.scrollView1.isScrollEnabled  = true
        profileButton.isHidden = false
        self.changeImage.image = UIImage(named: "image")
        
    }
    @IBAction func budgetAction(_ sender: UIButton)
    {
        print("fedwgefhnf")
        if self.total_budget == ""
        {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditBudgetViewController") as! EditBudgetViewController
            vc.fromBack = "yes"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else
        {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "BudgetVC") as! BudgetVC
            vc.budgetAmount = self.total_budget
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
       
    }
    
    @IBAction func celbrationAction(_ sender: UIButton) {
        print("fedwgefhnf")
        self.headerLabel.text! = "Celebration"
     //   self.nameLabel.text! = "Johnson"
        self.weddingLabel.text! = "Rio Cornival & Occassions"
        self.changeImage.image = UIImage(named: "image2-1")
        self.profileImg1.isHidden = true
        // self.hideView.isHidden = true
        self.scrollView1.isScrollEnabled  = true
        profileButton.isHidden = false
        
        
    }
  
    //===MARK:---- calculate difference
    
    func dateDiff(dateStr:String) -> String {
        let f:DateFormatter = DateFormatter()
        f.timeZone = NSTimeZone.local
        //        f.dateFormat = "yyyy-M-dd'T'HH:mm:ss.SSSZZZ"
        f.dateFormat = "MMMM-dd-yyyy"
        let now = f.string(from: NSDate() as Date)
        let startDate = f.date(from: dateStr)
        let endDate = f.date(from: now)
        let calendar: NSCalendar = NSCalendar.current as NSCalendar
        
        let calendarUnits:NSCalendar.Unit = [.day, .hour, .minute, .second]
        //let calendarUnits:NSCalendar.Unit = [.year,.month,.weekOfMonth,.day, .hour, .minute, .second]
        let dateComponents = calendar.components(calendarUnits, from: startDate!, to: endDate!, options: [])
      // let weeks = abs(Int32(dateComponents.weekOfMonth!))
        //let month = abs(Int32(dateComponents.month!))
        // let year = abs(Int32(dateComponents.year!))
        let days = abs(Int32(dateComponents.day!))
        let hours = abs(Int32(dateComponents.hour!))
        let min = abs(Int32(dateComponents.minute!))
        let sec = abs(Int32(dateComponents.second!))
        
        var timeAgo = ""
    
            if (sec > 0)
            {
                if (sec == 1)
                {
                    timeAgo = "\(sec)"
                } else {
                    timeAgo = "\(sec)"
                }
            }
            
            if (min > 0){
                if (min == 1) {
                    timeAgo = "\(min)"
                } else {
                    timeAgo = "\(min)"
                }
            }
            
            if(hours > 0){
                if (hours == 1) {
                    timeAgo = "\(hours)"
                } else {
                    timeAgo = "\(hours)"
                }
            }
            
            if (days > 0) {
                if (days == 1) {
                    timeAgo = "\(days)"
                } else {
                    timeAgo = "\(days)"
                }
            }
            
//            if(weeks > 0){
//                if (weeks == 1) {
//                    timeAgo = "\(weeks) Week"
//                } else {
//                    timeAgo = "\(weeks) Weeks"
//                }
//            }
//        if(month > 0){
//            if (weeks == 1) {
//                timeAgo = "\(month) month"
//            } else {
//                timeAgo = "\(month) months"
//            }
//        }
//        if(year > 0){
//            if (year == 1) {
//                timeAgo = "\(year) year"
//            } else {
//                timeAgo = "\(year) years"
//            }
//        }
      
      //  timeAgo = self.daysLabel.text! + ":"
        self.daysLabel.text!  = timeAgo + " : "
        if timeAgo == ""
        {
            dayTitle.isHidden = true
        }
        else
        {
            if timeAgo == "1"
            {
                dayTitle.text = "day"
            }
            else
            {
                dayTitle.text = "days"
            }
            dayTitle.isHidden = false
        }
        print("timeAgo is===> \(timeAgo)")
        return timeAgo;
    }
    func convertDateFormater(_ date: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM-dd-yyyy"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "dd MMMM yyyy"
        return  dateFormatter.string(from: date!)
        
    }
    
    func VenueByNameAPI()
    {
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
        if let eventID1 = DEFAULT.value(forKey: "eventID") as? String
        {
            eventID = eventID1
        }
        
        
        let params:[String:Any] = [
            "email":userEmail,
            "venue_name":""]
        
        
        print(params)
        WebService.shared.apiDataPostMethod(url:VENUEBYNAME, parameters: params) { (response, error) in
            if error == nil
            {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
                
                
               
                
                if let dict = response as? NSDictionary
                {
                    if let dataDict = (dict.value(forKey: "data")) as? NSArray
                    {
                        vc.MainArray = dataDict.mutableCopy() as! NSMutableArray
                        
                       self.navigationController?.pushViewController(vc, animated: true)
                    }
                    
                }
                
            }
                
                
            else
            {
                Helper.helper.showAlertMessage(vc:self, titleStr: "Notification", messageStr: error?.localizedDescription ?? "")
                
            }
            
            
        }
        
    }
    func VenueFilter()
    {
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
        if let eventID1 = DEFAULT.value(forKey: "eventID") as? String
        {
            eventID = eventID1
        }
        
        
        let params:[String:Any] = [
            "email":userEmail,
            "seat_capacity":"",
            "civil_ceremony":"",
            "lat":"",
            "long":"",
            "cat_id":""]
        
        
        print(params)
        WebService.shared.apiDataPostMethod(url:VENUEFILTER, parameters: params) { (response, error) in
            if error == nil
            {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
                
                
                
                
                if let dict = response as? NSDictionary
                {
                    if let dataDict = (dict.value(forKey: "data")) as? NSArray
                    {
                        vc.MainArray = dataDict.mutableCopy() as! NSMutableArray
                        
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    
                }
                
            }
                
                
            else
            {
                Helper.helper.showAlertMessage(vc:self, titleStr: "Notification", messageStr: error?.localizedDescription ?? "")
                
            }
            
            
        }
        
    }
    
}
