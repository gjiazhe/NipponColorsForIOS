//
//  ColorCell.swift
//  NipponColors
//
//  Created by 郭佳哲 on 2/28/16.
//  Copyright © 2016 郭佳哲. All rights reserved.
//

import UIKit

@IBDesignable
public class ColorCell: UICollectionViewCell {
    var color: Color = Color(dataSource: ["id":"001", "nameJA":"撫子", "nameEN":"NADESHIKO", "rgb":"DC9FB4", "cmyk":"002043003000"])    //init color for test UI in storyboard
    
    let cellWidth:CGFloat = 54
    
    let colorLayer = CALayer()
    let labelId = UILabel()
    let labelNameEN = UILabel()
    let labelRGB = UILabel()
    let labelNameJA = UILabel()
    let CRing = CAShapeLayer()
    let MRing = CAShapeLayer()
    let YRing = CAShapeLayer()
    let KRing = CAShapeLayer()
    let RLine = CAShapeLayer()
    let GLine = CAShapeLayer()
    let BLine = CAShapeLayer()

    override public func drawRect(rect: CGRect) {
        super.drawRect(rect)
        drawUI()
    }
    
    public func drawUI() {
        drawCmykRings()
        drawRGBLines()
        drawRGBCode()
        drawColorLayer()
        drawId()
        drawNameEN()
        drawNameJA()
    }
    
    public func updateUI() {
        setColorLayerBg()
        labelRGB.text = "#\(color.rgbCode)"
        labelNameEN.text = color.nameEN
        updateId()
        updateNameJA()
        updateCmykRings()
        updateRGBLines()
    }
    
    func drawColorLayer() {
        colorLayer.position = CGPoint(x: cellWidth/2, y: 4)
        colorLayer.bounds = CGRect(x: 0, y: 0, width: self.cellWidth, height: 10)
        self.layer.addSublayer(colorLayer)
    }
    
    func setColorLayerBg() {
        colorLayer.backgroundColor = UIColor(red: CGFloat(color.getR())/255.0, green: CGFloat(color.getG())/255.0, blue: CGFloat(color.getB())/255.0, alpha: 1.0).CGColor
    }
    
    func drawCmykRings() {
        //Background of Rings
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 8)
        CGContextSetRGBStrokeColor(context, 1, 1, 1, 0.7)
        for i in 0...3 {
            CGContextAddArc(context, 18, CGFloat(33+40*i), 12, 0, CGFloat(2 * M_PI), 0)
            CGContextStrokePath(context)
        }
        
