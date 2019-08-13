//
//  TabBarViewController.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 14/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController,UITabBarControllerDelegate
{

     var hideMainView = String()
    var loginView = String()
    override func viewDidLoad()
    {
        super.viewDidLoad()

      self.tabBarController?.delegate = self
    }
   
    
   
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem)
    {
        
        //   self.view.makeToast("Loading...")
        
        if item == (self.tabBar.items as! [UITabBarItem])[0]
        {

         //   NotificationCenter.default.post(name: Notification.Name("DidSelectCollection"), object: self)
            
//                let targetVc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
//
//                print("Amarendra tab click")
//                let appDelRef = UIApplication.shared.delegate as! AppDelegate
//                let rootWindow = appDelRef.window
//                targetVc.selectedIndex = 0
//                // self.window?.rootViewController  = vc
//                rootWindow!.rootViewController = targetVc
//                                SCANNERDATA = "0"
//             rootWindow?.makeKeyAndVisible()
//              UIApplication.shared.endIgnoringInteractionEvents()


        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        
     
    }
}

/*

 class TabbarController: UITabBarController,UITabBarControllerDelegate {
 override func viewDidLoad() {
 super.viewDidLoad()
 let tabBarItems = tabBar.items! as [UITabBarItem]
 tabBarItems[0].imageInsets = UIEdgeInsetsMake(6,0,-6,0)
 tabBarItems[1].imageInsets = UIEdgeInsetsMake(6,0,-6,0)
 tabBarItems[2].imageInsets = UIEdgeInsetsMake(6,0,-6,0)
 tabBarItems[3].imageInsets = UIEdgeInsetsMake(6,0,-6,0)
 
 self.tabBarController?.delegate = self
 
 }
 
 override func didReceiveMemoryWarning() {
 super.didReceiveMemoryWarning()
 // Dispose of any resources that can be recreated.
 
 self.delegate = self
 }
 func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
 
 //        if let firstVC = viewController as? FirstViewController {
 //            firstVC.doSomeAction()
 //        }
 //
 //        if viewController is FirstViewController {
 //            print("First tab")
 //        } else if viewController is SecondViewController {
 //            print("Second tab")
 //        }
 }
 
 // alternate method if you need the tab bar item
 
 override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem)
 {
 
 //   self.view.makeToast("Loading...")
 
 if item == (self.tabBar.items as! [UITabBarItem])[0]
 {
 //SCANNERDATA = ""
 if #available(iOS 11.0, *) {
 //                if(SCANNERDATA == "X")
 //                {
 //
 //                    self.view.makeToast("Loading...")
 //                }
 //             else
 //                {
 self.view.makeToast("Loading...")
 //  self.view.makeToast("", duration: 1, position: (Any).self, title: "Loading..", image: nil, style:nil, completion: nil)
 // self.view.makeToast("Loading...", duration: 1.5, position: "bottom")
 SCANNERDATA = "2"
 let targetVc = self.storyboard?.instantiateViewController(withIdentifier: "TabbarController") as! TabbarController
 let appDelRef = UIApplication.shared.delegate as! AppDelegate
 let rootWindow = appDelRef.window
 targetVc.selectedIndex = 0
 // self.window?.rootViewController  = vc
 rootWindow!.rootViewController = targetVc
 // SCANNERDATA = "0"
 rootWindow?.makeKeyAndVisible()
 UIApplication.shared.endIgnoringInteractionEvents()
 
 //}
 } else {
 // Fallback on earlier versions
 }
 }
 else if item == (self.tabBar.items as! [UITabBarItem])[1]
 {
 HOMELOADED = "yes"
 LOADERSHOW = "1"
 SCANNERDATA = "X"
 //Do something if index is 1
 }
 else if item == (self.tabBar.items as! [UITabBarItem])[2]
 {
 HOMELOADED = "yes"
 LOADERSHOW = "1"
 SCANNERDATA = "X"
 //Do something if index is 1
 }
 else if item == (self.tabBar.items as! [UITabBarItem])[3]
 {
 HOMELOADED = "yes"
 // LOADERSHOW = "1"
 //Do something if index is 1
 print("Assest")
 if #available(iOS 11.0, *) {
 if(SCANNERDATA == "X")
 {
 NetworkEngine.networkEngineObj.LOADERSHOW()
 let targetVc = self.storyboard?.instantiateViewController(withIdentifier: "TabbarController") as! TabbarController
 let appDelRef = UIApplication.shared.delegate as! AppDelegate
 let rootWindow = appDelRef.window
 targetVc.selectedIndex = 3
 // self.window?.rootViewController  = vc
 rootWindow!.rootViewController = targetVc
 //                    SCANNERDATA = "0"
 rootWindow?.makeKeyAndVisible()
 UIApplication.shared.endIgnoringInteractionEvents()
 }
 else
 
 {
 NetworkEngine.networkEngineObj.LOADERSHOW()
 let targetVc = self.storyboard?.instantiateViewController(withIdentifier: "TabbarController") as! TabbarController
 let appDelRef = UIApplication.shared.delegate as! AppDelegate
 let rootWindow = appDelRef.window
 targetVc.selectedIndex = 3
 // self.window?.rootViewController  = vc
 rootWindow!.rootViewController = targetVc
 //                    SCANNERDATA = "0"
 rootWindow?.makeKeyAndVisible()
 UIApplication.shared.endIgnoringInteractionEvents()
 // self.showToast(message: "Loading...")
 
 
 }
 } else {
 // Fallback on earlier versions
 }
 
 }
 
 
 //  UIApplication.shared.beginIgnoringInteractionEvents()
 //        let selectedImageView = self.tabBar.subviews[item.tag].subviews.first!
 //         selectedImageView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
 //        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
 //       selectedImageView.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
 //
 //        }) { (success) in
 //
 //         UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
 //
 //         selectedImageView.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
 //
 //         }, completion: { (success) in
 //
 //        UIView.animate(withDuration: 0.3, animations: {
 //
 //       selectedImageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
 //
 //       UIApplication.shared.endIgnoringInteractionEvents()
 //
 //
 //        })
 //
 //
 //
 //         })
 //
 //
 //
 //        }
 //
 // //-- set value for assests data---
 //   if tabBar.selectedItem!.tag == 4
 //   {
 //
 //  NetworkEngine.networkEngineObj.shoudLoadAssetsData = true
 //
 //        }
 //
 
 }
 
 func showToast(message : String) {
 
 let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
 toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
 toastLabel.textColor = UIColor.white
 toastLabel.textAlignment = .center;
 toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
 toastLabel.text = message
 toastLabel.alpha = 1.0
 toastLabel.layer.cornerRadius = 10;
 toastLabel.clipsToBounds  =  true
 self.view.addSubview(toastLabel)
 UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
 toastLabel.alpha = 0.0
 }, completion: {(isCompleted) in
 toastLabel.removeFromSuperview()
 })
 }
 
 }
 
 */
