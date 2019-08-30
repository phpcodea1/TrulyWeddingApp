//
//  NewAddPinBoaardViewController.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 20/08/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit
import AVKit
import Foundation
import CoreVideo
import MobileCoreServices
import Alamofire
import SVProgressHUD

class NewAddPinBoaardViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIGestureRecognizerDelegate
{
    var selectedImage = Int()
    
    var videoURL : NSURL?
    var imageArray = NSMutableArray()
var imageArray2 = NSMutableArray()
    var pinId = ""
    @IBOutlet weak var changePhoto: UIImageView!
    var viewProfileModel:ViewProfileModel!
    var profileData:ViewData?
    var imagePicker = UIImagePickerController()
    var pickedImageProduct = UIImage()
    let myPickerview = UIPickerView()
  
    var selectedTag = 0
    var isChoosenImage = false
    
    var mediaDict = NSMutableDictionary()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if imageArray.count>0
        
        {
            self.imageArray.removeAllObjects()
        }
        selectedImage = -1
        collectionView.register(UINib(nibName: "AddPinCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddPinCollectionViewCell")
        // Do any additional setup after loading the view.
        
    }
    @IBAction func BackAct(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if imageArray.count>0
        {
          return imageArray2.count + 1
        }
        else
        {
            return 1
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddPinCollectionViewCell", for: indexPath) as! AddPinCollectionViewCell
      
        cell.img.layer.cornerRadius = 10
        cell.img.clipsToBounds = true
       
        cell.editBtn.clipsToBounds = true
        cell.editBtn.layer.cornerRadius = 10
        cell.editBtn.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
//        if selectedImage==indexPath.row
//        {
//            cell.img.image=pickedImageProduct
//
//        }
//        else
//        {
            if indexPath.row<self.imageArray2.count
            {
//                var dict = self.imageArray.object(at: indexPath.row) as! NSDictionary
//
//
//                if let mediaType = dict.value(forKey: "mediaType") as? String
//                {
//
//                    if mediaType == "i"
//                    {
//                        cell.platBtn.isHidden = true
//                    }
//                    else
//                    {
//                        cell.platBtn.isHidden = false
//                    }
//                }
                
                if let img = self.imageArray2.object(at: indexPath.row) as? UIImage
                {
                    
                   cell.img.image = img
                    cell.platBtn.isHidden = true
                }
                else
                {
                    
                    if let  imageData = self.imageArray2.object(at: indexPath.row) as? String
                    {
                        if imageData != ""
                        {
                            var baseUrl =  imageData //IMAGEBASEURL + imageData
                            let url = URL(string: baseUrl)!
                            
                            
                            if let thumbnailImage = getThumbnailImage(forUrl: url)
                            {
                                cell.img.image = thumbnailImage
                            }
                            
                        }
                        
                    }
                   
                    
                    cell.platBtn.isHidden = false
                }
               cell.editBtn.isHidden = true
                 cell.deleteBtn.isHidden = false
            }
            else
            {
                 cell.img.image = UIImage(named: "addMedia7")
                cell.editBtn.isHidden = false
                cell.deleteBtn.isHidden = true
            }
          
        //}
        
     
        
        cell.platBtn.tag = indexPath.row
        cell.platBtn.addTarget(self, action: #selector(PlayVideo), for: .touchUpInside)
        
          cell.editBtn.tag = indexPath.row
        cell.editBtn.addTarget(self, action: #selector(uploadMedia), for: .touchUpInside)
        cell.deleteBtn.tag = indexPath.row
        cell.deleteBtn.addTarget(self, action: #selector(deleteMedia), for: .touchUpInside)
        return cell
    }
    @objc func PlayVideo(_ sender:UIButton)
    {
        var dict = self.imageArray.object(at: sender.tag) as! NSDictionary
        
        if let  imageData = imageArray2.object(at: sender.tag) as? String
        {
            if imageData != ""
            {
                var baseUrl = imageData //IMAGEBASEURL + imageData
                let url = URL(string: baseUrl)!
                
                
                // let url = URL(string: data)!
                
                let player = AVPlayer(url: url)
                
                let vc = AVPlayerViewController()
                vc.player = player
                
                self.present(vc, animated: true)
                {
                    vc.player?.play()
                    
                }
                
            }
            
        }
        
    }
  
    
    @objc func uploadMedia(_ sender:UIButton)
    {
        self.selectedImage = sender.tag
        
        let alert = UIAlertController(title: nil, message: "Choose media", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction(title: "Video", style: .default, handler: { _ in
            self.videoLibrary()
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
    @objc func deleteMedia(_ sender:UIButton)
    {
        let optionMenu = UIAlertController(title: "Alert!", message: "Are you sure you want to delete?", preferredStyle: .alert)
        
        
        
        let deleteAction = UIAlertAction(title: "Yes", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            
            if !(NetworkEngine.networkEngineObj.isInternetAvailable())
            {
                NetworkEngine.networkEngineObj.showInterNetAlert()
            }
            else
            {
                if self.imageArray2.count>0
                {
                    self.imageArray2.removeObject(at: sender.tag)
                    self.collectionView.reloadData()
                }
            }
            
            
            
        })
        let deleteAction2 = UIAlertAction(title: "Cancel", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            
            
        })
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(deleteAction2)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    func DeleteNoticeMediaAPI()
    {
        var userEmail = ""
        if let email = DEFAULT.value(forKey: "email") as? String
        {
            userEmail = email
        }
        
        
        let params:[String:Any] =
            [
                "email":userEmail,
                "eventImageVideos_ID":self.pinId]
        
        
        print(params)
        WebService.shared.apiDataPostMethod(url:DELETECOMMENTNOTICEBOARD, parameters: params) { (response, error) in
            if error == nil
            {
                
                
            }
            else
            {
                Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr:"Error")
                
            }
            
        }
    }
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            //If you dont want to edit the photo then you can set allowsEditing to false
             imagePicker.mediaTypes = ["public.image", "public.movie"]
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
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
        imagePicker.mediaTypes = ["public.image"]
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    func videoLibrary()
    {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        {
           
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
           // imagePicker.mediaTypes = [kUTTypeMovie as String, kUTTypeVideo as String]
            imagePicker.mediaTypes = ["public.movie"]
          self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func uploadAction(_ sender: UIButton)
    {
        print(self.imageArray)
        if !(NetworkEngine.networkEngineObj.isInternetAvailable())
        {
            NetworkEngine.networkEngineObj.showInterNetAlert()
        }
        else
        {
           self.AddNoticeMediaAPI()
        }
        
        
    }
    
    
   
    
    func AddNoticeMediaAPI2()
    {
        var userEmail = ""
        if let email = DEFAULT.value(forKey: "email") as? String
        {
            userEmail = email
        }
        
        
        let parameters:[String:Any] =
            [
                "email":userEmail]
        
        print(parameters)
        
       
        
        
        
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            
//            for image  in self.imageArray2
//            {
//                guard let imgData1 = (image as! UIImage).jpegData(compressionQuality: 0.1) else{return}
//               multipartFormData.append(imgData1, withName: "imageVideo[]",fileName:"file.jpg", mimeType:"jpg/png/jpeg")
//            }
            
                            guard let imgData1 = self.pickedImageProduct.jpegData(compressionQuality: 0.1) else{return}
                         //  multipartFormData.append(imgData1, withName: "imageVideo[]",fileName:"file.jpg", mimeType:"jpg/png/jpeg")
            
            multipartFormData.append(imgData1, withName: "file.jpg", fileName: "file.jpg", mimeType: "jpg/png/jpeg")
            
           // multipartFormData.append(UIImageJPEGRepresentation(self.pickedImageProduct, 0.6)!, withName: "imageVideo[]", fileName: "file.jpg", mimeType:"jpg/png/jpeg")
            
            for (key, value) in parameters
            {
                multipartFormData.append((value as! String).data(using: .utf8)!, withName: key)
            }
            print(parameters)
        },
                         usingThreshold: UInt64.init(), to: ADDPINBOARD, method: .post) { (result) in
                            switch result {
                            case .success(let upload, _, _):
                                upload.uploadProgress(closure: { (progress) in
                                    print("proses", progress.fractionCompleted)
                                    print(result)
                                })
                                
                                upload.responseJSON { response in
                                    print("Succesfully uploaded")
                                    print(response)
                                    if let dic = response.result.value as? Dictionary<String, Any>{
                                        SVProgressHUD.dismiss()
                                        
                                        print("Dict here \(dic)")
                                        
                                       
                                        
                                    }
                                }
                                
                            case .failure(let encodingError):
                                print(encodingError)
                            }
        }
        
        
    }
    
    func AddNoticeMediaAPI()
    {
  
        var userEmail = ""
        if let email = DEFAULT.value(forKey: "email") as? String
        {
            userEmail = email
        }
        
        
        let params:[String:String] =
            [
                "email":userEmail]
        
        print(params)
        
    
    Alamofire.upload(multipartFormData: { (multipartFormData) in
    
        
                    for image  in self.imageArray2
                    {
                        if let imag = image as? UIImage
                        {
                            guard let imgData1 = (image as! UIImage).jpegData(compressionQuality: 0.1) else{return}
                            multipartFormData.append(imgData1, withName: "imageVideo[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                        }
                        else
                       
                        {
                            var str = image as! String
                            
                            var url = URL(string: str)!
                            
                                     multipartFormData.append(url, withName: "imageVideo[]", fileName: "\(Date().timeIntervalSince1970*10).mp4", mimeType: "video/mp4")
                        }
                    }

    for (key, value) in params
    {
    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
    }
    }, to:ADDPINBOARD)
    { (result) in
    switch result {
    case .success(let upload, _, _):
    
    upload.uploadProgress(closure: { (progress) in
    //Print progress
        print(progress)
        if progress.isFinished
        {
            SVProgressHUD.dismiss()
        }
        else
        {
            SVProgressHUD.show()
        }
    })
    
    upload.responseJSON { response in
    
        print(response)
    if let JSON = response.result.value! as? NSDictionary
    
    {
    print(JSON)
        DEFAULT.set("yes", forKey: "FromUpload")
        DEFAULT.synchronize()
    self.navigationController?.popViewController(animated: true)
    
   
   
    SVProgressHUD.dismiss()
    }
    }
    
    break
    
    case .failure(let encodingError):
    break
    print(encodingError)
    
    }
    }
    
    
    
    //        updateProfile(fileName:NSUUID().uuidString, param: param as! [String : String] , imageVal:choosenImage, completion: { (JsonResult) in
    //
    //
    //            print(JsonResult)
    //            if JsonResult.value(forKey:"status") as! String == "success"
    //            {
    //                DEFAULT.set(JsonResult.value(forKey: "ID") as!String, forKey: "ID")
    //                DEFAULT.set(JsonResult.value(forKey: "first_name") as!String, forKey: "first_name2")
    //                DEFAULT.set(JsonResult.value(forKey: "last_name") as!String, forKey: "last_name2")
    //                  UserDefaults.standard.synchronize()
    //                self.userName.isEnabled = false
    //                self.FirstName.isEnabled = false
    //                self.emailId.isEnabled = false
    //                self.saveOutlet.isHidden = true
    //                self.btnCamera.isHidden = true
    //                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
    //
    //                self.present(vc, animated: true, completion: nil)
    //
    //
    //                 if  let dict:NSDictionary = UserDefaults.standard.value(forKey: "userData") as? NSDictionary
    //                 {
    ////                     DEFAULT.removeObject(forKey: "ID")
    ////                     DEFAULT.removeObject(forKey: "first_name")
    ////                     DEFAULT.removeObject(forKey: "last_name")
    //
    //
    //
    //
    //                }
    //                SVProgressHUD.dismiss()
    //            }
    //            print("after update \( UserDefaults.standard.value(forKey: "userData"))")
    //           }
    //
    //
    //
    //
    //    )
    }
    
    func getThumbnailImage(forUrl url: URL) -> UIImage?
    {
        let asset: AVAsset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        
        do {
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60) , actualTime: nil)
            return UIImage(cgImage: thumbnailImage)
        } catch let error {
            print(error)
        }
        
        return nil
    }
    
}


//MARK: - UIImagePickerControllerDelegate

extension NewAddPinBoaardViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
//        guard let selectedImage = info[.originalImage] as? UIImage else
//        {
//            return
//        }
       // changePhoto.contentMode = .scaleAspectFill
        
        if let editing = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        {
            
            self.mediaDict.setValue("\(editing)", forKey: "ShowImage")
            self.mediaDict.setValue("i", forKey: "mediaType")
            self.mediaDict.setValue("Camera", forKey: "imageURL")
            
           
            let docDir = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let imageUniqueName : Int64 = Int64(NSDate().timeIntervalSince1970 * 1000);
            let filePath = docDir.appendingPathComponent("\(imageUniqueName).png");
            
            do{
                if let pngImageData = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage)!.pngData()
                {
                    try pngImageData.write(to : filePath , options : .atomic)
                    print(filePath)
                   // currentExerciceDto.imageCustom = "\(imageUniqueName).png"
                }
            }catch{
                print("couldn't write image")
            }
           print("photoURL = \(filePath)")
            self.imageArray.add(mediaDict)
            self.imageArray2.add(editing)
             //self.imageArray2.add(mediaDict)
            self.pickedImageProduct=editing
        }
        else
        {
            if let selectedImage = info[.originalImage] as? UIImage
                    {
                       self.pickedImageProduct=selectedImage
                        
                        self.mediaDict.setValue("\(selectedImage)", forKey: "ShowImage")
                        self.mediaDict.setValue("i", forKey: "mediaType")
                        self.mediaDict.setValue("\(info[UIImagePickerController.InfoKey.imageURL]!)", forKey: "imageURL")
                        self.pinId = "\(info[UIImagePickerController.InfoKey.imageURL]!)"
                        self.imageArray2.add(selectedImage)
                        self.imageArray.add(mediaDict)
                    }
                  else
            {
                videoURL = info[UIImagePickerController.InfoKey.mediaURL]as? NSURL
                print(videoURL!)
                do {
                    let asset = AVURLAsset(url: videoURL as! URL , options: nil)
                    let imgGenerator = AVAssetImageGenerator(asset: asset)
                    imgGenerator.appliesPreferredTrackTransform = true
                    let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
                    let thumbnail = UIImage(cgImage: cgImage)
                    
                    self.pickedImageProduct=thumbnail
                    
                    self.mediaDict.setValue("\(thumbnail)", forKey: "ShowImage")
                    self.mediaDict.setValue("v", forKey: "mediaType")
                    self.mediaDict.setValue("\(info[UIImagePickerController.InfoKey.mediaURL]!)", forKey: "imageURL")
                    self.pinId = "\(info[UIImagePickerController.InfoKey.mediaURL]!)"
                    self.imageArray.add(self.mediaDict)
  
                    self.imageArray2.add("\(info[UIImagePickerController.InfoKey.mediaURL]!)")
                }
                catch let error
                {
                    print("*** Error generating thumbnail: \(error.localizedDescription)")
                }
            }
            
            
        }
        
        
        isChoosenImage = true
        if selectedImage != nil
        {
           
           self.collectionView.reloadData()
        }
        
        
        
        dismiss(animated: true, completion: nil)
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.isNavigationBarHidden = false
        self.dismiss(animated: true, completion: nil)
    }
}
extension NewAddPinBoaardViewController:UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        let cellWidth : CGFloat = (UIScreen.main.bounds.width-13) / 2.0
        let cellheight = UIScreen.main.bounds.height  / 3.0
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 2.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 2.0
    }
}


