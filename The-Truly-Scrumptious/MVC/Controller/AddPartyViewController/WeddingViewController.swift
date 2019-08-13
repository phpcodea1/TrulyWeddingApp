//
//  WeddingViewController.swift
//  The-Truly-Scrumptious
//
//  Created by administrator on 16/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire
import SVProgressHUD


//protocol DataEnteredDelegate: class {
//    func userDidEnterInformation(info: String)
//}
//

class WeddingViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate {
    
    @IBOutlet weak var mySelfNameTxt: UITextField!
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var timmerView: UIView!
    
    @IBOutlet weak var timerHegiht: NSLayoutConstraint!
    
    @IBOutlet weak var dayTitle: UILabel!
    
    @IBOutlet weak var colorHeight: NSLayoutConstraint!
    @IBOutlet weak var bannerImage2: UIImageView!
    
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var uploadView: UIView!
    @IBOutlet weak var groomTXT: UITextField!
    @IBOutlet weak var brideTXT: UITextField!
    @IBOutlet weak var weddingDateTXT: UITextField!
    @IBOutlet var image1: UIImageView!
    @IBOutlet weak var aboutMeTXT: UITextView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    @IBOutlet weak var hrsLabel: UILabel!
    @IBOutlet weak var minsLabel: UILabel!
    
    @IBOutlet weak var peartnerTextfiled: UITextField!
    var groomArray = ["Groom","Bride","Other"]
    var imagePicker = UIImagePickerController()
    var pickedImageProduct = UIImage()
    let myPickerview = UIPickerView()
    let myPickerView1 = UIPickerView()
    var weddingData:WeddingModel!
    var isChoosenImage = false
    var selectedTag = 0
    var allData = NSDictionary()
    let datePicker = UIDatePicker()
    var nameArray = [String]()
    var timer = Timer()
    var startTime = TimeInterval()
    
    var seletedDate = ""
    @IBOutlet weak var profileHeight: NSLayoutConstraint!
    var timerCount:String = ""
     var fromEdit:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
       self.navigationController?.setNavigationBarHidden(true, animated: true)
       
