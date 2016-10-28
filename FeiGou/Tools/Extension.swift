//
//  Extension.swift
//  YouTube
//
//  Created by  paralworld－02 on 2016/10/18.
//  Copyright © 2016年 like. All rights reserved.
//

import UIKit

let screenW: CGFloat = UIScreen.main.bounds.width
let screenH: CGFloat = UIScreen.main.bounds.height

extension UIColor {
    
    class func rgb(_ r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor.init(red: r / 255,
                            green: g / 255,
                            blue: b / 255,
                            alpha: 1.0)
    }
    
    class func colorFromHex(_ Hex: UInt32) -> UIColor {
        return UIColor.init(red: CGFloat((Hex & 0xFF0000) >> 16) / 255.0,
                            green: CGFloat((Hex & 0xFF00) >> 8) / 255.0,
                            blue: CGFloat((Hex & 0xFF)) / 255.0,
                            alpha: 1.0)
    }

}

extension UIImage {
    
    class func imageWithColor(_ color: UIColor, size: CGSize) -> UIImage {
        var size = size
        if size.equalTo(CGSize.zero) {
            size = CGSize.init(width: 5, height: 5)
        }
        let rect = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
            
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
}

import Foundation

/*
 
 Int,
 Int8,
 Int16,
 Int32,
 Int64,
 UInt,
 UInt8,
 UInt16,
 UInt32,
 UInt64,
 Bool,
 Float,
 Double,
 String,
 */

extension Int: BasePropertyProtocol {}
extension Int8: BasePropertyProtocol {}
extension Int16: BasePropertyProtocol {}
extension Int32: BasePropertyProtocol {}
extension Int64: BasePropertyProtocol {}
extension UInt: BasePropertyProtocol {}
extension UInt8: BasePropertyProtocol {}
extension UInt16: BasePropertyProtocol {}
extension UInt32: BasePropertyProtocol {}
extension UInt64: BasePropertyProtocol {}
extension Bool: BasePropertyProtocol {}
extension Float: BasePropertyProtocol {}
extension Double: BasePropertyProtocol {}
extension String: BasePropertyProtocol {}

extension NSString: BasePropertyProtocol {}
extension NSNumber: BasePropertyProtocol {}
