//
//  UIColor+AppColor.swift
//  SwiftTestApp
//
//  Created by Bijit Halder on 10/2/15.
//  Copyright © 2015 Bijit Halder. All rights reserved.
//

import UIKit

extension UIColor {
    // MARK: - Added functions
    
    func mixWithColor(color:UIColor, withFactor lambda:Float) -> UIColor {
        var leftRGBA = [CGFloat](count: 4, repeatedValue: 0.0)
        var rightRGBA = [CGFloat](count: 4, repeatedValue: 0.0)
        
        self.getRed(&leftRGBA[0], green: &leftRGBA[1], blue: &leftRGBA[2], alpha: &leftRGBA[3])
        color.getRed(&rightRGBA[0], green: &rightRGBA[1], blue: &rightRGBA[2], alpha: &rightRGBA[3])
        
        let lambda1:CGFloat = CGFloat(lambda < 0.0 ? 0.0 : (lambda > 1.0 ? 1.0 : lambda))
        let lambda2:CGFloat = 1.0 - lambda1
        
        return UIColor(
            red: (lambda1*leftRGBA[0] + lambda2*rightRGBA[0]),
            green: (lambda1*leftRGBA[1] + lambda2*rightRGBA[1]),
            blue: (lambda1*leftRGBA[2] + lambda2*rightRGBA[2]),
            alpha: (lambda1*leftRGBA[3] + lambda2*rightRGBA[3]) 
        )
    }
    
    func mixWithColor(color:UIColor) -> UIColor {
        return self.mixWithColor(color, withFactor: 0.5)
    }
    func red() -> CGFloat{
        var RGBA = [CGFloat](count: 4, repeatedValue: 0.0)
        self.getRed(&RGBA[0], green: &RGBA[1], blue: &RGBA[2], alpha: &RGBA[3])
        return RGBA[0]
    }
    func blue() -> CGFloat{
        var RGBA = [CGFloat](count: 4, repeatedValue: 0.0)
        self.getRed(&RGBA[0], green: &RGBA[1], blue: &RGBA[2], alpha: &RGBA[3])
        return RGBA[1]
    }
    
    func green() -> CGFloat{
        var RGBA = [CGFloat](count: 4, repeatedValue: 0.0)
        self.getRed(&RGBA[0], green: &RGBA[1], blue: &RGBA[2], alpha: &RGBA[3])
        return RGBA[2]
    }
    func alpha() -> CGFloat{
        var RGBA = [CGFloat](count: 4, repeatedValue: 0.0)
        self.getRed(&RGBA[0], green: &RGBA[1], blue: &RGBA[2], alpha: &RGBA[3])
        return RGBA[3]
    }
    
    //MARK: - Custom Colors
    class var appRedColor: UIColor {
        return UIColor(red: 1.0, green: 0.6, blue: 0.6, alpha: 1.0)
    }
    class var appBlueColor: UIColor {
        return UIColor(red: 0.6, green: 0.6, blue: 1.0, alpha: 1.0)
    }
    
    class var appGreenColor: UIColor {
        return UIColor(red: 0.6, green: 1.0, blue: 0.6, alpha: 1.0)
    }
    
    class var appGrayColor: UIColor {
        return UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
    }
    
    class var appTextColor: UIColor {
        return UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1.0)
    }
    
}