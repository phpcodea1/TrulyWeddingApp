////
////  DesignFiles.swift
////  The-Truly-Scrumptious
////
////  Created by APPLE on 29/05/19.
////  Copyright © 2019 APPLE. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//class Designs {
//    
//}
//
//@IBDesignable
//class RoundedView: UIView {
//    
//    @IBInspectable var cornerRadius: CGFloat = 0{
//        didSet{
//            self.layer.cornerRadius = cornerRadius
//        }
//    }
//    
//    @IBInspectable var borderWidth: CGFloat = 0{
//        didSet{
//            self.layer.borderWidth = borderWidth
//        }
//    }
//    
//    @IBInspectable var borderColor: UIColor = UIColor.clear{
//        didSet{
//            self.layer.borderColor = borderColor.cgColor
//        }
//    }
//}
//
//
//
//private var kAssociationKeyMaxLength: Int = 0
//
//extension UITextField {
//    
//    @IBInspectable var maxLength: Int {
//        get {
//            if let length = objc_getAssociatedObject(self, &kAssociationKeyMaxLength) as? Int {
//                return length
//            } else {
//                return Int.max
//            }
//        }
//        set {
//            objc_setAssociatedObject(self, &kAssociationKeyMaxLength, newValue, .OBJC_ASSOCIATION_RETAIN)
//            addTarget(self, action: #selector(checkMaxLength), for: .editingChanged)
//        }
//    }
//    
//    @objc func checkMaxLength(textField: UITextField) {
//        guard let prospectiveText = self.text,
//            prospectiveText.count > maxLength
//            else {
//                return
//        }
//        
//        let selection = selectedTextRange
//        
//        let indexEndOfText = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
//        let substring = prospectiveText[..<indexEndOfText]
//        text = String(substring)
//        
//        selectedTextRange = selection
//    }
//}
//
//
