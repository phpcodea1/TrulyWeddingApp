//
//  ForgotViewController.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 27/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class ForgotViewController: UIViewController {

    
    @IBOutlet weak var emailTextfiled: UITextField!
    
    var loginPassword:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    

    @IBAction func sendOTP(_ sender: UIButton) {
        forgotValidation()
    }
    
    //  MARK :- Email validation
    
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
    
    
    func fogotAPI()
    {
        let params = ["email":emailTextfiled.text!]
       
        WebService.shared.apiDataPostMethod(url: forgotURL, parameters: params) { (response, error) in
            if error == nil
            {
                let modeldata = Mapper<ForgotModel>().map(JSONObject: response)
                if modeldata?.status == "success"
                {
                    let alert = UIAlertController.init(title:"Notification", message:modeldata?.message ?? "", preferredStyle: UIAlertController.Style.alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_ action: UIAlertAction )  -> Void in
                        
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "OneTimePassword_VC")as! OneTimePassword_VC
                        
                         let otp = modeldata?.data
                        vc.forgotEmail = self.emailTextfiled.text!
                         vc.forgotOTP = "\(otp!)"
                        vc.forgotPassword = self.loginPassword

                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    }))
                    
                    self.present(alert, animated: true)
                    
                }else if modeldata?.status == "fail"
                {
                    Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr:"Enter vaild email")
                }else{
                    
                }
            }
        }
        
    }
    
    
    
    
}
