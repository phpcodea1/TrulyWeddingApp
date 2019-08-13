//
//  RegisterViewController.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 13/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit
import TextFieldEffects
import ObjectMapper
import Alamofire

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var emailTextfiled: HoshiTextField!
    @IBOutlet weak var passwordTXT: HoshiTextField!
    @IBOutlet weak var userNameTXT: HoshiTextField!
    @IBOutlet weak var confirmTextfiled: HoshiTextField!
    var iconClick = true

    var modelData:RegisterModel!
    var failureData:FailureModel!
    
    var route:String = ""
    
    @IBOutlet weak var passwordB: UIButton!
    
    @IBOutlet weak var confirmB: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        signupButton.layer.shadowColor = UIColor.lightGray.cgColor
        signupButton.layer.shadowOpacity = 0.7
        signupButton.layer.shadowOffset = CGSize.zero
        signupButton.layer.shadowRadius = 5
        signupButton.layer.shadowPath = UIBezierPath(rect: signupButton.bounds).cgPath
    }
    
    
    @IBAction func passwordAction(_ sender: UIButton) {
        if (iconClick == true)
        {
            passwordB.setImage(UIImage(named: "icons8-eye-40"), for: UIControl.State.normal)
            passwordTXT.isSecureTextEntry = false
            
        }
        else{
            passwordB.setImage(UIImage(named: "icons8-invisible-40 (1)"), for: UIControl.State.normal)
            passwordTXT.isSecureTextEntry = true
        }
        iconClick = !iconClick
    }
    
    
    @IBAction func confirmAction(_ sender: UIButton) {
        if (iconClick == true)
        {
            confirmB.setImage(UIImage(named: "icons8-eye-40"), for: UIControl.State.normal)
            confirmTextfiled.isSecureTextEntry = false
            
        }
        else{
            confirmB.setImage(UIImage(named: "icons8-invisible-40 (1)"), for: UIControl.State.normal)
            confirmTextfiled.isSecureTextEntry = true
        }
        iconClick = !iconClick
    }
    
    
    @IBAction func LoginAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(vc, animated: false)
        //self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func SignUpAction(_ sender: UIButton) {
        
        
        validationSingup()
        
        
    }
    
    
    //  MARK :- Email validation
    
    func isValidEmail(testStr:String) -> Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    // MARK: - Password Validation
    
    func isPasswordValid(password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{6,}")
        return passwordTest.evaluate(with: password)
    }
    
    func validationSingup()
    {
        if (emailTextfiled.text?.count == 0) && (userNameTXT.text?.count == 0) && (passwordTXT.text?.count == 0) && (confirmTextfiled.text?.count == 0)
            
        {
            Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Please enter all details.")
        }
        else if emailTextfiled.text?.count == 0
        {
            Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Enter Your Email")
        }
            
            
        else if userNameTXT.text?.count == 0
        {
            Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Enter Your Name")
        }
            
        else if passwordTXT.text?.count == 0
        {
            Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Enter Your Password")
        }
        else if confirmTextfiled.text?.count == 0
        {
            Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Confirm Your Password")
        }
            
            
        else if passwordTXT.text?.count ?? 0 < 6
        {
            Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Please Enter Minimum 6 Digits Password")
        }
            
        else if confirmTextfiled.text?.count ?? 0 < 6
        {
            Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Please Enter Minimum 6 Digits Password")
        }
        else if passwordTXT.text! != confirmTextfiled.text!
        {
            Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Confirm Password has not been matched with your password please check once")
        }
        else
        {
            
            let check = isValidEmail(testStr: emailTextfiled.text!)
            if check
            {
                if CheckInternet.Connection()
                {
                    self.SignupAPI()
                }
                    
                else{
                    Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Please Check The Internet Connection")
                }
            }
                
            else
            {
                Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Enter Your Vaild Email")
            }
            
        }
        
        
    }
    
    
    
    // MARK :- SignUp API here.
    
    func SignupAPI()
    {
        let params:[String:Any] = ["email":emailTextfiled.text!,
                                   "username":userNameTXT.text!,
                                   "password":passwordTXT.text!,
                                   "deviceToken":"abc",
                                   "deviceType":"1"]
        
        print(params)
        
        //MARK : - MODEL USING OBJECT MAPPER
        
        
        WebService.shared.apiDataPostMethod(url:registerURL, parameters: params) { (response, error) in
            
            if error == nil
            {
                self.modelData = Mapper<RegisterModel>().map(JSONObject: response)
                if self.modelData?.status == "success"
                {
                    
                    
                    let alertController = UIAlertController(title: "Notification", message: "You have registered successfully ", preferredStyle: .alert)
                    
                    let OKAction = UIAlertAction(title: "OK", style: .default)  {(action:UIAlertAction!) in
                        
                        
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                        self.navigationController?.pushViewController(vc, animated: false)
                        
                    }
                   
                    alertController.addAction(OKAction)
                    self.present(alertController, animated: true, completion:nil)
                
                }
                else
                {
                    self.failureData = Mapper<FailureModel>().map(JSONObject: response)
                    if self.failureData.status == "fail"
                    {
                        if let errorDict =  self.failureData.errors
                     {
                        
                        if let emailError = errorDict.email
                        {
                            Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: emailError)
                            return
                        }
                        
                        if let usernameError = errorDict.username
                        {
                            Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: usernameError)
                            return
                        }
                        
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