        //CRing
        var path = UIBezierPath(arcCenter: CGPoint(x: 18, y: 33), radius: 12, startAngle: -CGFloat(M_PI / 2), endAngle: -CGFloat(M_PI / 2) + CGFloat(2*M_PI*Double(color.getC())/100), clockwise: true)
        CRing.strokeColor = UIColor(white: 1.0, alpha: 1.0).CGColor
        CRing.fillColor = UIColor.clearColor().CGColor
        CRing.lineWidth = 8
        CRing.path = path.CGPath
        self.layer.addSublayer(CRing)
        //MRing
        path = UIBezierPath(arcCenter: CGPoint(x: 18, y: 73), radius: 12, startAngle: -CGFloat(M_PI / 2), endAngle: -CGFloat(M_PI / 2) + CGFloat(2*M_PI*Double(color.getM())/100), clockwise: true)
        MRing.strokeColor = UIColor(white: 1.0, alpha: 1.0).CGColor
        MRing.fillColor = UIColor.clearColor().CGColor
        MRing.lineWidth = 8
        MRing.path = path.CGPath
        self.layer.addSublayer(MRing)
        //YRing
        path = UIBezierPath(arcCenter: CGPoint(x: 18, y: 113), radius: 12, startAngle: -CGFloat(M_PI / 2), endAngle: -CGFloat(M_PI / 2) + CGFloat(2*M_PI*Double(color.getY())/100), clockwise: true)
        YRing.strokeColor = UIColor(white: 1.0, alpha: 1.0).CGColor
        YRing.fillColor = UIColor.clearColor().CGColor
        YRing.lineWidth = 8
        YRing.path = path.CGPath
        self.layer.addSublayer(YRing)
        //KRing
        path = UIBezierPath(arcCenter: CGPoint(x: 18, y: 153), radius: 12, startAngle: -CGFloat(M_PI / 2), endAngle: -CGFloat(M_PI / 2) + CGFloat(2*M_PI*Double(color.getK())/100), clockwise: true)
        KRing.strokeColor = UIColor(white: 1.0, alpha: 1.0).CGColor
        KRing.fillColor = UIColor.clearColor().CGColor
        KRing.lineWidth = 8
        KRing.path = path.CGPath
        self.layer.addSublayer(KRing)
    }
    
    func updateCmykRings() {
        var path = UIBezierPath(arcCenter: CGPoint(x: 18, y: 33), radius: 12, startAngle: -CGFloat(M_PI / 2), endAngle: -CGFloat(M_PI / 2) + CGFloat(2*M_PI*Double(color.getC())/100), clockwise: true)
        CRing.path = path.CGPath
        
        path = UIBezierPath(arcCenter: CGPoint(x: 18, y: 73), radius: 12, startAngle: -CGFloat(M_PI / 2), endAngle: -CGFloat(M_PI / 2) + CGFloat(2*M_PI*Double(color.getM())/100), clockwise: true)
        MRing.path = path.CGPath
        
        path = UIBezierPath(arcCenter: CGPoint(x: 18, y: 113), radius: 12, startAngle: -CGFloat(M_PI / 2), endAngle: -CGFloat(M_PI / 2) + CGFloat(2*M_PI*Double(color.getY())/100), clockwise: true)
        YRing.path = path.CGPath
        
        path = UIBezierPath(arcCenter: CGPoint(x: 18, y: 153), radius: 12, startAngle: -CGFloat(M_PI / 2), endAngle: -CGFloat(M_PI / 2) + CGFloat(2*M_PI*Double(color.getK())/100), clockwise: true)
        KRing.path = path.CGPath
    }
    
    func drawRGBLines() {
        //Background of Lines
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 2)
        CGContextSetRGBStrokeColor(context, 1, 1, 1, 0.7)
        for i in 0...2 {
            CGContextAddLines(context, [CGPoint(x: 22+5*i, y: 180), CGPoint(x: 22+5*i, y: 360)], 2)
            CGContextStrokePath(context)
        }
        
        //RLine
        let linePath = UIBezierPath()
        linePath.moveToPoint(CGPoint(x: 32, y: 180))
        linePath.addLineToPoint(CGPoint(x: 32, y: 180+180*color.getR()/255))
        linePath.closePath()
        RLine.strokeColor = UIColor(white: 1.0, alpha: 1.0).CGColor
        RLine.lineWidth = 2.0
        RLine.path = linePath.CGPath
        self.layer.addSublayer(RLine)
        
        //GLine
        linePath.moveToPoint(CGPoint(x: 27, y: 180))
        linePath.addLineToPoint(CGPoint(x: 27, y: 180+180*color.getG()/255))
        linePath.closePath()
        GLine.strokeColor = UIColor(white: 1.0, alpha: 1.0).CGColor
        GLine.lineWidth = 2.0
        GLine.path = linePath.CGPath
        self.layer.addSublayer(GLine)
        
        //BLine
        linePath.moveToPoint(CGPoint(x: 22, y: 180))
        linePath.addLineToPoint(CGPoint(x: 22, y: 180+180*color.getB()/255))
        linePath.closePath()
        BLine.strokeColor = UIColor(white: 1.0, alpha: 1.0).CGColor
        BLine.lineWidth = 2.0
        BLine.path = linePath.CGPath
        self.layer.addSublayer(BLine)
    }
    
    func updateRGBLines() {
        let linePath = UIBezierPath()
        linePath.moveToPoint(CGPoint(x: 32, y: 180))
        linePath.addLineToPoint(CGPoint(x: 32, y: 180+180*color.getR()/255))
        linePath.closePath()
        RLine.path = linePath.CGPath
        
        linePath.moveToPoint(CGPoint(x: 27, y: 180))
        linePath.addLineToPoint(CGPoint(x: 27, y: 180+180*color.getG()/255))
        linePath.closePath()
        GLine.path = linePath.CGPath
        
        linePath.moveToPoint(CGPoint(x: 22, y: 180))
        linePath.addLineToPoint(CGPoint(x: 22, y: 180+180*color.getB()/255))
        linePath.closePath()
        BLine.path = linePath.CGPath
    }
    
    func drawRGBCode() {
        let fontSize: CGFloat = 12
        labelRGB.frame.size.width = 55
        labelRGB.frame.size.height = fontSize
        labelRGB.text = "#\(color.rgbCode)"
        labelRGB.textColor = UIColor(white: 1.0, alpha: 0.7)
        labelRGB.font = UIFont(name: "Helvetica Neue", size: fontSize)
        labelRGB.layer.anchorPoint = CGPoint(x: 0, y: 1)
        labelRGB.layer.position = CGPoint(x: 4, y: 180)
        labelRGB.transform = CGAffineTransformMakeRotation(CGFloat(M_PI / 2))
        self.addSubview(labelRGB)
    }
    
    func drawId() {
        let fontSize: CGFloat = 10
        labelId.frame.size.width = 25
        labelId.frame.size.height = fontSize
        labelId.font = UIFont(name: "Helvetica Neue", size: fontSize)
        labelId.layer.anchorPoint = CGPoint(x: 0, y: 0)
        labelId.layer.position = CGPoint(x: self.cellWidth-4, y: 20)
        labelId.transform = CGAffineTransformMakeRotation(CGFloat(M_PI / 2))
        updateId()
        self.addSubview(labelId)
    }
    
    func updateId() {
        labelId.text = color.id
        labelId.textColor = UIColor(red: CGFloat(color.getR())/255.0, green: CGFloat(color.getG())/255.0, blue: CGFloat(color.getB())/255.0, alpha: 0.7)
    }
    
    func drawNameEN() {
        let fontSize: CGFloat = 12
        let rightPadding: CGFloat = 4
        labelNameEN.frame.size.width = 200
        labelNameEN.frame.size.height = fontSize
        labelNameEN.textColor = UIColor(white: 1.0, alpha: 0.7)
        labelNameEN.text = color.nameEN
        labelNameEN.font = UIFont(name: "Helvetica Neue", size: fontSize)
        labelNameEN.layer.anchorPoint = CGPoint(x: 0, y: 1)
        labelNameEN.layer.position = CGPoint(x: self.cellWidth-fontSize-rightPadding, y: 180)
        labelNameEN.transform = CGAffineTransformMakeRotation(CGFloat(M_PI / 2))
        self.addSubview(labelNameEN)
    }
    
    func drawNameJA() {
        updateNameJA()
        labelNameJA.textColor = UIColor(white: 1.0, alpha: 0.7)
        labelNameJA.numberOfLines = 0
        self.addSubview(labelNameJA)
    }
    
    func updateNameJA() {
        let fontSize: CGFloat = 12
        let rightPadding: CGFloat = 4
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = NSLineBreakMode.ByCharWrapping
        let attributes: [String : AnyObject] = [NSFontAttributeName: UIFont(name: "PingFang SC", size: fontSize)!, NSParagraphStyleAttributeName: paragraphStyle]
        let bound = color.nameJA.boundingRectWithSize(CGSizeMake(fontSize, CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attributes, context: nil)
        labelNameJA.frame = CGRect(x: self.cellWidth - CGRectGetWidth(bound)-rightPadding, y: 170 - CGRectGetHeight(bound), width: CGRectGetWidth(bound), height: CGRectGetHeight(bound))
        labelNameJA.attributedText = NSAttributedString(string: color.nameJA, attributes: attributes)
    }
}
