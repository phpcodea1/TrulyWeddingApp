//
//  OneTimePassword_VC.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 27/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire

class OneTimePassword_VC: UIViewController {

    
    @IBOutlet weak var OTPtextfiled: UITextField!
    @IBOutlet weak var resetTextfiled: UITextField!
    
    var forgotEmail:String = ""
    var forgotPassword:String = ""
    var forgotOTP:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // self.OTPtextfiled.text! = forgotOTP
        
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)

    }
    
    @IBAction func resetPassword(_ sender: UIButton) {
        
       forgotOTPValidation()
    }
    
    
    
    func forgotOTPValidation()
    {
        if (OTPtextfiled.text?.count == 0) && (resetTextfiled.text?.count == 0)
        {
            Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Enter Your reset Password Detaills")
        }
            
       else if (OTPtextfiled.text?.count == 0)
        {
        Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Enter your verification code ")
        }
        else if (resetTextfiled.text?.count == 0)
        {
            Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Enter Your reset password")
        }
        else
        {
            if !(NetworkEngine.networkEngineObj.isInternetAvailable())
            {
                NetworkEngine.networkEngineObj.showInterNetAlert()
            }
            else
            {
                resetAPI()
            }
            
        }
    }
    
    
    // MARK -: resetAPI
    
    func resetAPI()
    {
        let params = ["email":forgotEmail,
                      "password":resetTextfiled.text!,
                      "OTP":forgotOTP]
        
        WebService.shared.apiDataPostMethod(url: resetPasswordURL, parameters: params) { (response, error) in
            if error == nil
            {
                let modeldata = Mapper<OTPModel>().map(JSONObject: response)
                if modeldata?.status == "success"
                {
                    let alert = UIAlertController.init(title:"Notification", message:modeldata?.message ?? "", preferredStyle: UIAlertController.Style.alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_ action: UIAlertAction )  -> Void in
                        
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController")as! LoginViewController
                        
                       
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    }))
                    
                    self.present(alert, animated: true)
                    
                }
                else if modeldata?.status == "fail"
                {
                    Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr:"fail")
                }
                else{
                    
                }
            }
        }
        
    }
    
    
    
    
    
    
    
}
