//
//  ChangePhoto_VC.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 14/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import SVProgressHUD

class ChangePhoto_VC: UIViewController {

    @IBOutlet weak var changePhoto: UIImageView!
    var viewProfileModel:ViewProfileModel!
    var profileData:ViewData?
    var imagePicker = UIImagePickerController()
    var pickedImageProduct = UIImage()
    let myPickerview = UIPickerView()
    let datePicker = UIDatePicker()
    var selectedTag = 0
    var isChoosenImage = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.changePhoto.layer.borderWidth = 1.0
        self.changePhoto.layer.masksToBounds = false
        self.changePhoto.clipsToBounds = true
        self.changePhoto.layer.cornerRadius = self.changePhoto.frame.size.height/2
        // + self.profileImg2.frame.height/2
        self.changePhoto.layer.borderColor = UIColor.clear.cgColor

        
        if !(NetworkEngine.networkEngineObj.isInternetAvailable())
        {
            NetworkEngine.networkEngineObj.showInterNetAlert()
        }
        else
        {
            viewprofileAPI()
        }
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func backAction(_ sender: UIButton)
    {
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
                        
                        if let parnter = dict.value(forKey: "profileImage") as? String
                        {
                            let img = URL(string: parnter)
                            
    
                            self.changePhoto.sd_setImage(with: img, placeholderImage: UIImage(named: "image-1"))
                            
                            
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
    
    
    
    func uploadImage1()
    {
        var userEmail = ""
        if let email = DEFAULT.value(forKey: "email") as? String
        {
            userEmail = email
        }
        
        
        let parameters:[String:Any] = [
            "email":userEmail]
        
        print(parameters)
        
        guard let image1 = self.changePhoto.image else{return}
    
        
        guard let imgData1 = image1.jpegData(compressionQuality: 0.1) else{return}
      
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imgData1, withName: "profileImage",fileName:"file.jpg", mimeType:"jpg/png/jpeg")
           
            for (key, value) in parameters
            {
                multipartFormData.append((value as! String).data(using: .utf8)!, withName: key)
            }
        },
                         usingThreshold: UInt64.init(), to: UPLOADPHOTO, method: .post) { (result) in
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
                                            
           if let  imageData = dic["data"] as? String
            {
                let url = URL(string: imageData)
                self.changePhoto.sd_setImage(with: url, completed: nil)
            }
                                              
         }
                                        
  }
                                }
                                
                            case .failure(let encodingError):
                                print(encodingError)
                            }
        }
        
        
    }
    
    
    
    
    

}

//MARK: - UIImagePickerControllerDelegate

extension ChangePhoto_VC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.originalImage] as? UIImage else {
            return
        }
        changePhoto.contentMode = .scaleAspectFill
        
        if let editing = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        {
        if selectedTag == 1
        {
            changePhoto.image = editing
        }
        }
        else
        {
           changePhoto.image = selectedImage
        }
        
        
        isChoosenImage = true
        if selectedImage != nil
        {
            self.uploadImage1()
        }
        dismiss(animated: true, completion: nil)
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.isNavigationBarHidden = false
        self.dismiss(animated: true, completion: nil)
    }
}
