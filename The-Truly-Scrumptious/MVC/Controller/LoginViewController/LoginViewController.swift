//
//  LoginViewController.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 13/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit
import TextFieldEffects
import Alamofire
import ObjectMapper
import FBSDKCoreKit
import FBSDKLoginKit
import Alamofire
import ObjectMapper
import GoogleSignIn


class LoginViewController: UIViewController,GIDSignInDelegate,GIDSignInUIDelegate {
    
    @IBOutlet var loginButton: UIButton!
    @IBOutlet weak var emailTextfiled: HoshiTextField!
    @IBOutlet weak var passwordTextfiled: HoshiTextField!
    
    @IBOutlet weak var passwordB: UIButton!
    var loginModelData:LoginModel!
    var subLoginData:[LoginEventData]?
    var facebookLoginData:[facebookEventData]?
    var gmailLoginData:[gmailEventData]?
    
    var facebookModelData:FacebookModel!
    var gmailModelData:GmailModel!
    
    var facebookEmail:String = ""
    var facebookName:String = ""
    var facebookProfile:String = ""
    var gmailEmail:String = ""
    var gmailName:String = ""
    var gmailProfile:String = ""
    var iconClick = true
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        self.emailTextfiled.text! = "jass@gmail.com"
        //        self.passwordTextfiled.text! = "123456"
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        loginButton.layer.shadowColor = UIColor.lightGray.cgColor
        loginButton.layer.shadowOpacity = 0.7
        loginButton.layer.shadowOffset = CGSize.zero
        loginButton.layer.shadowRadius = 5
        loginButton.layer.shadowPath = UIBezierPath(rect: loginButton.bounds).cgPath
        
    }
    
    @IBAction func passwordAction(_ sender: UIButton) {
        
        if (iconClick == true)
        {
            passwordB.setImage(UIImage(named: "icons8-eye-40"), for: UIControl.State.normal)
            passwordTextfiled.isSecureTextEntry = false
            
        }
        else{
            passwordB.setImage(UIImage(named: "icons8-invisible-40 (1)"), for: UIControl.State.normal)
            passwordTextfiled.isSecureTextEntry = true
        }
        iconClick = !iconClick
        
        
    }
    
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!)
    {
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            // Perform any operations on signed in user here.
            //            let userId = user.userID                  // For client-side use only!
            //            print(userId)
            //            let idToken = user.authentication.idToken // Safe to send to the server
            self.gmailName = user.profile.name
            //            print(fullName)
            //            let givenName = user.profile.givenName
            //            let familyName = user.profile.familyName
            self.gmailEmail = user.profile.email
            
            // let image = user.profile.imageURL(withDimension: 120)
            
          //  self.gmailProfile = user.profile.imageURL(withDimension: 400)
            
            if !(NetworkEngine.networkEngineObj.isInternetAvailable())
            {
                NetworkEngine.networkEngineObj.showInterNetAlert()
            }
            else
            {
              gmailAPI()
            }
            
        }
    }
    
    
    
    
    
    @IBAction func LoginAction(_ sender: UIButton) {
        validationLogin()
    }
    
    @IBAction func signUpaction(_ sender: UIButton) {
        
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func forgotPassword(_ sender: UIButton)
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForgotViewController") as! ForgotViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func facebookAction(_ sender: UIButton) {
        
        
        let fbLoginManager:LoginManager = LoginManager()
        fbLoginManager.logIn(permissions: ["email"], from: self) { (result,error) in
            if (error == nil)
            {
                let fbLoginresult:LoginManagerLoginResult = result!
                
                if fbLoginresult.grantedPermissions != nil
                {
                    if (fbLoginresult.grantedPermissions.contains("email"))
                    {
                        
                        self.GetFBUserData()
                        
                        fbLoginManager.logOut()
                    }
                }
            }
        }
        
    
    }
   
    func GetFBUserData()
    {
        if ((AccessToken.current)) != nil
        {
            GraphRequest(graphPath: "me", parameters: ["fields":"id,name,first_name,last_name, picture.width(400).height(400),email"]).start(completionHandler:{(connection,result,error ) -> Void in
                
                if (error == nil)
                {
                    let faceDict = result as! [String:Any]
                    
                    self.facebookEmail = faceDict["email"] as? String ?? ""
                   
                    print(self.facebookEmail)
                    
                    let faceBookID = faceDict["id"] as? String ?? ""
                    print(faceBookID)
                    self.facebookName = faceDict["name"] as? String ?? ""
                    // self.us.text! = self.facebookEmail
                    
                    let picture:[String:Any] = faceDict["picture"] as? [String:Any] ?? [:]
                    let userPic = picture["data"] as! [String:Any]
                    self.facebookProfile = userPic["url"] as? String ?? ""
                    
                    if !(NetworkEngine.networkEngineObj.isInternetAvailable())
                    {
                        NetworkEngine.networkEngineObj.showInterNetAlert()
                    }
                    else
                    {
                        self.facebookAPI()
                    }
                    
                    print(self.facebookName)
                 
                }
                
            })
            
        }
        
    }
    
  
    @IBAction func googleAction(_ sender: UIButton) {
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
        GIDSignIn.sharedInstance().signOut()
    
    }
    
    
    // MARK :- Facebook API here.
    
    func facebookAPI()
    {
        let params:[String:Any] = [
            "email":facebookEmail,
            "deviceToken":"abc",
            "deviceType":"1",
            "type":"F",
            "username":facebookName,
            "profileImage":facebookProfile]
        
        print(params)
        WebService.shared.apiDataPostMethod(url:facebookURL, parameters: params) { (response, error) in
            if error == nil
            {
                self.facebookModelData = Mapper<FacebookModel>().map(JSONObject: response)
                
                if self.facebookModelData?.status == "success"
                {
                    let tokenObj = self.facebookModelData?.data?.userEmail ?? ""
                    defaultValues.setValue(tokenObj, forKey: "tokenObj")
                    defaultValues.synchronize()
                    let email = self.facebookModelData?.data?.userEmail
                    defaultValues.set(email, forKey: "email")
                      defaultValues.synchronize()
                    let name = self.facebookModelData?.data?.userNicename
                    defaultValues.set(name, forKey: "name")
                    defaultValues.synchronize()
                    if let home = self.facebookModelData.data?.eventData, home.count > 0
                    {
                     
                        let eventID = home[0].id
                        defaultValues.set(eventID, forKey: "eventID")
                        defaultValues.synchronize()
                        let eventType = home[0].eventType
                        defaultValues.set(eventType, forKey: "eventType")
                        defaultValues.synchronize()
                        
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
                        let navVC = UINavigationController.init(rootViewController: vc)
                        navVC.setNavigationBarHidden(true, animated: true)
                        if let window = UIApplication.shared.windows.first
                        {
                            window.rootViewController = navVC
                            window.makeKeyAndVisible()
                        }
                    }
                    else
                    {
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SubHome_VC") as! SubHome_VC
                        
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                 
                }
                else if self.facebookModelData?.status == "fail"
                {
                    Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr:self.facebookModelData?.message ?? "")
                    
                }
                
            }
                
            else
            {
                Helper.helper.showAlertMessage(vc:self, titleStr: "Notification", messageStr: error?.localizedDescription ?? "")
                
            }
            
            
        }
        
    }
    
    // MARK :- gmail API here.
    
    func gmailAPI()
    {
        let params:[String:Any] = [
            "email":gmailEmail,
            "deviceToken":"abc",
            "deviceType":"1",
            "type":"G",
            "username":gmailName,
             "profileImage":gmailProfile]
        
        print(params)
        WebService.shared.apiDataPostMethod(url:gmailURL, parameters: params) { (response, error) in
            if error == nil
            {
                self.gmailModelData = Mapper<GmailModel>().map(JSONObject: response)
                
                if self.gmailModelData?.status == "success"
                {
                    let tokenObj = self.gmailModelData?.data?.userEmail ?? ""
                    defaultValues.setValue(tokenObj, forKey: "tokenObj")
                    defaultValues.synchronize()
                    
                    let email = self.gmailModelData?.data?.userEmail
                    defaultValues.set(email, forKey: "email")
                      defaultValues.synchronize()
                    let name = self.gmailModelData?.data?.userNicename
                    defaultValues.set(name, forKey: "name")
                    defaultValues.synchronize()
                    
                    if let home = self.gmailModelData.data?.eventData, home.count > 0
                    {
                        
                        
                        let eventID = home[0].id
                        
                        defaultValues.set(eventID, forKey: "eventID")
                        
                        let eventType = home[0].eventType
                        defaultValues.set(eventType, forKey: "eventType")
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
                        let navVC = UINavigationController.init(rootViewController: vc)
                        navVC.setNavigationBarHidden(true, animated: true)
                        if let window = UIApplication.shared.windows.first
                        {
                            window.rootViewController = navVC
                            window.makeKeyAndVisible()
                        }
                        
                    }
                   
                    
                   else
                    {
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SubHome_VC") as! SubHome_VC
                        
                        self.navigationController?.pushViewController(vc, animated: true)
                    }


                    
                }
                else if self.gmailModelData?.status == "fail"
                {
                    Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr:self.gmailModelData?.message ?? "")
                    
                }
                
            }
                
            else
            {
                Helper.helper.showAlertMessage(vc:self, titleStr: "Notification", messageStr: error?.localizedDescription ?? "")
                
            }
            
            
        }
        
    }
    
    
    //  MARK :- Email validation
    
    func isValidEmail(testStr:String) -> Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func validationLogin()
    {
        if (emailTextfiled.text?.count == 0) && (passwordTextfiled.text?.count == 0)
            
        {
            Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Please enter all details.")
        }
        else if emailTextfiled.text?.count == 0
        {
            Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Enter Your Email")
        }
            
        else if passwordTextfiled.text?.count == 0
        {
            Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Enter Your Password")
        }
        else
        {
            
            let check = isValidEmail(testStr: emailTextfiled.text!)
            if check
            {
                if CheckInternet.Connection()
                {
                    self.loginAPI()
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
    
    func loginAPI()
    {
        let params:[String:Any] = [
            "email":emailTextfiled.text!,
            "password":passwordTextfiled.text!,
            "deviceToken":"12345676789",
            "deviceType":"1"]
        
        
        print("para in login = ")
        print(params)
        
       
        WebService.shared.apiDataPostMethod(url:loginURL, parameters: params) { (response, error) in
            if error == nil
            {
                
                 print("login success response \(response)")
                if let data1 = (response as! NSDictionary).value(forKey: "data") as? NSDictionary
                {
                    defaultValues.setValue(data1.value(forKey: "user_email") as? String, forKey: "tokenObj")
                    defaultValues.set(data1.value(forKey: "user_email") as? String, forKey: "email")
                    
                     defaultValues.setValue(data1.value(forKey: "user_nicename") as? String, forKey: "name")
                    
                    if let eventArray = data1.value(forKey: "event_data") as? NSArray
                    {
                        if eventArray.count>0
                        {
                            if let dict = eventArray.object(at: 0) as? NSDictionary
                            {
                               
                                defaultValues.set(dict.value(forKey: "id") as! String, forKey: "eventID")
                                
                               
                                defaultValues.set(dict.value(forKey: "event_type") as! String, forKey: "eventType")
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
                        else
                        {
                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SubHome_VC") as! SubHome_VC
                            //                        vc.eventType = EventType ?? ""
                            //                        vc.eventID = eve
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                    else
                    {
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SubHome_VC") as! SubHome_VC
                        //                        vc.eventType = EventType ?? ""
                        //                        vc.eventID = eve
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    defaultValues.synchronize()
                    
                   
                }
                
                /*
                
                self.loginModelData = Mapper<LoginModel>().map(JSONObject: response)
                
                if self.loginModelData?.status == "success"
                {
                    let email = self.loginModelData?.data?.userEmail
                    
                    
                    defaultValues.set(email, forKey: "email")
                    defaultValues.synchronize()
                    
                    let tokenObj = self.loginModelData?.data?.userEmail ?? ""
                    let userNicename = self.loginModelData?.data?.userNicename ?? ""
                   // defaultValues.set(userNicename, forKey: "userNicename")
                    defaultValues.setValue(tokenObj, forKey: "tokenObj")
                    defaultValues.setValue(userNicename, forKey: "name")
                    
                    defaultValues.synchronize()
                    
                    
                    if let home = self.loginModelData.data?.eventData, home.count > 0
                    {
                        
                        
                        let eventID = home[0].id
                        defaultValues.set(eventID, forKey: "eventID")
                        
                        let eventType = home[0].eventType
                        defaultValues.set(eventType, forKey: "eventType")
                        
                        
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
                        let navVC = UINavigationController.init(rootViewController: vc)
                        navVC.setNavigationBarHidden(true, animated: true)
                        if let window = UIApplication.shared.windows.first
                        {
                            window.rootViewController = navVC
                            window.makeKeyAndVisible()
                        }
                        
                    }
                    else
                    {

                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SubHome_VC") as! SubHome_VC
//                        vc.eventType = EventType ?? ""
//                        vc.eventID = eve
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    
                }
                else if self.loginModelData?.status == "fail"
                {
                    Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr:self.loginModelData.message ?? "")
                    
                }
                
                */
                
            }
        
            else
            {
                Helper.helper.showAlertMessage(vc:self, titleStr: "Notification", messageStr: error?.localizedDescription ?? "")
                
            }
            
            
        }
        
    }
    
    
    
}
