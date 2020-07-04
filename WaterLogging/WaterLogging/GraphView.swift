//
//  GraphView.swift
//  WaterLogging
//
//  Created by Ramya on 7/3/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class GraphView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var startColor: UIColor = .blue
    var endColor: UIColor = .systemTeal
    //Weekly sample data
    var graphPoints = [4, 2, 6, 4, 5, 8, 3]

      override func draw(_ rect: CGRect) {
        
        drawGradient(rect: rect)
        drawGraphLine(rect: rect)
      
      }

    func drawGradient(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        let colors = [startColor.cgColor, endColor.cgColor]
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let colorLocations: [CGFloat] = [0.0, 1.0]
        
        let gradient = CGGradient(colorsSpace: colorSpace,
                                       colors: colors as CFArray,
                                    locations: colorLocations)!

        let startPoint = CGPoint.zero
        let endPoint = CGPoint(x: 0, y: bounds.height)
        context.drawLinearGradient(gradient,
                            start: startPoint,
                              end: endPoint,
                          options: [])
    }

    func drawGraphLine(rect: CGRect) {
        let width = rect.width
        let height = rect.height
        let graphWidth = width - 20 * 2 // leaving a margin of 20 points on left and right
        let columnXPoint = { (column: Int) -> CGFloat in
          //Calculate the gap between points
          let spacing = graphWidth / CGFloat(self.graphPoints.count - 1)
          return CGFloat(column) * spacing + 20
        }
        
        let graphHeight = height - 40 * 2 // leaving a margin of 40 points on top and bottom
        let maxValue = graphPoints.max()!
        let columnYPoint = { (graphPoint: Int) -> CGFloat in
          let y = CGFloat(graphPoint) / CGFloat(maxValue) * graphHeight
          return graphHeight + 40 - y // Flip the graph
        }
        
        UIColor.white.setFill()
        UIColor.white.setStroke()
            
        let graphPath = UIBezierPath()
        // move to starting point
        let startingPoint = CGPoint(x: columnXPoint(0), y: columnYPoint(graphPoints[0]))
        graphPath.move(to: startingPoint )
        
        // draw a circle on the starting point
        drawSmallCircle(point: startingPoint)


        // draw line to next point and draw a circle there
        for i in 1...(graphPoints.count-1) {
            let next = CGPoint(x: columnXPoint(i), y: columnYPoint(graphPoints[i]))
            graphPath.addLine(to: next)
            drawSmallCircle(point: next)
        }
        graphPath.stroke()
    }
    
    func drawSmallCircle(point: CGPoint) {
        let circle = UIBezierPath(ovalIn: CGRect(origin: CGPoint(x: point.x - 3, y: point.y - 3), size: CGSize(width: 5, height: 5)))
        circle.fill()
    }

}
