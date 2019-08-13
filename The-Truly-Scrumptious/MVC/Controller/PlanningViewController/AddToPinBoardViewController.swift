                                                                                                                                                                                   //
//  AddToPinBoardViewController.swift
//  The-Truly-Scrumptious
//
//  Created by administrator on 23/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

class AddToPinBoardViewController: UIViewController,UIPopoverPresentationControllerDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    let picker = UIImagePickerController()
    
    @IBOutlet weak var img1: UIImageView!
    
    @IBOutlet weak var img2: UIImageView!
    
    
    @IBOutlet weak var img3: UIImageView!
    
    @IBOutlet weak var img4: UIImageView!
    
    @IBOutlet weak var img5: UIImageView!
    @IBOutlet weak var img6: UIImageView!
    
    
    var selected = 0
    var editclick = 0
    
    @IBOutlet var saveBtn: UIButton!
    @IBOutlet var descText: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        
        saveBtn.layer.borderWidth = 1
        saveBtn.layer.borderColor = BORDERCOLOR.cgColor
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
        
      descText.layer.borderWidth = 1
        
        descText.layer.borderColor = UIColor.black.cgColor
    }
    @objc func methodOfReceivedNotification(notification: Notification)
    {
        print((notification.userInfo as! NSDictionary).value(forKey: "identifier") as! Int)
       self.selected = (notification.userInfo as! NSDictionary).value(forKey: "identifier") as! Int
        
        if (self.navigationController != nil)
        {

            self.dismiss(animated: false, completion: nil)
        }
        if self.selected == 1
        {
            openCamera()
        }
        else if selected == 2
        {
            openGallary()
        }
        else
        {
            print("Remove click")
        }
        
       print("self.editclick = \(self.editclick)")
      
    }
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            picker.sourceType = UIImagePickerController.SourceType.camera
            self .present(picker, animated: true, completion: nil)
        }
        else
        {
            let alertWarning = UIAlertView(title:"Warning", message: "You don't have camera", delegate:nil, cancelButtonTitle:"OK")
            alertWarning.show()
        }
    }
    func openGallary()
    {
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
   
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        print("picker cancel.")
        self.dismiss(animated: false, completion: nil)
    }

  
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        print(info)
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            if self.editclick == 1
            {
                self.img1.image = pickedImage
            }
            else if self.editclick == 2
            {
                self.img2.image = pickedImage
            }
            else if self.editclick == 3
            {
                self.img3.image = pickedImage
            }
            else if self.editclick == 4
            {
                self.img4.image = pickedImage
            }
            else if self.editclick == 5
            {
                self.img5.image = pickedImage
            }
            else
            {
                self.img6.image = pickedImage
            }
           
            
        }
        picker.dismiss(animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func goBacvk(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func editImage1(_ sender: UIButton)
    {
        self.editclick = sender.tag
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CameraPopupViewController")
        
        vc.modalPresentationStyle = .popover
        let popover = vc.popoverPresentationController!
        popover.delegate = self
        popover.permittedArrowDirections = .init(rawValue: 0)
        popover.sourceView = sender as? UIView
       
      //  popover.sourceRect = sender.bounds
        if sender.tag == 1
        {
            popover.sourceRect = CGRect(x: sender.frame.origin.x, y: -100, width: self.img1.frame.width, height: self.img1.frame.height)
            
        }
        else if sender.tag == 2
        {
             popover.sourceRect = CGRect(x: sender.frame.origin.x, y: -100, width: self.img2.frame.width, height: self.img2.frame.height)
        }
        else if sender.tag == 3
        {
            popover.sourceRect = CGRect(x: sender.frame.origin.x, y: -100, width: self.img3.frame.width, height: self.img3.frame.height)
        }
        else if sender.tag == 4
        {
            popover.sourceRect = CGRect(x: sender.frame.origin.x, y: -100, width: self.img4.frame.width, height: self.img4.frame.height)
        }
        else if sender.tag == 5
        {
            popover.sourceRect = CGRect(x: sender.frame.origin.x, y: -100, width: self.img5.frame.width, height: self.img5.frame.height)
        }
        else
        {
             popover.sourceRect = CGRect(x: sender.frame.origin.x, y: -100, width: self.img6.frame.width, height: self.img6.frame.height)
        }
        
       
        
        present(vc, animated: true, completion:nil)
        
    }
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }

}
