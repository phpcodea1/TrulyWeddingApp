//
//  WeddingModel.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 30/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import Foundation
import ObjectMapper

class WeddingModel : Mappable{
    
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
