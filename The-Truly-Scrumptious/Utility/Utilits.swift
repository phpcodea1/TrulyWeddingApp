//
//  Utilits.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 29/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit
class Utility
{
    private init(){}
    var utility = Utility()
    func showAlertMessage(vc: UIViewController?, titleStr:String, messageStr:String) -> Void
    {
        let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertController.Style.alert);
        let action = UIAlertAction.init(title: "ok", style: .default, handler: nil)
        alert.addAction(action)
        if (vc == nil)
        {
            if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
                window.rootViewController?.present(alert, animated: true, completion: nil)
            }
        }
        else
        {
            vc?.present(alert, animated: true, completion: nil)
        }
    }
    func isValidString(string:String)-> Bool{
        let allowedCharacters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
        let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
        let typedCharacterSet = CharacterSet(charactersIn: string)
        let alphabet = allowedCharacterSet.isSuperset(of: typedCharacterSet)
        return alphabet
    }
}






