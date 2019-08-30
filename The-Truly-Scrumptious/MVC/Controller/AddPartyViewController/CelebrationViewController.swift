//
//  CelebrationViewController.swift
//  The-Truly-Scrumptious
//
//  Created by administrator on 16/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import ObjectMapper
import SDWebImage

class CelebrationViewController: UIViewController,UIGestureRecognizerDelegate {
    
    @IBOutlet weak var dayTitle: UILabel!
    @IBOutlet weak var colrHeight: NSLayoutConstraint!
    @IBOutlet weak var timerHeight: NSLayoutConstraint!
    @IBOutlet weak var hiddenView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var minsLabel: UILabel!
    @IBOutlet weak var secsLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var otherPersonTXT: UITextField!
    @IBOutlet weak var uploadView: UIView!
    @IBOutlet weak var aboutMeTXT: UITextView!
    @IBOutlet weak var celebrationDateTXT: UITextField!
    @IBOutlet weak var personNameTXT: UITextField!
    @IBOutlet weak var partyTXT: UITextField!
    
    var imagePicker = UIImagePickerController()
    var pickedImageProduct = UIImage()
    let myPickerview = UIPickerView()
    let datePicker = UIDatePicker()
    var selectedTag = 0
    var isChoosenImage = false
    var viewProfileModel:ViewProfileModel!
    var profileData:ViewData?
    var timer = Timer()
    var startTime = TimeInterval()
    var selectedDate = ""
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var btn1Color1: UIButton!
    var celetimerCount:String = ""
    var fromEdit:String = ""
    
