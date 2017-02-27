//
//  CounterView.swift
//  Flo
//
//  Created by Ike Mattice - Personal on 2/26/17.
//  Copyright © 2017 Ike Mattice. All rights reserved.
//

import UIKit
let numberOfGlasses = 8
let π: CGFloat = CGFloat(M_PI)

@IBDesignable
class CounterView: UIView {
    @IBInspectable var counter: Int = 5 {
        didSet {
            if counter <= numberOfGlasses {
                setNeedsDisplay()
            }
        }
    }
    @IBInspectable var outlineColor: UIColor = .blue
    @IBInspectable var counterColor: UIColor = .orange
    
    override func draw(_ rect: CGRect) {
        
        let center = CGPoint(x: bounds.width/2, y: bounds.height/2)
        let radius: CGFloat = max(bounds.width, bounds.height)
        let arcWidth:  CGFloat = 76
        let startAngle: CGFloat = 3 * π/4
        let endAngle: CGFloat = π/4
        
        //ARC BACKGROUND
        let path = UIBezierPath(arcCenter: center,
                                radius: radius/2 - arcWidth/2,
                                startAngle: startAngle,
                                endAngle: endAngle,
                                clockwise: true)
        path.lineWidth = arcWidth
        counterColor.setStroke()
        path.stroke()
        
        //ARC OUTLINE
        //calculate the difference between the two angles, ensuring it is positive
        let angleDifference: CGFloat = 2 * π - startAngle + endAngle
        //calculate the arc for each glass
        let arcLengthPerGlass = angleDifference / CGFloat(numberOfGlasses)
        //multiply the actual glasses that were consumed
        let outlineEndAngle = arcLengthPerGlass * CGFloat(counter) + startAngle
        
        //Draw the outer arc
        let outlinePath = UIBezierPath(arcCenter: center,
                                       radius: radius/2 - 2.5,
                                       startAngle: startAngle,
                                       endAngle: outlineEndAngle,
                                       clockwise: true)
        //Draw the inner arc
        outlinePath.addArc(withCenter: center,
                           radius: radius/2 - arcWidth + 2.5,
                           startAngle: outlineEndAngle,
                           endAngle: startAngle,
                           clockwise: false)
        outlinePath.close()
        
        outlineColor.setStroke()
        outlinePath.lineWidth = 5.0
        outlinePath.stroke()
    }

}
