//
//  ForgotModel.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 29/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import Foundation
import ObjectMapper


class ForgotModel :Mappable {
    
    var code : String?
    var data : Int?
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
