//
//  GraphView.swift
//  Flo
//
//  Created by Ike Mattice - Personal on 2/27/17.
//  Copyright © 2017 Ike Mattice. All rights reserved.
//

import UIKit



@IBDesignable
class GraphView: UIView {
    var graphPoints: [Int] = [4, 2, 6, 4, 5, 8, 3]

    //gradient properties
    @IBInspectable var startColor: UIColor = .red
    @IBInspectable var endColor: UIColor = .green
    
    override func draw(_ rect: CGRect) {
        //ROUND CORNERS
        let width = rect.width
        let height = rect.height
        
        //set up background clipping area
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: .allCorners,
                                cornerRadii: CGSize(width: 8.0, height: 8.0))
        path.addClip()
        
        
        //GRADIENT BACKGROUND
        //get the current context
        let context = UIGraphicsGetCurrentContext()
        let colors = [startColor.cgColor, endColor.cgColor]
        
        //set up the color space
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        //set up the color stops
        let colorLocations: [CGFloat] = [0.0, 1.0]
        
        //create the gradient
        let gradient = CGGradient.init(colorsSpace: colorSpace,
                                       colors: colors as CFArray,
                                       locations: colorLocations)
        //draw the gradient
        var startPoint = CGPoint.zero
        var endPoint = CGPoint(x: 0, y: self.bounds.height)
        context!.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: 0))
        
        //GRAPH LINE
        //calculate the x point
        let margin: CGFloat = 20.0
        let columnXPoint = { (column:Int) -> CGFloat in
            //calculate gap between points 
            let spacer = (width - margin*2 - 4) / CGFloat((self.graphPoints.count - 1))
            var x: CGFloat = CGFloat(column) * spacer
            x += margin + 2
            return x
        }
        
        //calculate the y point 
        let topBorder: CGFloat = 60
        let bottomBorder: CGFloat = 50
        let graphHeight = height - topBorder - bottomBorder
        let maxValue = graphPoints.max()!
        let columnYPoint = { (graphPoint:Int) -> CGFloat in
            var y: CGFloat = CGFloat(graphPoint) / CGFloat(maxValue) * graphHeight
            y = graphHeight + topBorder - y  //flips the graph, since the origin of the rect starts in the upper left corner, while graph origins start at the bottom left
            return y
        }
        
        //draw the line graph
        UIColor.white.setFill()
        UIColor.white.setStroke()
        
        //set up the points line
        let graphPath = UIBezierPath()
        //go to the start of the line
        graphPath.move(to: CGPoint(x: columnXPoint(0), y: columnYPoint(graphPoints[0])))
        
        //add points for each item in the array at the correct (x, y) for the point
        for i in 1..<graphPoints.count {
            let nextPoint = CGPoint(x: columnXPoint(i), y: columnYPoint(graphPoints[i]))
            graphPath.addLine(to: nextPoint)
        }
        
//        graphPath.stroke()
        
        //GRAPH GRADIENT
        //save the state of the context, which pushes the current graphics state onto the stack
        context!.saveGState()
        
        //use a copy of the graph line as the top of the gradient shape
        let clippingPath = graphPath.copy() as! UIBezierPath
        
        //add lines to the copied path to complet the clip area.  This adds the corner points to the clipped area.
        clippingPath.addLine(to: CGPoint(x: columnXPoint(graphPoints.count - 1), y: height))
        clippingPath.addLine(to: CGPoint(x: columnXPoint(0), y: height))
        clippingPath.close()
        
        clippingPath.addClip()
        
        //user the heighest Y value as the start of the gradient
        let highestYPoint = columnYPoint(maxValue)
            startPoint = CGPoint(x: margin, y: highestYPoint)
            endPoint = CGPoint(x: margin, y: self.bounds.height)
        
        context!.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: 0))
        
        //this reverts the context properies and the original state is taken off the state
        context!.restoreGState()
        
        //draw the line on top of the clipped gradient
        graphPath.lineWidth = 2.0
        graphPath.stroke()
        
        //GRAPH POINT CIRCLES
        for i in 0..<graphPoints.count {
            var point = CGPoint(x: columnXPoint(i), y: columnYPoint(graphPoints[i]))
            point.x -= 6.0 / 2
            point.y -= 6.0 / 2
            
            let circle = UIBezierPath(ovalIn: CGRect(origin: point, size: CGSize(width: 5.0, height: 5.0)))
            circle.fill()
        }
        
        //HORIZONTAL GRAPH LINES
        let linePath = UIBezierPath()
        
        //top line
        linePath.move(to: CGPoint(x:margin, y: topBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: topBorder))
        
        //center linePath
        linePath.move(to: CGPoint(x: margin, y: graphHeight / 2 + topBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: graphHeight / 2 + topBorder))
        
        //bottom line
        linePath.move(to: (CGPoint(x: margin, y: height - bottomBorder)))
        linePath.addLine(to: CGPoint(x: width - margin, y: height - bottomBorder))
        let color = UIColor(white: 1.0, alpha: 0.3)
            color.setStroke()
        
        linePath.lineWidth = 1.0
        linePath.stroke()
    }

}