        if timerCount == "yes"
        {
             days()
            updateTime()
            timer = Timer.scheduledTimer(timeInterval:0.5, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            
        }
        if fromEdit == "yes"
        {
            self.timmerView.isHidden = false
            self.timerHegiht.constant = 61
            self.colorHeight.constant = 44
            self.profileHeight.constant  = 10

            self.colorView.isHidden = false
        }
        else{
            self.timmerView.isHidden = true
            self.timerHegiht.constant = 0
            self.colorHeight.constant = 0
            self.profileHeight.constant  = 2
            self.colorView.isHidden = true
        }
        
        getDetails()
        
        let myColor : UIColor = UIColor.darkGray
        groomTXT.layer.borderColor = myColor.cgColor
        groomTXT.layer.borderColor = myColor.cgColor
        groomTXT.layer.borderWidth = 1.0
        groomTXT.layer.cornerRadius = 5
        
        
        
        let myColorX : UIColor = UIColor.darkGray
        mySelfNameTxt.layer.borderColor = myColorX.cgColor
        mySelfNameTxt.layer.borderColor = myColorX.cgColor
        mySelfNameTxt.layer.borderWidth = 1.0
        mySelfNameTxt.layer.cornerRadius = 5
        
        
        let myColor1 : UIColor = UIColor.darkGray
        brideTXT.layer.borderColor = myColor1.cgColor
        brideTXT.layer.borderColor = myColor1.cgColor
        brideTXT.layer.borderWidth = 1.0
        brideTXT.layer.cornerRadius = 5
        
        let myColor2 : UIColor = UIColor.darkGray
        weddingDateTXT.layer.borderColor = myColor2.cgColor
        weddingDateTXT.layer.borderColor = myColor2.cgColor
        weddingDateTXT.layer.borderWidth = 1.0
        weddingDateTXT.layer.cornerRadius = 5
        
        let myColor3 : UIColor = UIColor.darkGray
        aboutMeTXT.layer.borderColor = myColor3.cgColor
        aboutMeTXT.layer.borderColor = myColor3.cgColor
        aboutMeTXT.layer.borderWidth = 1.0
        aboutMeTXT.layer.cornerRadius = 5
        
        let myColor4 : UIColor = UIColor.darkGray
        peartnerTextfiled.layer.borderColor = myColor4.cgColor
        peartnerTextfiled.layer.borderColor = myColor4.cgColor
        peartnerTextfiled.layer.borderWidth = 1.0
        peartnerTextfiled.layer.cornerRadius = 5
        
        
        uploadView.layer.shadowColor = UIColor.clear.cgColor
        uploadView.layer.shadowOpacity = 0.7
        uploadView.layer.shadowOffset = CGSize.zero
        uploadView.layer.shadowRadius = 5
        uploadView.layer.shadowPath = UIBezierPath(rect: uploadView.bounds).cgPath
        
        
        showDatePicker()
        
        groomTXT.inputView = myPickerview
        brideTXT.inputView = myPickerView1
        
        myPickerview.delegate  = self
        myPickerview.dataSource = self
        
        myPickerView1.delegate  = self
        myPickerView1.dataSource = self
        
        brideTXT.delegate = self
        groomTXT.delegate  = self
       
        
        days()
        updateTime()
        timer = Timer.scheduledTimer(timeInterval:0.5, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
        }
    
    
    @IBAction func ColorButtonClick(_ sender: UIButton)
    {
        if sender.tag == 1
        {
            self.timmerView.backgroundColor = COLOR1
            DEFAULT.set("1", forKey: "CHOOSECOLOR")
        }
        else  if sender.tag == 2
        {
            self.timmerView.backgroundColor = COLOR2
            DEFAULT.set("2", forKey: "CHOOSECOLOR")
        }
        else  if sender.tag == 3
        {
            self.timmerView.backgroundColor = COLOR3
            DEFAULT.set(
                "3", forKey: "CHOOSECOLOR")
        }
        else  if sender.tag == 4
        {
            self.timmerView.backgroundColor = COLOR4
            DEFAULT.set("4", forKey: "CHOOSECOLOR")
        }
        else  if sender.tag == 5
        {
            self.timmerView.backgroundColor = COLOR5
            DEFAULT.set("5", forKey: "CHOOSECOLOR")
        }
        else  if sender.tag == 6
        {
            self.timmerView.backgroundColor = COLOR6
            DEFAULT.set("6", forKey: "CHOOSECOLOR")
        }
        else  if sender.tag == 7
        {
            self.timmerView.backgroundColor = COLOR7
            DEFAULT.set("7", forKey: "CHOOSECOLOR")
        }
    }
    
//
//    @objc func updateTime()
//    {
//        let currentTime = NSDate.timeIntervalSinceReferenceDate
//        var elapsedTime : TimeInterval = currentTime - startTime
//
//        let hours = UInt32(elapsedTime / 3600.0)
//        elapsedTime -= (TimeInterval(hours) * 3600)
//
//        let minutes = UInt8(elapsedTime / 60.0)
//        elapsedTime -= (TimeInterval(minutes) * 60)
//
//        let seconds = UInt8(elapsedTime)
//        elapsedTime -= TimeInterval(seconds)
//
//        //let strHours = String(format: "%02", hours)
//        let strMinutes = String(format: "%02d", minutes)
//        let strSeconds = String(format: "%02d", seconds)
//
//        //hoursLabel.text = "\(strHours)"
//        minsLabel.text = "\(strMinutes)"
//        secondsLabel.text = "\(strSeconds)"
//
//    }
//
//
//
//    // MARK :- Dates Difference
//    func days()
//    {
//        let dateRangeStart = Date()
//        let dateRangeEnd = Date().addingTimeInterval(12345678)
//        let components = Calendar.current.dateComponents([.weekOfYear, .month], from: dateRangeStart, to: dateRangeEnd)
//
//        print(dateRangeStart)
//        print(dateRangeEnd)
//        print("difference is \(components.month ?? 0) months and \(components.weekOfYear ?? 0) weeks")
//
//
//        let months = components.month ?? 0
//        self.daysLabel.text = "\(months)"
//
//
  //  }
    
    func getDetails()
    {
        var name = "Amar"
        
        if let name1 = DEFAULT.value(forKey: "name") as? String
        {
            name = name1
        }
        self.nameLabel.text! =  name
        
        
        
        if let wedding_banner_image = allData.value(forKey: "wedding_banner_image") as? String
        {
            let img = URL(string: wedding_banner_image)
            
            self.bannerImage2.sd_setImage(with: img, placeholderImage: UIImage(named: "image-1"))
        }
        if let myself_image = allData.value(forKey: "myself_image") as? String
        {
            let img = URL(string: myself_image)
            
            self.image1.sd_setImage(with: img, placeholderImage: UIImage(named: "image-1"))
        }
        if let parnter_image = allData.value(forKey: "parnter_image") as? String
        {
            let img = URL(string: parnter_image)
            
            self.image2.sd_setImage(with: img, placeholderImage: UIImage(named: "image-1"))
        }
        if let wedding_date = allData.value(forKey: "wedding_date") as? String
        {
            self.weddingDateTXT.text = self.convertDateFormater(wedding_date)
        }
        if let wedding_date = allData.value(forKey: "wedding_date") as? String
        {
            self.dateLabel.text = wedding_date
        }
        if let myself = allData.value(forKey: "myself") as? String
        {
            self.brideTXT.text = myself
        }
        if let partner_name = allData.value(forKey: "partner_name") as? String
        {
            self.peartnerTextfiled.text = partner_name
        }
        if let wedding_date = allData.value(forKey: "wedding_date") as? String
        {
            self.weddingDateTXT.text = self.convertDateFormater(wedding_date)
            self.dateDiff(dateStr: wedding_date)
        }
        if let about_me = allData.value(forKey: "about_me") as? String
        {
            self.aboutMeTXT.text = about_me
        }
        if let parnter = allData.value(forKey: "parnter") as? String
        {
            self.groomTXT.text = parnter
        }
        
        
       // var name = "Amar"
        
        if let name1 = DEFAULT.value(forKey: "name") as? String
        {
            name = name1
        }
        self.nameLabel.text! =  name
        
        
        
        if let wedding_banner_image = allData.value(forKey: "wedding_banner_image") as? String
        {
            let img = URL(string: wedding_banner_image)
            
            self.bannerImage2.sd_setImage(with: img, placeholderImage: UIImage(named: "image-1"))
        }
        if let myself_image = allData.value(forKey: "myself_image") as? String
        {
            let img = URL(string: myself_image)
            
            self.image1.sd_setImage(with: img, placeholderImage: UIImage(named: "image-1"))
        }
        if let parnter_image = allData.value(forKey: "parnter_image") as? String
        {
            let img = URL(string: parnter_image)
            
            self.image2.sd_setImage(with: img, placeholderImage: UIImage(named: "image-1"))
        }
        if let wedding_date = allData.value(forKey: "wedding_date") as? String
        {
            self.weddingDateTXT.text = self.convertDateFormater(wedding_date)
        }
        if let wedding_date = allData.value(forKey: "wedding_date") as? String
        {
            self.dateLabel.text = self.convertDateFormater(wedding_date)
        }
        if let myself = allData.value(forKey: "myself") as? String
        {
            self.brideTXT.text = myself
        }
        if let partner_name = allData.value(forKey: "partner_name") as? String
        {
            self.peartnerTextfiled.text = partner_name
        }
        if let parnter = allData.value(forKey: "parnter") as? String
        {
            self.groomTXT.text = parnter
        }
        
        if let wedding_date = allData.value(forKey: "wedding_date") as? String
        {
            self.weddingDateTXT.text = self.convertDateFormater(wedding_date)
        }
        if let about_me = allData.value(forKey: "about_me") as? String
        {
            self.aboutMeTXT.text = about_me
        }
        if let my_name = allData.value(forKey: "my_name") as? String
        {
            self.mySelfNameTxt.text = my_name
        }
        
        
        if let color = DEFAULT.value(forKey: "CHOOSECOLOR") as? String
        {
            if color == "1"
            {
                self.timmerView.backgroundColor = COLOR1
            }
            else if color == "2"
            {
                self.timmerView.backgroundColor = COLOR2
            }
            else if color == "3"
            {
                self.timmerView.backgroundColor = COLOR3
            }
            else if color == "4"
            {
                self.timmerView.backgroundColor = COLOR4
            }
            else if color == "5"
            {
                self.timmerView.backgroundColor = COLOR5
            }
            else if color == "6"
            {
                self.timmerView.backgroundColor = COLOR6
            }
            else
            {
                self.timmerView.backgroundColor = COLOR7
            }
            
        }
    }
    
    

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        
      
        self.navigationController?.popViewController(animated: true)
        

    }
    
    
    @IBAction func saveAction(_ sender: UIButton) {
        
        profileValidation()
    }
    
    
    
