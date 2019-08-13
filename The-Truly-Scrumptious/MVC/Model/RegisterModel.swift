//
//  RegisterModel.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 29/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import Foundation
import ObjectMapper


class RegisterModel :Mappable {
    
    var code : String?
    var message : String?
    var status : String?
    
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        code    <- map["code"]
        message    <- map["message"]
        status    <- map["status"]

    }
    
  
}


//class FailureModel : Mappable{
//    
//    
//    var code : String?
//    var errors : [ErrorBody]!
//    var status : String?
////    var code :  String?
////    var status: String?
////    var message: ErrorBody!
//    
//    required init?(map: Map) { }
//    
//    func mapping(map: Map) {
//        
//        code      <- map["code"]
//        errors    <- map["errors"]
//        status    <- map["status"]
//    }
//}

//class ErrorBody: Mappable{
//
//    var userName:  [String]?
//    //var phone_number:   [String]?
//
//    required init?(map: Map) {
//    }
//
//    func mapping(map: Map) {
//        email         <- map["email"]
//        phone_number  <- map["mobile_number"]
//    }
//}
