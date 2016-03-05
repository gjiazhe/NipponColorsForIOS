//
//  AnimNumLabel.swift
//  NipponColors
//
//  Created by 郭佳哲 on 3/5/16.
//  Copyright © 2016 郭佳哲. All rights reserved.
//

import UIKit
public class AnimNumLabel: UILabel {
    var timer = NSTimer()
    var newValue = 0
    
    func animTo(newValue: Int, withDuration duration:CFTimeInterval) {
        if Int(self.text!)! == newValue {
            return
        }
        self.newValue = newValue
        timer = NSTimer.scheduledTimerWithTimeInterval(duration/Double(abs(newValue-Int(self.text!)!)), target: self, selector: "updateText", userInfo: nil, repeats: true)
    }
    
    func updateText() {
        if Int(self.text!)! == newValue {
            timer.invalidate()
            return
        }
        
        var oldValue = Int(self.text!)!
        if oldValue > newValue {
            oldValue--
        } else {
            oldValue++
        }
        
        self.text = "\(oldValue)"
    }
}