    @IBAction func myselfAction(_ sender: UIButton) {
        
        
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
    
    
    @IBAction func myPartnerAction(_ sender: UIButton) {
        
        
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
    
    
    
    
    
    @IBAction func UploadAction(_ sender: UIButton) {
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
    
   
    // MARK: - Pickerview Here.
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int{
        return 2
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if pickerView == myPickerview
        {
            return  groomArray.count
            
        }
        return groomArray.count
        
    }
    

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        
        if pickerView == myPickerview
        {
            return groomArray[row]
        }
        return groomArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
        
    {
        if pickerView == myPickerview
        {
            groomTXT.text = groomArray[row]
            
        }
        else{
            brideTXT.text = groomArray[row]
        }
    }
    
   
    // MARK: - Validation
    
    func profileValidation()
    {
        if (groomTXT.text?.count == 0) && (brideTXT.text?.count == 0) && (peartnerTextfiled.text?.count == 0) && (weddingDateTXT.text?.count == 0)
        {
            Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Please enter all details.")
        }
        else if groomTXT.text?.count == 0
        {
            Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Enter Your Name")
            
        }
        else if brideTXT.text?.count == 0
        {
            Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Enter Your PartnerName")
            
        }
        else if peartnerTextfiled.text?.count == 0
        {
            Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Enter Your PartnerName")
            
        }
            
        else if weddingDateTXT.text?.count == 0
        {
            Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Enter Your WeddingDate")
            
        }
            
       
//        else if aboutMeTXT.text?.count == 0
//        {
//            Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Enter about you")
//        }
        else if mySelfNameTxt.text?.count == 0
        {
            Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Enter my self name")
        }
        else{
            
            if CheckInternet.Connection()
            {
                SVProgressHUD.show()
                SVProgressHUD.setBorderColor(UIColor.white)
                SVProgressHUD.setForegroundColor(UIColor.white)
                SVProgressHUD.setBackgroundColor(UIColor.black)
                uploadImage1()
            }
            else{
                Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Please Check The Internet Connection")
            }
        }
        
    }
    
    
    
    //MARK: - Datepicker
    
    func showDatePicker(){
        
        datePicker.datePickerMode = .date
        datePicker.minimumDate = Calendar.current.date(byAdding: .year, value: 0, to: Date())
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.bordered, target: self, action: #selector(WeddingViewController.donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.bordered, target: self, action: #selector(WeddingViewController
            .cancelDatePicker))
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        weddingDateTXT.inputAccessoryView = toolbar
        weddingDateTXT.inputView = datePicker
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        //formatter.dateFormat = "dd/MMM/yyyy"
        
        formatter.dateFormat = "MMMM-dd-yyyy"
        self.seletedDate = formatter.string(from: datePicker.date)
        weddingDateTXT.text! = self.convertDateFormater(self.seletedDate)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    
    
    // MARK : View profile
    
    
   
    func uploadImage1()
    {
        var userEmail = ""
        if let email = DEFAULT.value(forKey: "email") as? String
        {
            userEmail = email
        }
        
        
        let parameters:[String:Any] = [
            "email":userEmail,
            "date": self.convertDateFormater2(weddingDateTXT.text!),
            "about":aboutMeTXT.text!,
            "parnter":groomTXT.text!,
            "partner_name":peartnerTextfiled.text!,
            "myself":brideTXT.text!,
            "my_name":mySelfNameTxt.text!]
        
         print(parameters)
        
        guard let image1 = self.bannerImage2.image else{return}
        guard let image2 = self.image1.image else{return}
        guard let image3 = self.image2.image else{return}
        
        guard let imgData1 = image1.jpegData(compressionQuality: 0.1) else{return}
        guard let imgData2 = image2.jpegData(compressionQuality: 0.1) else{return}
        guard let imgData3 = image3.jpegData(compressionQuality: 0.1) else{return}
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imgData1, withName: "wedding_banner_image",fileName:"file.jpg", mimeType:"jpg/png/jpeg")
            multipartFormData.append(imgData2, withName: "myself_image",fileName: "file.jpg", mimeType:"jpg/png/jpeg")
            multipartFormData.append(imgData3, withName: "parnter_image",fileName:"file.jpg", mimeType:"jpg/png/jpeg")
            
            
            for (key, value) in parameters
            {
                multipartFormData.append((value as! String).data(using: .utf8)!, withName: key)
            }
        },
                         usingThreshold: UInt64.init(), to: weddingURL, method: .post) { (result) in
                            switch result {
                            case .success(let upload, _, _):
                                upload.uploadProgress(closure: { (progress) in
                                    print("proses", progress.fractionCompleted)
                                })
                                
                                upload.responseJSON { response in
                                    print("Succesfully uploaded")
                                    
                                    if let dic = response.result.value as? Dictionary<String, Any>{
                                        SVProgressHUD.dismiss()
                                        
                                        print("Dict here \(dic)")
                                        
                                        DispatchQueue.main.async
                                           {
//
//                                                SVProgressHUD.dismiss()
//
                                                let  imageData = dic["data"] as? [String:Any]
//
                                                if let userName = imageData?["myself"] as? String
                                                {
                                                    self.brideTXT.text! = userName
                                                }
//
                                                if let partnerName =  imageData?["partner_name"] as? String
                                                {
                                                    self.peartnerTextfiled.text! = partnerName
                                                }
                                                if let weddingDate =  imageData?["wedding_date"] as? String
                                                {
                                                    
                                                     defaultValues.set(weddingDate, forKey: "weddingDate")
                                                    self.weddingDateTXT.text! = self.convertDateFormater(weddingDate)

                                                }
                                                if let groomName1 =  imageData?["parnter"] as? String
                                                {
                                                     defaultValues.set(groomName1, forKey: "groomName1")
                                                    self.groomTXT.text! = groomName1
                                                }
                                            
                                            if let id =  imageData?["id"] as? String
                                            {
                                               defaultValues.set(id, forKey: "eventID")
                                            }
                                            if let event_type =  imageData?["event_type"] as? String
                                            {
                                                defaultValues.set(event_type, forKey: "eventType")
                                            }
                                            
                                            if let bannerImage =  imageData?["wedding_banner_image"] as? String
                                            {
                                                let img = URL(string: bannerImage)
                                                
                                                self.bannerImage2.sd_setImage(with: img, placeholderImage: UIImage(named: "image-1"))
                                            }
                                            if let myselfImage =  imageData?["myself_image"] as? String
                                            {
                                                let img = URL(string: myselfImage)
                                                
                                                self.image1.sd_setImage(with: img, placeholderImage: UIImage(named: "image-1"))
                                            }
                                            if let parnerImage =  imageData?["parnter_image"] as? String
                                            {
                                                let img = URL(string: parnerImage)
                                                
                                                self.image2.sd_setImage(with: img, placeholderImage: UIImage(named: "image-1"))
                                            }
//
                                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
                                            let navVC = UINavigationController.init(rootViewController: vc)
                                            navVC.setNavigationBarHidden(true, animated: true)
                                            if let window = UIApplication.shared.windows.first
                                            {
                                                window.rootViewController = navVC
                                                window.makeKeyAndVisible()
                                            }

                                            
//
//
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
        
        
        hrsLabel.text = String(hoursLeft!)
        minsLabel.text = String(minutesLeft!)
        secondsLabel.text = String(secondsLeft!)
        
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
    
    
    //    @objc func updateTime()
    //    {
    //        let currentTime = NSDate.timeIntervalSinceReferenceDate
    //        var elapsedTime : TimeInterval = currentTime - startTime
    //
    //        let hours = UInt32(elapsedTime / 3600.0)
    //        elapsedTime -= (TimeInterval(hours) * 3600)
    //
    //        let minutes = UInt8(elapsedTime / 60.0)
    //        elapsedTime -= (TimeInterval(minutes) * 60)
    //
    //        let seconds = UInt8(elapsedTime)
    //        elapsedTime -= TimeInterval(seconds)
    //
    //        //let strHours = String(format: "%02", hours)
    //        let strMinutes = String(format: "%02d", minutes)
    //        let strSeconds = String(format: "%02d", seconds)
    //
    //        //hoursLabel.text = "\(strHours)"
    //        minsLabel.text = "\(strMinutes)"
    //        secsLabel.text = "\(strSeconds)"
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //    }
    
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
        dateFormatter.dateFormat = "MMMM-dd-yyyy"
        return  dateFormatter.string(from: date!)
        
    }
    
}




//MARK: - UIImagePickerControllerDelegate

extension WeddingViewController:  UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.originalImage] as? UIImage else {
            return
        }
        bannerImage2.contentMode = .scaleAspectFill
        image1.contentMode = .scaleAspectFill
        image2.contentMode = .scaleAspectFill
        if let editing = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        {
        if selectedTag == 1
        {
            bannerImage2.image = editing
        }
        else if selectedTag == 2
        {
            image1.image = editing
        }
        else
        {
            image2.image = editing
        }
        }
        else
        {
            if selectedTag == 1
            {
                bannerImage2.image = selectedImage
            }
            else if selectedTag == 2
            {
                image1.image = selectedImage
            }
            else
            {
                image2.image = selectedImage
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
