//
//  VenueDetailsModel.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 29/07/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import Foundation
import ObjectMapper

class VenueDetailsModel:Mappable
{
    var code : String?
    var data : Data?
    var message : String?
    var status : String?

required init?(map: Map)
{
    
}

 func mapping(map: Map)
{
    code <- map["code"]
    data <- map["data"]
    message <- map["message"]
    status <- map["status"]
}


    
}
class Data : Mappable{
   
    
    
    var address : String!
    var awards : String!
    var bannerImage : String!
    var catId : String!
    var civil : String!
    var descriptionField : String!
    var guest : String!
    var id : String!
    var lat : String!
    var lng : String!
    var location : String!
    var loginId : String!
    var name : String!
    var price : String!
    var profileImage : String!
    var qualification : String!
    var singleImage : String!
    var telephoneNumber : String!
    var type : String!
    var venue : String!
    var video : String!

    required init?(map: Map) {
        
    }
    
     func mapping(map: Map)
     {
        
        address <- map["address"]
        awards <- map["awards"]
        bannerImage <- map["banner_image"]
        catId <- map["catId"]
        civil <- map["civil"]
        descriptionField <- map["description"]
        guest <- map["guest"]
        id <- map["id"]
        lat <- map["lat"]
        lng <- map["lng"]
        location <- map["location"]
        loginId <- map["loginId"]
        name <- map["name"]
        price <- map["price"]
        profileImage <- map["profileImage"]
        qualification <- map["qualification"]
        singleImage <- map["singleImage"]
        telephoneNumber <- map["telephoneNumber"]
        type <- map["type"]
        venue <- map["venue"]
        video <- map["video"]
       
    }
}
