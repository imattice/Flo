//
//  PushButtonView.swift
//  Flo
//
//  Created by Ike Mattice - Personal on 2/24/17.
//  Copyright © 2017 Ike Mattice. All rights reserved.
//

import UIKit



//adding this @IBDesignable tag allows the class to be rendered into storyboards
@IBDesignable



class PushButtonView: UIButton {
    
    @IBInspectable var fillColor: UIColor = .green
    @IBInspectable var isAddButton: Bool = true
    
    override func draw(_ rect: CGRect) {
        //circular background
        let path = UIBezierPath(ovalIn: rect)
        fillColor.setFill()
        path.fill()
        
        //horizontal stroke
        let plusHeight: CGFloat = 3.0
        let plusWidth: CGFloat = min(bounds.width, bounds.height) * 0.6
        
        let plusPath = UIBezierPath()
 
        //HORIZONTAL LINE
        //move the initial point of the path to the start of the horizontal stroke
        //NOTE: not adding the 0.5 to the end of the point coordinates causes the device to ustilize anti-aliasing, which causes half-pixel values to be colored by a color that is halfway between the background color and the stroke color, resulting in a fuzzy line
        plusPath.move(to: CGPoint(
                x: bounds.width/2 - plusWidth/2 + 0.5,
                y: bounds.height/2 + 0.5)
        )
    
        //add the point to the path at the end of the stroke
        plusPath.addLine(to: CGPoint(
            x: bounds.width/2 + plusWidth/2 + 0.5,
            y: bounds.height/2 + 0.5)
        )
        
        if isAddButton {
        //VERTICAL LINE
        //move the initial point of the path to the start of the vertical stroke
        plusPath.move(to: CGPoint(
            x: bounds.width/2 + 0.5,
            y: bounds.height/2 - plusWidth/2 + 0.5)
        )
        
        //add the point to the path at the end of the stroke
        plusPath.addLine(to: CGPoint(
            x: bounds.width/2 + 0.5,
            y: bounds.height/2 + plusWidth/2 + 0.5)
        )
        }
        //set the stroke color
        UIColor.white.setStroke()
        
        //draw the stroke
        plusPath.stroke()
    }

}
