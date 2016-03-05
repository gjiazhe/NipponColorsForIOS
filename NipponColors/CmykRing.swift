//
//  CmykRing.swift
//  NipponColors
//
//  Created by 郭佳哲 on 3/4/16.
//  Copyright © 2016 郭佳哲. All rights reserved.
//

import UIKit

@IBDesignable
public class CmykRing: UIView {
    //Type of cmyk
    @IBInspectable
    var type: String = "C"
    //Value of cmyk
    @IBInspectable
    var value: Int = 0
    
    let ring = CAShapeLayer()
    let valueLabel = AnimNumLabel()
    
    override public func drawRect(rect: CGRect) {
        let pathWidth: CGFloat = 2
        let centerX: CGFloat = self.layer.frame.size.width/2
        let centerY: CGFloat = self.layer.frame.size.height/2
        let radius = (centerX<centerY) ? (centerX-pathWidth/2) : (centerY-pathWidth/2)
        
        //Background of Ring
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, pathWidth)
        CGContextSetRGBStrokeColor(context, 1, 1, 1, 0.7)
        CGContextAddArc(context, centerX, centerY, radius, 0, CGFloat(2 * M_PI), 0)
        CGContextStrokePath(context)
        //Ring
        let path = UIBezierPath(arcCenter: CGPoint(x: centerX, y: centerY), radius: radius, startAngle: -CGFloat(M_PI/2), endAngle: -CGFloat(M_PI/2) + CGFloat(M_PI*2), clockwise: true)
        ring.fillColor = UIColor.clearColor().CGColor
        ring.lineWidth = pathWidth
        ring.path = path.CGPath
        ring.strokeEnd = CGFloat(value)/100
        switch type {
            case "C":
                valueLabel.textColor = UIColor(red: 0, green: 147/255, blue: 211/255, alpha: 1)
                ring.strokeColor = valueLabel.textColor.CGColor
            case "M":
                valueLabel.textColor = UIColor(red: 204/255, green: 0, blue: 107/255, alpha: 1)
                ring.strokeColor = valueLabel.textColor.CGColor
            case "Y":
                valueLabel.textColor = UIColor(red: 1, green: 241/255, blue: 12/255, alpha: 1)
                ring.strokeColor = valueLabel.textColor.CGColor
            case "K":
                valueLabel.textColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
                ring.strokeColor = valueLabel.textColor.CGColor
            default :
                valueLabel.textColor = UIColor(red: 0, green: 147/255, blue: 211/255, alpha: 1)
                ring.strokeColor = valueLabel.textColor.CGColor
        }
        self.layer.addSublayer(ring)
        
        //valueLabel
        let fontSize: CGFloat = (centerX<centerY) ? (self.layer.frame.size.width/2.5) : (self.layer.frame.size.height/2.5)
        valueLabel.frame.size.width = self.layer.frame.size.width
        valueLabel.frame.size.height = fontSize
        valueLabel.text = "\(value)"
        valueLabel.font = UIFont(name: "Helvetica Neue", size: fontSize)
        valueLabel.layer.position = CGPoint(x: centerX, y: centerY)
        valueLabel.textAlignment = NSTextAlignment.Center
        self.addSubview(valueLabel)
    }
    
    var timer = NSTimer()
    var newValue = 0
    public func animateTo(newValue: Int, withDuration duration: CFTimeInterval) {
        animateRingTo(newValue, withDuration: duration)
        valueLabel.animTo(newValue, withDuration: duration)
    }
    
    func animateRingTo(newValue: Int, withDuration: CFTimeInterval) {
        let anim = CABasicAnimation(keyPath: "strokeEnd")
        anim.fromValue = ring.presentationLayer()?.strokeEnd
        anim.toValue = CGFloat(newValue)/100
        anim.duration = 1.5
        self.value = newValue
        ring.strokeEnd = CGFloat(newValue)/100
        ring.addAnimation(anim, forKey: "ringAnim")
    }
}