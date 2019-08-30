//
//  LoginModel.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 29/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import Foundation
import ObjectMapper


class LoginModel :Mappable {
    
    var code : String?
    var data : LoginData?
    var message : String?
    var status : String?

    
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        code    <- map["code"]
        message    <- map["message"]
        status    <- map["status"]
        data    <- map["data"]
        
    }
    
    
}


class LoginData :Mappable{
    
   // var deviceToken1 : String?
    var deviceType : String?
    var displayName : String?
    var iD : String?
    var eventData : [LoginEventData]?
    var profileImage : String?
    var registerType : String?
    var userActivationKey : String?
    var userEmail : String?
    var userLogin : String?
    var userNicename : String?
    var userPass : String?
    var userRegistered : String?
    var userStatus : String?
    var userUrl : String?
    
    required init?(map: Map) { }
    
    func mapping(map: Map)
    {
        //deviceToken1       <- map["deviceToken"]
        deviceType  <- map["deviceType"]
        displayName    <- map["display_name"]
        iD     <- map["ID"]
        profileImage   <- map["profileImage"]
        registerType   <- map["register_type"]
        userActivationKey       <- map["user_activation_key"]
        userEmail  <- map["user_email"]
        userLogin   <- map["user_login"]
        userNicename       <- map["user_nicename"]
        userPass  <- map["user_pass"]
        userRegistered   <- map["user_registered"]
        userStatus       <- map["user_status"]
        userUrl  <- map["user_url"]
        eventData <- map["event_data"]
        
       
    }
}


class LoginEventData : Mappable{
    
    var aboutMe : String?
    var anotherPersonName : String?
    var celebrationBannerImage : String?
    var celebrationDate : String?
    var celebrationProfileImage : String?
    var celebrationTitle : String?
    var createdAt : String?
    var eventType : String?
    var id : String?
    var personName : String?
    var totalBudget : String?
    var userId : String?
    
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        aboutMe       <- map["about_me"]
        anotherPersonName  <- map["another_person_name"]
        celebrationBannerImage    <- map["celebration_banner_image"]
        celebrationDate     <- map["celebration_date"]
        celebrationProfileImage   <- map["celebration_profile_image"]
        celebrationTitle   <- map["celebration_title"]
        // createdAt       <- map["user_activation_key"]
        eventType  <- map["event_type"]
        id   <- map["id"]
        personName       <- map["person_name"]
        totalBudget  <- map["total_budget"]
        userId   <- map["user_id"]
        
    }
}




// Mark facebook model

class FacebookModel : Mappable{
    
    var code : String?
    var data : FaceBookData?
    var message : String?
    var status : String?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        code    <- map["code"]
        message    <- map["message"]
        status    <- map["status"]
        data    <- map["data"]
        
    }
 
}




class FaceBookData:Mappable{

  //  var deviceToken1 : String?
    var deviceType : String?
    var displayName : String?
    var eventData : [facebookEventData]?
    var iD : String?
    var profileImage : String?
    var registerType : String?
    var userActivationKey : String?
    var userEmail : String?
    var userLogin : String?
    var userNicename : String?
    var userPass : String?
    var userRegistered : String?
    var userStatus : String?
    var userUrl : String?
    
    
   
    required init?(map: Map) { }
    
    func mapping(map: Map) {
     //   deviceToken1       <- map["deviceToken"]
        deviceType  <- map["deviceType"]
        displayName    <- map["display_name"]
        iD     <- map["ID"]
        profileImage   <- map["profileImage"]
        registerType   <- map["register_type"]
        userActivationKey       <- map["user_activation_key"]
        userEmail  <- map["user_email"]
        userLogin   <- map["user_login"]
        userNicename       <- map["user_nicename"]
        userPass  <- map["user_pass"]
        userRegistered   <- map["user_registered"]
        userStatus       <- map["user_status"]
        userUrl  <- map["user_url"]
        eventData <- map["event_data"]
    
    }
}



class facebookEventData : Mappable{
    
    var aboutMe : String?
    var anotherPersonName : String?
    var celebrationBannerImage : String?
    var celebrationDate : String?
    var celebrationProfileImage : String?
    var celebrationTitle : String?
    var createdAt : String?
    var eventType : String?
    var id : String?
    var personName : String?
    var totalBudget : String?
    var userId : String?


    required init?(map: Map) { }
    
    func mapping(map: Map) {
        aboutMe       <- map["about_me"]
        anotherPersonName  <- map["another_person_name"]
        celebrationBannerImage    <- map["celebration_banner_image"]
        celebrationDate     <- map["celebration_date"]
        celebrationProfileImage   <- map["celebration_profile_image"]
        celebrationTitle   <- map["celebration_title"]
       // createdAt       <- map["user_activation_key"]
        eventType  <- map["event_type"]
        id   <- map["id"]
        personName       <- map["person_name"]
        totalBudget  <- map["total_budget"]
        userId   <- map["user_id"]
        
    }
}

class GmailModel : Mappable{
    
    var code : String?
    var data : FaceBookData?
    var message : String?
    var status : String?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        code    <- map["code"]
        message    <- map["message"]
        status    <- map["status"]
        data    <- map["data"]
        
    }
    
}



class GmailData:Mappable{
    
   // var deviceToken1 : String?
    var deviceType : String?
    var displayName : String?
    var eventData : [gmailEventData]?
    var iD : String?
    var profileImage : String?
    var registerType : String?
    var userActivationKey : String?
    var userEmail : String?
    var userLogin : String?
    var userNicename : String?
    var userPass : String?
    var userRegistered : String?
    var userStatus : String?
    var userUrl : String?
    
    
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
       // deviceToken1       <- map["deviceToken"]
        deviceType  <- map["deviceType"]
        displayName    <- map["display_name"]
        iD     <- map["ID"]
        profileImage   <- map["profileImage"]
        registerType   <- map["register_type"]
        userActivationKey       <- map["user_activation_key"]
        userEmail  <- map["user_email"]
        userLogin   <- map["user_login"]
        userNicename       <- map["user_nicename"]
        userPass  <- map["user_pass"]
        userRegistered   <- map["user_registered"]
        userStatus       <- map["user_status"]
        userUrl  <- map["user_url"]
        eventData <- map["event_data"]
        
    }
}



class gmailEventData : Mappable{
    
    var aboutMe : String?
    var anotherPersonName : String?
    var celebrationBannerImage : String?
    var celebrationDate : String?
    var celebrationProfileImage : String?
    var celebrationTitle : String?
    var createdAt : String?
    var eventType : String?
    var id : String?
    var personName : String?
    var totalBudget : String?
    var userId : String?
    
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        aboutMe       <- map["about_me"]
        anotherPersonName  <- map["another_person_name"]
        celebrationBannerImage    <- map["celebration_banner_image"]
        celebrationDate     <- map["celebration_date"]
        celebrationProfileImage   <- map["celebration_profile_image"]
        celebrationTitle   <- map["celebration_title"]
        // createdAt       <- map["user_activation_key"]
        eventType  <- map["event_type"]
        id   <- map["id"]
        personName       <- map["person_name"]
        totalBudget  <- map["total_budget"]
        userId   <- map["user_id"]
        
    }
}
