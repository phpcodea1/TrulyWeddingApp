//
//  APIManager.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 29/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import Foundation
import Alamofire
import SVProgressHUD

// MARK:- webservice for POST

class WebService:NSObject{
    
    static let shared:WebService = {
        
        let sharedInsatnce = WebService()
        return sharedInsatnce
    }()
    
    func apiDataPostMethod(url:String,parameters:[String:Any] , completion: @escaping (_ data:[String:Any]? ,  _ error:Error?) -> Void)
    {
        print(url)
        print(parameters)
        if !CheckInternet.Connection()
        {
            SVProgressHUD.dismiss()
            Helper.helper.showAlertMessage(vc:nil, titleStr: "Notification", messageStr: "Please Check The Internet Connection")
        }
        
        SVProgressHUD.show()
        SVProgressHUD.setBorderColor(UIColor.white)
        SVProgressHUD.setForegroundColor(UIColor.white)
        SVProgressHUD.setBackgroundColor(UIColor.black)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 60
        
        manager.request(url, method:.post, parameters: parameters, encoding: URLEncoding.default).responseJSON { (response:DataResponse<Any>) in
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            SVProgressHUD.dismiss()
            
            if response.result.isSuccess
            {
                print("Response Data: \(response)")
                
                if let data = response.result.value as? [String:Any]
                {
                    completion(data , nil)
                     SVProgressHUD.dismiss()
                }else{
                    //Helper.Alertmessage(title: "Alert", message: (response.error?.localizedDescription)!, vc: nil)
                     SVProgressHUD.dismiss()
                    completion(nil,response.error)
                }
            }
            else
            {
                //Helper.Alertmessage(title: "Alert", message: (response.error?.localizedDescription)!, vc: nil)
                 SVProgressHUD.dismiss()
                completion(nil,response.error)
                print("Error \(String(describing: response.result.error))")
            }
            
        }
    }
    
    func apiDataGetMethod(url:String , completion: @escaping (_ data:[String:Any]? ,  _ error:Error?) -> Void)
    {
        print(url)
     
        if !CheckInternet.Connection()
        {
            Helper.helper.showAlertMessage(vc:nil, titleStr: "Notification", messageStr: "Please Check The Internet Connection")
        }
        
        SVProgressHUD.show()
        SVProgressHUD.setBorderColor(UIColor.white)
        SVProgressHUD.setForegroundColor(UIColor.white)
        SVProgressHUD.setBackgroundColor(UIColor.black)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 60
        
        manager.request(url, method:.get, parameters: nil, encoding: URLEncoding.default).responseJSON { (response:DataResponse<Any>) in
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            SVProgressHUD.dismiss()
            
            if response.result.isSuccess
            {
                print("Response Data: \(response)")
                
                if let data = response.result.value as? [String:Any]
                {
                    completion(data , nil)
                    
                }else{
                    //Helper.Alertmessage(title: "Alert", message: (response.error?.localizedDescription)!, vc: nil)
                    
                    completion(nil,response.error)
                }
            }
            else
            {
                //Helper.Alertmessage(title: "Alert", message: (response.error?.localizedDescription)!, vc: nil)
                completion(nil,response.error)
                print("Error \(String(describing: response.result.error))")
            }
            
        }
    }
    
    
  
}