    var allData = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showDatePicker()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        
        if let color = DEFAULT.value(forKey: "CHOOSECOLOR") as? String
        {
            if color == "1"
            {
                 self.hiddenView.backgroundColor = COLOR1
            }
            else if color == "2"
            {
                self.hiddenView.backgroundColor = COLOR2
            }
            else if color == "3"
            {
                self.hiddenView.backgroundColor = COLOR3
            }
            else if color == "4"
            {
                self.hiddenView.backgroundColor = COLOR4
            }
            else if color == "5"
            {
                self.hiddenView.backgroundColor = COLOR5
            }
            else if color == "6"
            {
                self.hiddenView.backgroundColor = COLOR6
            }
            else
            {
                self.hiddenView.backgroundColor = COLOR7
            }
         
        }
        
      
        if !(NetworkEngine.networkEngineObj.isInternetAvailable())
        {
            NetworkEngine.networkEngineObj.showInterNetAlert()
        }
        else
        {
            if allData.count>0
            {
               viewprofileAPI()
            }
            
        }
        days()
        updateTime()
        timer = Timer.scheduledTimer(timeInterval:0.5, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        if fromEdit == "yes"
        {
            self.hiddenView.isHidden = false
            self.timerHeight.constant = 70
            self.colrHeight.constant = 44

            self.colorView.isHidden = false
        }
        else{
         self.hiddenView.isHidden = true
            self.timerHeight.constant = 0
            self.colrHeight.constant = 0
             self.colorView.isHidden = true
        }
        
      
        
        let myColor : UIColor = UIColor.darkGray
        celebrationDateTXT.layer.borderColor = myColor.cgColor
        celebrationDateTXT.layer.borderColor = myColor.cgColor
        celebrationDateTXT.layer.borderWidth = 1.0
        celebrationDateTXT.layer.cornerRadius = 5
        
        let myColor1 : UIColor = UIColor.darkGray
        personNameTXT.layer.borderColor = myColor1.cgColor
        personNameTXT.layer.borderColor = myColor1.cgColor
        personNameTXT.layer.borderWidth = 1.0
        personNameTXT.layer.cornerRadius = 5
        
        let myColor2 : UIColor = UIColor.darkGray
        partyTXT.layer.borderColor = myColor2.cgColor
        partyTXT.layer.borderColor = myColor2.cgColor
        partyTXT.layer.borderWidth = 1.0
        partyTXT.layer.cornerRadius = 5
        
        let myColor3 : UIColor = UIColor.darkGray
        aboutMeTXT.layer.borderColor = myColor3.cgColor
        aboutMeTXT.layer.borderColor = myColor3.cgColor
        aboutMeTXT.layer.borderWidth = 1.0
        aboutMeTXT.layer.cornerRadius = 5
        
        let myColor4 : UIColor = UIColor.darkGray
        otherPersonTXT.layer.borderColor = myColor4.cgColor
        otherPersonTXT.layer.borderColor = myColor4.cgColor
        otherPersonTXT.layer.borderWidth = 1.0
        otherPersonTXT.layer.cornerRadius = 5
        
        uploadView.layer.shadowColor = UIColor.clear.cgColor
        uploadView.layer.shadowOpacity = 0.7
        uploadView.layer.shadowOffset = CGSize.zero
        uploadView.layer.shadowRadius = 5
        uploadView.layer.shadowPath = UIBezierPath(rect: uploadView.bounds).cgPath
        
    }
    func getDetails()
    {
//        var name = "Amar"
//        
//        if let name1 = DEFAULT.value(forKey: "name") as? String
//        {
//            name = name1
//        }
//        self.nameLabel.text! =  name
//        
//        
//        
//        if let wedding_banner_image = allData.value(forKey: "wedding_banner_image") as? String
//        {
//            let img = URL(string: wedding_banner_image)
//            
//            self.bannerImage2.sd_setImage(with: img, placeholderImage: UIImage(named: "image-1"))
//        }
//        if let myself_image = allData.value(forKey: "myself_image") as? String
//        {
//            let img = URL(string: myself_image)
//            
//            self.image1.sd_setImage(with: img, placeholderImage: UIImage(named: "image-1"))
//        }
//        if let parnter_image = allData.value(forKey: "parnter_image") as? String
//        {
//            let img = URL(string: parnter_image)
//            
//            self.image2.sd_setImage(with: img, placeholderImage: UIImage(named: "image-1"))
//        }
//        if let wedding_date = allData.value(forKey: "wedding_date") as? String
//        {
//            self.weddingDateTXT.text = wedding_date
//        }
//        if let wedding_date = allData.value(forKey: "wedding_date") as? String
//        {
//            self.dateLabel.text = wedding_date
//        }
//        if let myself = allData.value(forKey: "myself") as? String
//        {
//            self.brideTXT.text = myself
//        }
//        if let partner_name = allData.value(forKey: "partner_name") as? String
//        {
//            self.peartnerTextfiled.text = partner_name
//        }
//        if let wedding_date = allData.value(forKey: "wedding_date") as? String
//        {
//            self.weddingDateTXT.text = wedding_date
//            self.dateDiff(dateStr: wedding_date)
//        }
//        if let about_me = allData.value(forKey: "about_me") as? String
//        {
//            self.aboutMeTXT.text = about_me
//        }
//        if let parnter = allData.value(forKey: "parnter") as? String
//        {
//            self.groomTXT.text = parnter
//        }
//        
//        
//        // var name = "Amar"
//        
//        if let name1 = DEFAULT.value(forKey: "name") as? String
//        {
//            name = name1
//        }
//        self.nameLabel.text! =  name
//        
//        
//        
//        if let wedding_banner_image = allData.value(forKey: "wedding_banner_image") as? String
//        {
//            let img = URL(string: wedding_banner_image)
//            
//            self.bannerImage2.sd_setImage(with: img, placeholderImage: UIImage(named: "image-1"))
//        }
//        if let myself_image = allData.value(forKey: "myself_image") as? String
//        {
//            let img = URL(string: myself_image)
//            
//            self.image1.sd_setImage(with: img, placeholderImage: UIImage(named: "image-1"))
//        }
//        if let parnter_image = allData.value(forKey: "parnter_image") as? String
//        {
//            let img = URL(string: parnter_image)
//            
//            self.image2.sd_setImage(with: img, placeholderImage: UIImage(named: "image-1"))
//        }
//        if let wedding_date = allData.value(forKey: "wedding_date") as? String
//        {
//            self.weddingDateTXT.text = wedding_date
//        }
//        if let wedding_date = allData.value(forKey: "wedding_date") as? String
//        {
//            self.dateLabel.text = wedding_date
//        }
//        if let myself = allData.value(forKey: "myself") as? String
//        {
//            self.brideTXT.text = myself
//        }
//        if let partner_name = allData.value(forKey: "partner_name") as? String
//        {
//            self.peartnerTextfiled.text = partner_name
//        }
//        if let parnter = allData.value(forKey: "parnter") as? String
//        {
//            self.groomTXT.text = parnter
//        }
//        
//        if let wedding_date = allData.value(forKey: "wedding_date") as? String
//        {
//            self.weddingDateTXT.text = wedding_date
//        }
//        if let about_me = allData.value(forKey: "about_me") as? String
//        {
//            self.aboutMeTXT.text = about_me
//        }
//        if let my_name = allData.value(forKey: "my_name") as? String
//        {
//            self.mySelfNameTxt.text = my_name
//        }
//        
//        
//        if let color = DEFAULT.value(forKey: "CHOOSECOLOR") as? String
//        {
//            if color == "1"
//            {
//                self.timmerView.backgroundColor = COLOR1
//            }
//            else if color == "2"
//            {
//                self.timmerView.backgroundColor = COLOR2
//            }
//            else if color == "3"
//            {
//                self.timmerView.backgroundColor = COLOR3
//            }
//            else if color == "4"
//            {
//                self.timmerView.backgroundColor = COLOR4
//            }
//            else if color == "5"
//            {
//                self.timmerView.backgroundColor = COLOR5
//            }
//            else if color == "6"
//            {
//                self.timmerView.backgroundColor = COLOR6
//            }
//            else
//            {
//                self.timmerView.backgroundColor = COLOR7
//            }
//            
//        }
    }
    
    

