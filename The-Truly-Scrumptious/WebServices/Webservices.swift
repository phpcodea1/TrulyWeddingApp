//
//  Webservices.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 29/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import Foundation

let baseURL = "http://112.196.9.211:8230/trully/wp-json/custom-plugin/"


let registerURL = baseURL + "register"


let loginURL = baseURL + "login"


let forgotURL = baseURL + "forgotPassword"


let resetPasswordURL = baseURL + "resetPassword"


let facebookURL = baseURL + "socail_login"


let gmailURL = baseURL + "socail_login"


let logoutURL = baseURL + "logout"


let weddingURL = baseURL + "addwedding"


let celebrationURL = baseURL + "addcelebration"


let OTPURL = baseURL + "changepasswordotp"


let changePasswordURL = baseURL + "changePassword"


let viewProfileURL = baseURL + "profile"



let DEFAULT = UserDefaults.standard


let addGuestURL = baseURL + "addguest"

// edit guest api

let AllGuestURL = baseURL + "getguestlsit"


let listURL = baseURL + "getlist"


let tableURL = baseURL + "tablelist"


let menuURL = baseURL + "menulist"


let ADDlistURL = baseURL + "addlist"


let ADDtableURL = baseURL + "addtable"


let ADDmenuURL = baseURL + "addmenu"


let EditGuestURL = baseURL + "editguest"


let ADDBUDGET = baseURL + "addbudget"


let ADDEXPENSE = baseURL + "addexpense"


let ALLCATEGORY = baseURL + "categories"

let UPLOADPHOTO = baseURL + "updateprofileimage"

let ALLEVENTS = baseURL + "allevents"

let ALLBUDGETCAT = baseURL + "budgetcat"

let EXPANSEPAYMENT = baseURL + "expensepayment"

let UPDATEEXPENSE = baseURL + "updateexpense"

let ALLTASKCAT = baseURL + "taskcategories"

let ADDTASK = baseURL + "addtask"

let GUESTGROUPNAME = baseURL + "guestgroupnames"

let SELECTEVENTAPI = baseURL + "updateselectevent"

let DELETEGUESTAPI = baseURL + "removeguest"

let FULLGUESTAPI = baseURL + "getguestlistfull"

let GETALLTABLEDATA = baseURL + "grouptablelist"

let GETLISTDATA = baseURL + "grouplist_list"

let GETMENULISTDATA = baseURL + "groupmenu"

let EDITTABLE = baseURL + "edittable"

let DELETETABLE = baseURL + "deletetable"

let MOVETABLE = baseURL + "dragedittable"


let EDITMENU = baseURL + "editmenu"

let DELETEMENU = baseURL + "deletemenu"

let MOVEEMENU = baseURL + "drageditmenu"

let EDITLIST = baseURL + "editlist"

let DELETELIST = baseURL + "deletelist"


// To - Do - List

let GETALLLIST = baseURL + "get_usertask"

let DOUNDOLIST = baseURL + "taskdoneundone"

let EDITTASK = baseURL + "taskedit"

let REMOVETASK = baseURL + "removetask"

// wedding show

let WEDDINGSHOW = baseURL + "getweddingshows"

let PREREGISTERWEDDINGSHOW = baseURL + "preregisterweddingshows"

// venue show

let VENUEBYNAME = baseURL + "venuebyname"
let VENUEFILTER = baseURL + "venuefilter"

let VENUEDETAILS = baseURL + "singlevenue"

let VENUECATNAME = baseURL + "venuecat"


let VENUELIKEUNLIKE = baseURL + "addvenuefavourite"

let VENUEFAVRITE = baseURL + "getvenuefavourite"

let VENUEREQUESTPRICING = baseURL + "venuerequestprice"

let GETVENUEREQUEST = baseURL + "getvenuerequests"

let VENUEBOOKMARKANDSORT = baseURL + "markbooksort"



// Supplier module

let SUPLLIERWITHCAT = baseURL + "supplierwithcat"

let SUPPLIERLIKEUNLIKE = baseURL + "addsupplierfavourite"
