//
//  Helper.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 29/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//



import UIKit
class Helper
{
    static var helper = Helper()
    private init(){}
    
    
    // Headding: -   ===== Alert Message ============
    func showAlertMessage(vc: UIViewController?, titleStr:String, messageStr:String) -> Void
    {
        let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertController.Style.alert);
        let action = UIAlertAction.init(title: "Ok", style: .default, handler: nil)
        
        // MARK :- Image Alert
        //        let imageView = UIImageView(frame: CGRect(x: 5, y: 25, width: 40, height: 40))
        //        imageView.image = UIImage(named: "logo")
        //        alert.view.addSubview(imageView)
        
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
        let allowedCharacters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz,./?:;"
        let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
        let typedCharacterSet = CharacterSet(charactersIn: string)
        let alphabet = allowedCharacterSet.isSuperset(of: typedCharacterSet)
        return alphabet
    }
    
}


//Button Corner Radius and Border color

@IBDesignable extension UIButton {
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}
extension UIViewController
{
    // Check is valid phone number or not
    func isValidPhone(phone: String) -> Bool {
        
        let phoneRegex = "^[0-9]{10}$";
        let valid = NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: phone)
        return valid
    }
    
}



