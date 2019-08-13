//
//  ChangePassword_VC.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 31/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class ChangePassword_VC: UIViewController {

    @IBOutlet weak var otpTXT: UITextField!

    @IBOutlet weak var passwordTxt: UITextField!
    
    var forgotEmail:String = ""
    var forgotPassword:String = ""
    var forgotOTP:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

      //  self.otpTXT.text! = forgotOTP
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func backAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func passwordAction(_ sender: UIButton) {
        
        forgotOTPValidation()
    }
    
    
    
    func forgotOTPValidation()
    {
        if (otpTXT.text?.count == 0) && (passwordTxt.text?.count == 0)
        {
            Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Enter Your resetPassword Detaills")
        }
            
        else if (otpTXT.text?.count == 0)
        {
            Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Enter your verification code ")
        }
        else if (passwordTxt.text?.count == 0)
        {
            Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Enter your reset password ")
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
    
    
    
    
    func backTwo() {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
    }
    
    
    
    func resetAPI()
    {
        let params = ["email":forgotEmail,
                      "password":passwordTxt.text!,
                      "OTP":forgotOTP]
        
        WebService.shared.apiDataPostMethod(url:changePasswordURL, parameters: params) { (response, error) in
            if error == nil
            {
                let modeldata = Mapper<OTPModel>().map(JSONObject: response)
                if modeldata?.status == "success"
                {
                    let alert = UIAlertController.init(title:"Notification", message:modeldata?.message ?? "", preferredStyle: UIAlertController.Style.alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_ action: UIAlertAction )  -> Void in
                        
                        self.backTwo()

                    }))
                    
                    self.present(alert, animated: true)
                }
                else if modeldata?.status == "fail"
                {
                Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr:modeldata?.message ?? "")
            }
                
            }
            
            else{
                Helper.helper.showAlertMessage(vc:self, titleStr: "Notification", messageStr: error?.localizedDescription ?? "")
            }
            
            
        }
        
    }
}
