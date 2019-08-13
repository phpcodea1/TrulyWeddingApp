//
//  ViewProfileModel.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 31/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import Foundation
import ObjectMapper


class ViewProfileModel :Mappable {
    
    var code : String?
    var data : ViewData?
    var message : String?
    var status : String?
    var profileImage : String?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        code    <- map["code"]
        profileImage    <- map["profileImage"]
        message    <- map["message"]
        status    <- map["status"]
        data    <- map["data"]
        
    }
       
}


class ViewData :Mappable{
    
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
    
    func mapping(map: Map)
    {
        aboutMe       <- map["about_me"]
        anotherPersonName  <- map["another_person_name"]
        celebrationBannerImage    <- map["celebration_banner_image"]
        celebrationDate     <- map["celebration_date"]
        celebrationProfileImage   <- map["celebration_profile_image"]
        celebrationTitle   <- map["celebration_title"]
        eventType       <- map["event_type"]
        id  <- map["id"]
        personName   <- map["person_name"]
        totalBudget       <- map["total_budget"]
        userId  <- map["user_id"]
    
        
        
    }
}
