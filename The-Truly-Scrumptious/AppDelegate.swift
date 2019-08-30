//
//  AppDelegate.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 13/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit
import CoreData

import IQKeyboardManager
import FBSDKCoreKit
import GoogleSignIn
import Foundation

import UIKit
import CoreData
import UserNotifications
import Toast_Swift




@UIApplicationMain
class AppDelegate: UIResponder,UNUserNotificationCenterDelegate,UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        GIDSignIn.sharedInstance().clientID = "433162082332-qr8d0g04ntu6fhkl2bq773q2sbo6ejcc.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self as? GIDSignInDelegate
        IQKeyboardManager.shared().isEnabled = true
        
        // amarendra git check
       registerForRemoteNotification()
      
       Autologin()

        return true
    }
  
  
    
    func Autologin()
    {
        window = UIWindow.init(frame: UIScreen.main.bounds)
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        if token == nil
        {
            let delegate = UIApplication.shared.delegate as? AppDelegate
            let vc = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            let nav = UINavigationController(rootViewController: vc)
            delegate?.window?.rootViewController = nav
            window?.rootViewController = nav
            window?.makeKeyAndVisible()
        }
       
        else
        {
            
            if  let evetType =  DEFAULT.value(forKey: "email") as? String
            {
                let delegate = UIApplication.shared.delegate as? AppDelegate
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
                let nav = UINavigationController(rootViewController: vc)
                nav.setNavigationBarHidden(true, animated: true)
                delegate?.window?.rootViewController = nav
                window?.rootViewController = nav
                window?.makeKeyAndVisible()
            }
            else
            {
                let delegate = UIApplication.shared.delegate as? AppDelegate
                let vc = storyBoard.instantiateViewController(withIdentifier: "SubHome_VC") as! SubHome_VC
                let nav = UINavigationController(rootViewController: vc)
                delegate?.window?.rootViewController = nav
                window?.rootViewController = nav
                window?.makeKeyAndVisible()
                }
            }
           
        
    }
  
 
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "The_Truly_Scrumptious")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
   
  
        
        //--MARK:--Get Token-----
        func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
            var token = ""
            for i in 0..<deviceToken.count
            {
                token = token + String(format: "%02.2hhx", arguments: [deviceToken[i]])
            }
            print("device token =  \(token)")
           
            UserDefaults.standard.set(token, forKey: "DEVICETOKEN")
            UserDefaults.standard.synchronize()
        
        }
    
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error)
    {
        
        print("error = \(error)")
        UserDefaults.standard.setValue("", forKey: "FCMToken")
        UserDefaults.standard.set("", forKey: "token")
        UserDefaults.standard.synchronize()
    }
  
    
    
    //MARK:-- remote notifications methods---
    func registerForRemoteNotification() {
        if #available(iOS 10.0, *)
        {
            let center  = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options: [.sound, .alert, .badge]) { (granted, error) in
                if error == nil
                {
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                    
                }
                else
                
                {
                    print("error = \(error?.localizedDescription)")
                }
            }
            // For iOS 10 data message (sent via FCM
            //            Messaging.messaging().delegate = self
            
        }
        else
        {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.sound, .alert, .badge], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
        
    }
    
    
    //MARK:- Notification Methods------
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print(notification.request.content.userInfo)
        
        let userInfo = notification.request.content.userInfo
        
        print("userInfo = \(userInfo)")
   
        completionHandler([.alert, .badge, .sound])
    }
    //Called to let your app know which action was selected by the user for a given notification.
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
         print("userInfo = \(userInfo)")
        window = UIWindow.init(frame: UIScreen.main.bounds)
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
        let vc = storyBoard.instantiateViewController(withIdentifier: "MYNoticeBoardViewController") as! MYNoticeBoardViewController
        let nav = UINavigationController(rootViewController: vc)
        delegate?.window?.rootViewController = nav
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
        
        completionHandler()
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void)
    {
      print("userInfo = \(userInfo)")
      
        
        completionHandler(UIBackgroundFetchResult.newData)
    }

}


