//
//  Constant.swift
//  The-Truly-Scrumptious
//
//  Created by administrator on 17/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import Foundation
import UIKit

let BORDERCOLOR = UIColor.init(red: 211/255, green: 202/255, blue: 195/255, alpha: 1)
let APPCOLOR = UIColor.init(red: 255/255, green: 204/255, blue: 181/255, alpha: 1)

let COLOR1 = UIColor.init(red: 217/255, green: 145/255, blue: 143/255, alpha: 1)
let COLOR2 = UIColor.init(red: 183/255, green: 181/255, blue: 181/255, alpha: 1)
let COLOR3 = UIColor.init(red: 106/255, green: 218/255, blue: 175/255, alpha: 1)
let COLOR4 = UIColor.init(red: 242/255, green: 158/255, blue: 128/255, alpha: 1)
let COLOR5 = UIColor.init(red: 187/255, green: 240/255, blue: 142/255, alpha: 1)
let COLOR6 = UIColor.init(red: 242/255, green: 158/255, blue: 128/255, alpha: 1)
let COLOR7 = UIColor.init(red: 106/255, green: 218/255, blue: 175/255, alpha: 1)


let TABLESECTIONCOLOR = UIColor.init(red: 239/255, green: 239/255, blue: 244/255, alpha: 1)
var SCANNERDATA = ""

//let AppLoginToken  = "AcessToken"


let defaultValues = UserDefaults.standard

let token = defaultValues.value(forKey: "tokenObj") as? String

//let Email = defaultValues.value(forKey:"email") as? String
let Email = defaultValues.value(forKey:"email") as? String


let EventId = defaultValues.value(forKey:"eventID") as? String


let EventType = defaultValues.value(forKey:"eventType") as? String


let Name = defaultValues.value(forKey: "name") as? String


///let displayName = defaultValues.value(forKey: "userNicename") as? String


var eve: String = EventId ?? ""
