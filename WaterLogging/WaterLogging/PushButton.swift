//
//  PushButton.swift
//  WaterLogging
//
//  Created by Ramya on 7/3/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class PushButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    var fillColor : UIColor = .systemTeal
    private struct Constants {
        static let plusLineWidth: CGFloat = 3.0
        static let plusButtonScale: CGFloat = 0.6
        static let halfPointShift: CGFloat = 0.5
    }

    private var halfWidth: CGFloat {
      return bounds.width / 2
    }

    private var halfHeight: CGFloat {
      return bounds.height / 2
    }

    // half width and half height bring you to the center of the button

    override func draw(_ rect: CGRect) {
      let path = UIBezierPath(ovalIn: rect)
      fillColor.setFill()
      path.fill()

    // The horizontal and vertical line intersect in the middle of the button.
    // The lenght of the lines is 1/2 the minimum height or width times a constant.
    // The constant allows us adjust the size of the plus sign.
    let plusWidth = min(bounds.width, bounds.height) * Constants.plusButtonScale
    let halfPlusWidth = plusWidth / 2

    let plusPath = UIBezierPath()
    plusPath.lineWidth = Constants.plusLineWidth

    // Move initial point to left most point of the horizontal line
    plusPath.move(to: CGPoint(
      x: halfWidth - halfPlusWidth,
      y: halfHeight))

    //Add a point to the path at the end of the stroke
    plusPath.addLine(to: CGPoint(
      x: halfWidth + halfPlusWidth,
      y: halfHeight))

    plusPath.move(to: CGPoint(x:halfWidth , y: halfHeight + halfPlusWidth))

    plusPath.addLine(to: CGPoint(x:halfWidth, y:halfHeight - halfPlusWidth))

    //set the stroke color
    UIColor.white.setStroke()
    //draw the stroke
    plusPath.stroke()

    }

}
