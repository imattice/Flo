//
//  BackgroundView.swift
//  Flo
//
//  Created by Ike Mattice - Personal on 3/1/17.
//  Copyright © 2017 Ike Mattice. All rights reserved.
//

import UIKit

@IBDesignable
class BackgroundView: UIView {

    @IBInspectable var lightColor: UIColor = .orange
    @IBInspectable var darkColor: UIColor = .yellow
    @IBInspectable var patternSize: CGFloat = 75
    
    override func draw(_ rect: CGRect) {
        //BACKGROUND
        let context = UIGraphicsGetCurrentContext()
        
        context!.setFillColor(darkColor.cgColor)
        
        context!.fill(rect)
        
        //TRIANGLES
        let drawSize = CGSize(width: patternSize, height: patternSize)
        //start recording the drawing to be extracted into an image
        UIGraphicsBeginImageContextWithOptions(drawSize, true, 0.0)
        let drawingContext = UIGraphicsGetCurrentContext()
        
        //set the fill color from the new context
        darkColor.setFill()
        drawingContext!.fill(CGRect(x: 0, y: 0, width: drawSize.width, height: drawSize.height))
        
        let trianglePath = UIBezierPath()
        
        //top triangle
        trianglePath.move(to: CGPoint(x:drawSize.width / 2, y: 0))
        trianglePath.addLine(to: CGPoint(x:0, y: drawSize.height / 2))
        trianglePath.addLine(to: CGPoint(x: drawSize.width, y: drawSize.height / 2))
        
        //left triangle
        trianglePath.move(to: CGPoint(x: 0, y: drawSize.height / 2))
        trianglePath.addLine(to: CGPoint(x: drawSize.width / 2, y: drawSize.height))
        trianglePath.addLine(to: CGPoint(x: 0, y: drawSize.height))
        
        //right triangle
        trianglePath.move(to: CGPoint(x: drawSize.width, y: drawSize.height / 2))
        trianglePath.addLine(to: CGPoint(x: drawSize.width / 2, y: drawSize.height))
        trianglePath.addLine(to: CGPoint(x: drawSize.width, y: drawSize.height))
        
        
        lightColor.setFill()
        trianglePath.fill()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //set drawn image as pattern
        UIColor(patternImage: image!).setFill()
        context!.fill(rect)
    }

}
