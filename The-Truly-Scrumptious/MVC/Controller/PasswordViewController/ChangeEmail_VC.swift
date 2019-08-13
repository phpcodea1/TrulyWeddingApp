//
//  ChangeEmail_VC.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 31/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import SVProgressHUD

class ChangeEmail_VC: UIViewController {

    @IBOutlet weak var emailTextfiled: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
   
    @IBAction func OTPaction(_ sender: UIButton) {
        forgotValidation()
 
    }
    
    
    func isValidEmail(testStr:String) -> Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func forgotValidation()
    {
        if (emailTextfiled.text?.count == 0)
        {
            Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Enter Your email")
        }
        else
        {
            let check = isValidEmail(testStr: emailTextfiled.text!)
            if check
            {
                if CheckInternet.Connection()
                {
                    self.fogotAPI()
                }
                else{
                    Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Please Check The Internet Connection")
                }
            }
            else{
                Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Enter Your Vaild Email")
            }
            
        }
    }
    
    
     // MARK -: fogotAPI
    
    func fogotAPI()
    {
        let params = ["email":emailTextfiled.text!]
        
        WebService.shared.apiDataPostMethod(url: OTPURL, parameters: params) { (response, error) in
            if error == nil
            {
                let modeldata = Mapper<ForgotModel>().map(JSONObject: response)
                if modeldata?.status == "success"
                {
                    let alert = UIAlertController.init(title:"Notification", message:modeldata?.message ?? "", preferredStyle: UIAlertController.Style.alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_ action: UIAlertAction )  -> Void in
                        
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChangePassword_VC")as! ChangePassword_VC
                        
                        let otp = modeldata?.data
                        vc.forgotEmail = self.emailTextfiled.text!
                        vc.forgotOTP = "\(otp!)"
                        
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    }))
                    
                    self.present(alert, animated: true)
                    
                }else if modeldata?.status == "fail"
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
