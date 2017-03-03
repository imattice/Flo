//
//  MedalView.swift
//  Flo
//
//  Created by Ike Mattice - Personal on 3/2/17.
//  Copyright © 2017 Ike Mattice. All rights reserved.
//

import UIKit

class MedalView: UIImageView {
    lazy var medalImage: UIImage = self.createMedalImage()
    
    func createMedalImage() -> UIImage {
        print("creating Medal Image")
        
        let size = CGSize(width: 120, height: 200)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        
        //COLORS
        let darkGoldColor = UIColor(red: 0.6, green: 0.5, blue: 0.15, alpha: 1.0)
        let midGoldColor = UIColor(red: 0.86, green: 0.73, blue: 0.3, alpha: 1.0)
        let lightGoldColor = UIColor(red: 1.0, green: 0.98, blue: 0.9, alpha: 1.0)
        let shadow: UIColor = .black
        shadow.withAlphaComponent(0.8)
        
        //SHADOW
        let shadowOffset = CGSize(width: 2.0, height: 2.0)
        let shadowBlurRadius: CGFloat = 5
        
        context!.setShadow(offset: shadowOffset, blur: shadowBlurRadius, color: shadow.cgColor)
        
        //Draw the object on a transparency layer to prevent shadows from being applied to all drawn objects
        context!.beginTransparencyLayer(auxiliaryInfo: nil)
        
        //LOWER RIBBON
        var lowerRibbonPath = UIBezierPath()
        lowerRibbonPath.move(to: CGPoint(x: 0.0, y: 0.0))
        lowerRibbonPath.addLine(to: CGPoint(x: 40, y: 0))
        lowerRibbonPath.addLine(to: CGPoint(x: 78, y: 70))
        lowerRibbonPath.addLine(to: CGPoint(x: 38, y: 70))
        lowerRibbonPath.close()
        
        UIColor.red.setFill()
        lowerRibbonPath.fill()
        
        //CLASP
        var claspPath = UIBezierPath(roundedRect: CGRect(x: 36, y: 62, width: 43, height: 20), cornerRadius: 5)
        claspPath.lineWidth = 5
        
        darkGoldColor.setStroke()
        claspPath.stroke()
        
        //MEDALLION
        var medallionPath = UIBezierPath(ovalIn: CGRect(origin: CGPoint(x: 8, y:72), size: CGSize(width: 100, height: 100)))
        
        context!.saveGState()
        medallionPath.addClip()
        
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                                       colors: [darkGoldColor.cgColor, midGoldColor.cgColor, lightGoldColor.cgColor] as CFArray,
                                       locations: [0, 0.51, 1])
        context!.drawLinearGradient(gradient!, start: CGPoint(x: 40, y: 40), end: CGPoint(x: 100, y: 160), options: CGGradientDrawingOptions(rawValue: 0))
        
        //create a transform
        //scale it, and translate from right and down
        var transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        transform = transform.translatedBy(x: 15, y: 30)
        
        medallionPath.lineWidth = 2.0
        
        //apply the transform to the path
        medallionPath.apply(transform)
        medallionPath.stroke()
        
        
        //UPPER RIBBON
        var upperRibbonPath = UIBezierPath()
        upperRibbonPath.move(to: CGPoint(x: 68.0, y: 0.0))
        upperRibbonPath.addLine(to: CGPoint(x: 108.0, y: 0.0))
        upperRibbonPath.addLine(to: CGPoint(x: 78.0, y: 70.0))
        upperRibbonPath.addLine(to: CGPoint(x: 38.0, y: 70.0))
        upperRibbonPath.close()
        
        UIColor.blue.setFill()
        upperRibbonPath.fill()
        
        
        //NUMBER 1
        //must be NSString to be able to use draw function
        let numberOne = "1" as NSString
        let numberOneRect = CGRect(x: 47, y: 100, width: 50, height: 50)
        let font = UIFont(name: "Academy Engraved LET", size: 60)
        let textStyle = NSMutableParagraphStyle.default
        let numberOneAttributes = [NSFontAttributeName: font!, NSForegroundColorAttributeName: darkGoldColor]
        
        numberOne.draw(in: numberOneRect, withAttributes: numberOneAttributes)
        
        context!.endTransparencyLayer()
        
        //pin to bottom of playground
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image!
    }

    func showMedal(show: Bool) {
        if show {
            self.image = medalImage
        } else {
            self.image = nil
        }
    }
}
