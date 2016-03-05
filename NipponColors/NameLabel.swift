//
//  NameLabel.swift
//  NipponColors
//
//  Created by 郭佳哲 on 3/6/16.
//  Copyright © 2016 郭佳哲. All rights reserved.
//

import UIKit
@IBDesignable
public class NameLabel: UIView {
    @IBInspectable
    var nameJA: String = ""
    @IBInspectable
    var nameEN: String = ""
    
    let labelNameJA = UILabel()
    let labelNameEN = UILabel()
    
    public override func drawRect(rect: CGRect) {
        drawNameJA()
    }
    
    func drawNameJA() {
        updateNameJA()
        labelNameJA.textColor = UIColor(white: 1.0, alpha: 0.7)
        labelNameJA.numberOfLines = 0
        self.addSubview(labelNameJA)
    }
    
    func drawNameEN() {
        
    }
    
    func updateNameJA() {
        let fontSize: CGFloat = self.layer.bounds.width * 0.7
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = NSLineBreakMode.ByCharWrapping
        let attributes: [String : AnyObject] = [NSFontAttributeName: UIFont(name: "Helvetica Neue", size: fontSize)!, NSParagraphStyleAttributeName: paragraphStyle]
        let bound = nameJA.boundingRectWithSize(CGSizeMake(fontSize, CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attributes, context: nil)
        labelNameJA.frame = CGRect(x: (self.layer.bounds.width-fontSize)/2, y: 0, width: bound.width, height: bound.height)
        labelNameJA.attributedText = NSAttributedString(string: nameJA, attributes: attributes)
    }
    
    func updateNameEN() {
        
    }
    
    public func updateName(nameEN nameEN: String, nameJA: String) {
        self.nameEN = nameEN
        self.nameJA = nameJA
        updateNameEN()
        updateNameJA()
    }
}