  @objc func ImageClick()
  {
    print("Print givygucdv ")
    }
    
    
    @IBAction func backAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func uploadAction(_ sender: UIButton) {
        
        self.selectedTag = sender.tag
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        //If you want work actionsheet on ipad then you have to use popoverPresentationController to present the actionsheet, otherwise app will crash in iPad
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            alert.popoverPresentationController?.sourceView = sender
            alert.popoverPresentationController?.sourceRect = sender.bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func profileButton(_ sender: UIButton) {
        
        
        self.selectedTag = sender.tag
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        //If you want work actionsheet on ipad then you have to use popoverPresentationController to present the actionsheet, otherwise app will crash in iPad
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            alert.popoverPresentationController?.sourceView = sender
            alert.popoverPresentationController?.sourceRect = sender.bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            //If you dont want to edit the photo then you can set allowsEditing to false
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
        else{
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: - Choose image from camera roll
    
    func openGallary(){
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        //If you dont want to edit the photo then you can set allowsEditing to false
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func saveAction(_ sender: UIButton) {
        
        profileValidation()
        
        
    }
    
    
    func profileValidation()
    {
        if (partyTXT.text?.count == 0) && (personNameTXT.text?.count == 0) && (otherPersonTXT.text?.count == 0)
            && (celebrationDateTXT.text?.count == 0)
        {
            Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Please enter all details.")
        }
        else if partyTXT.text?.count == 0
        {
            Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Enter your partyname")
            
        }
        else if personNameTXT.text?.count == 0
        {
            Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Enter your firstname")
        }
        else if otherPersonTXT.text?.count == 0
        {
            Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Enter your secondname")
        }
            
//        else if aboutMeTXT.text?.count == 0
//        {
//            Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Enter about you")
//        }
            
        else{
            
            if CheckInternet.Connection()
            {
                SVProgressHUD.show()
                SVProgressHUD.setBorderColor(UIColor.white)
                SVProgressHUD.setForegroundColor(UIColor.white)
                SVProgressHUD.setBackgroundColor(UIColor.black)
                uploadImage()
            }
            else{
                Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Please Check The Internet Connection")
            }
        }
        
    }
    
    
    
    
    
    
    
    func showDatePicker(){
        
        datePicker.datePickerMode = .date
        datePicker.minimumDate = Calendar.current.date(byAdding: .year, value: 0, to: Date())
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.bordered, target: self, action: #selector(CelebrationViewController.donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.bordered, target: self, action: #selector(CelebrationViewController
            .cancelDatePicker))
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        celebrationDateTXT.inputAccessoryView = toolbar
        celebrationDateTXT.inputView = datePicker
    }
    
    @objc func donedatePicker(){
        
        
        let formatter = DateFormatter()
        //formatter.dateFormat = "dd/MM/yyyy"
        formatter.dateFormat = "dd/MMM/yyyy"

        formatter.dateFormat = "MMMM-dd-yyyy"
        
        var dateSelected = formatter.string(from: datePicker.date)
        self.selectedDate = dateSelected
        celebrationDateTXT.text! = self.convertDateFormater(dateSelected)
        
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
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
                    if let groom1 = self.viewProfileModel?.data?.celebrationTitle
                    {
                        self.partyTXT.text! = groom1
                    }
                    if let wedding = self.viewProfileModel?.data?.celebrationDate
                    {
                        self.celebrationDateTXT.text! = self.convertDateFormater(wedding)
                        //self.dateDiff(dateStr: wedding)
                    }
                    if let wedding = self.viewProfileModel?.data?.celebrationDate
                    {
                        self.dateLabel.text! = self.convertDateFormater(wedding)
                         self.dateDiff(dateStr: wedding)
                    }
                    if let venue = self.viewProfileModel?.data?.personName
                    {
                        self.personNameTXT.text! = venue
                        self.nameLabel.text! = venue
                    }
                    
                    if let headername = self.viewProfileModel?.data?.anotherPersonName
                    {
                        self.otherPersonTXT.text! = headername
                    }
                    if let headerwedding = self.viewProfileModel?.data?.aboutMe
                    {
                        self.aboutMeTXT.text! = headerwedding
                    }
                    
                    if let bannerImg = self.viewProfileModel.data?.celebrationBannerImage
                    {
                        if bannerImg != ""
                        {
                            let img = URL(string: bannerImg)
                            self.bannerImage.sd_setImage(with: img, placeholderImage: UIImage(named: "Splash-screen.png"))
                        }
                        
                    }
                    self.profileImage.layer.borderWidth = 1.0
                    self.profileImage.layer.masksToBounds = false
                    self.profileImage.layer.cornerRadius = self.profileImage.frame.size.height/2
                    // + self.profileImg2.frame.height/2
                    self.profileImage.layer.borderColor = UIColor.clear.cgColor
                    self.profileImage.clipsToBounds = true
                    
                    if let profileImg = self.viewProfileModel.data?.celebrationProfileImage
                    {
                        if profileImg != ""
                        {
                            let img = URL(string: profileImg)
                            
                            self.profileImage.sd_setImage(with: img, placeholderImage: UIImage(named: "Splash-screen.png"))
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
    
    
    
    
    func uploadImage()
    {
        
        var userEmail = ""
        if let email = DEFAULT.value(forKey: "email") as? String
        {
            userEmail = email
        }
        
        let parameters:[String:Any] = [
            "email":userEmail,
            "date":self.convertDateFormater2(self.celebrationDateTXT.text!),
            "about":aboutMeTXT.text!,
            "personname":personNameTXT.text!,
            "another_personname":otherPersonTXT.text!,
            "celebration_title":partyTXT.text!]
        
        print(parameters)
        
        guard let image1 = self.bannerImage.image else{return}
        guard let image2 = self.profileImage.image else{return}
        
        
        guard let imgData1 = image1.jpegData(compressionQuality: 0.1) else{return}
        guard let imgData2 = image2.jpegData(compressionQuality: 0.1) else{return}
        
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imgData1, withName: "celebration_banner_image",fileName:"file.jpg", mimeType:"jpg/png/jpeg")
            multipartFormData.append(imgData2, withName: "celebration_profile_image",fileName: "file.jpg", mimeType:"jpg/png/jpeg")
            
            
            
            for (key, value) in parameters
            {
                multipartFormData.append((value as! String).data(using: .utf8)!, withName: key)
            }
        },
                         usingThreshold: UInt64.init(), to: celebrationURL, method: .post) { (result) in
                            switch result {
                            case .success(let upload, _, _):
                                upload.uploadProgress(closure: { (progress) in
                                    print("proses", progress.fractionCompleted)
                                })
                                
                                upload.responseJSON { response in
                                    print("Succesfully uploaded")
                                    
                                    if let dic = response.result.value as? Dictionary<String, Any>{
                                        
                                        
                                        print(dic)
                                        SVProgressHUD.dismiss()
                                        
                                        DispatchQueue.main.async
                                            {
                                                SVProgressHUD.dismiss()
                                                self.profileImage.layer.borderWidth = 1.0
                                                self.profileImage.layer.masksToBounds = false
                                                self.profileImage.layer.cornerRadius = self.profileImage.frame.size.height/2
                                                // + self.profileImg2.frame.height/2
                                                self.profileImage.layer.borderColor = UIColor.clear.cgColor
                                                self.profileImage.clipsToBounds = true
                                                
                                                if  let  imageData = dic["data"] as? [String:Any]
                                                {
                                                    if let id =  imageData["id"] as? String
                                                    {
                                                        eve = id
                                                        defaultValues.set(id, forKey: "eventID")
                                                      
                                                    }
                                                    if let event_type =  imageData["event_type"] as? String
                                                    {
                                                        defaultValues.set(event_type, forKey: "eventType")
                                                    }
                                                    
                                                    if let userName = imageData["celebration_title"] as? String
                                                    {
                                                        self.partyTXT.text! = userName
                                                    }
                                                    //
                                                    if let partnerName =  imageData["person_name"] as? String
                                                    {
                                                        self.personNameTXT.text! = partnerName
                                                    }
                                                    if let otherpartnerName =  imageData["another_person_name"] as? String
                                                    {
                                                        self.otherPersonTXT.text! = otherpartnerName
                                                    }
                                                    if let otherpartnerName =  imageData["about_me"] as? String
                                                    {
                                                        self.aboutMeTXT.text! = otherpartnerName
                                                    }
                                                    
                                                    if let otherpartnerName =  imageData["celebration_date"] as? String
                                                    {
                                                        self.celebrationDateTXT.text! = otherpartnerName
                                                    }
                                                    
//                                                    if let otherpartnerName =  imageData["celebration_date"] as? String
//                                                    {
//                                                        self.celebrationDateTXT.text! = otherpartnerName
//                                                    }
                                                    
                                                    
                                                    if let bannerImag = imageData["celebration_banner_image"] as? String
                                                    {
                                                        if bannerImag != ""
                                                        {
                                                            let img = URL(string: bannerImag)
                                                            self.bannerImage.sd_setImage(with: img, placeholderImage: UIImage(named: "Splash-screen.png"))
                                                        }
                                                       
                                                    }
                                                    
                                                    if let profileImag = imageData["celebration_profile_image"] as? String
                                                    {
                                                        if profileImag != ""
                                                        {
                                                            let img = URL(string: profileImag)
                                                            self.profileImage.sd_setImage(with: img, placeholderImage: UIImage(named: "Splash-screen.png"))
                                                        }
                                                        
                                                   
                                                      
                                                    }
                                                    else{
                                                        self.profileImage.image =  UIImage(named: "image-1")
                                                    }
                                                    
                                                }
                                                
                                             
                                                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
                                                let navVC = UINavigationController.init(rootViewController: vc)
                                                navVC.setNavigationBarHidden(true, animated: true)
                                                if let window = UIApplication.shared.windows.first
                                                {
                                                    window.rootViewController = navVC
                                                    window.makeKeyAndVisible()
                                                }
                                        }
                                        
                                        
                                    }
                                }
                                
                            case .failure(let encodingError):
                                print(encodingError)
                            }
        }
        
        
    }
    @objc func updateTime()
    {
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day]
        formatter.maximumUnitCount = 0
       
        
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

    }
   
    
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
    
    
    //===MARK:---- calculate difference
    
    func dateDiff(dateStr:String) -> String {
        let f:DateFormatter = DateFormatter()
        f.timeZone = NSTimeZone.local
        //        f.dateFormat = "yyyy-M-dd'T'HH:mm:ss.SSSZZZ"
        f.dateFormat = "yyyy-MM-dd"
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
        
        
        
        self.daysLabel.text = timeAgo + " : "
        
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

    
    @IBAction func ColorButtonClick(_ sender: UIButton)
    {
        if sender.tag == 1
        {
            self.hiddenView.backgroundColor = COLOR1
            DEFAULT.set("1", forKey: "CHOOSECOLOR")
        }
        else  if sender.tag == 2
        {
           self.hiddenView.backgroundColor = COLOR2
            DEFAULT.set("2", forKey: "CHOOSECOLOR")
        }
        else  if sender.tag == 3
        {
            self.hiddenView.backgroundColor = COLOR3
            DEFAULT.set(
                "3", forKey: "CHOOSECOLOR")
        }
        else  if sender.tag == 4
        {
            self.hiddenView.backgroundColor = COLOR4
            DEFAULT.set("4", forKey: "CHOOSECOLOR")
        }
        else  if sender.tag == 5
        {
            self.hiddenView.backgroundColor = COLOR5
            DEFAULT.set("5", forKey: "CHOOSECOLOR")
        }
        else  if sender.tag == 6
        {
            self.hiddenView.backgroundColor = COLOR6
            DEFAULT.set("6", forKey: "CHOOSECOLOR")
        }
        else  if sender.tag == 7
        {
            self.hiddenView.backgroundColor = COLOR7
            DEFAULT.set("7", forKey: "CHOOSECOLOR")
        }
    }
    
    func convertDateFormater3(_ date: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM-dd-yyyy"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "dd MMMM yyyy"
        return  dateFormatter.string(from: date!)
        
    }
    
    func convertDateFormater(_ date: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM-dd-yyyy"
        let date2 = dateFormatter.date(from: date)
        
        
        dateFormatter.dateFormat = "dd MMMM yyyy"
        
        if date2 != nil
        {
            return  dateFormatter.string(from: date2!)
        }
        else
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date3 = dateFormatter.date(from: date)
            
            
            dateFormatter.dateFormat = "dd MMMM yyyy"
            
            if date3 != nil
            {
                return  dateFormatter.string(from: date3!)
            }
            else
            {
                return  ""
            }
            
        }
        
        
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


//MARK: - UIImagePickerControllerDelegate

extension CelebrationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.originalImage] as? UIImage else {
            return
        }
        bannerImage.contentMode = .scaleAspectFill
        profileImage.contentMode = .scaleAspectFill
        
        if let editing = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        {
        if selectedTag == 1
        {
            bannerImage.image = editing
        }
        if selectedTag == 2
        {
            profileImage.image = editing
        }
        }
        else
        {
            if selectedTag == 1
            {
                bannerImage.image = selectedImage
            }
            if selectedTag == 2
            {
                profileImage.image = selectedImage
            }
        }
        
        isChoosenImage = true
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.isNavigationBarHidden = false
        self.dismiss(animated: true, completion: nil)
    }
}

