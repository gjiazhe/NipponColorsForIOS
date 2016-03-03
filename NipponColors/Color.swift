//
//  Color.swift
//  NipponColors
//
//  Created by 郭佳哲 on 2/28/16.
//  Copyright © 2016 郭佳哲. All rights reserved.
//
import Foundation

class Color {
    let id: String
    let nameJA: String
    let nameEN: String
    let rgbCode: String
    let cmyk: String
    
    init(dataSource: [String: String]) {
        id = dataSource["id"]!
        nameJA = dataSource["nameJA"]!
        nameEN = dataSource["nameEN"]!
        rgbCode = dataSource["rgb"]!
        cmyk = dataSource["cmyk"]!
    }
    
    func getR() ->Int {
        let startIndex = rgbCode.startIndex.advancedBy(0)
        let endIndex = rgbCode.startIndex.advancedBy(2)
        let redHexStr = rgbCode.substringWithRange(Range<String.Index>(start: startIndex, end: endIndex))
        var redIntStr: UInt32 = 0
        NSScanner(string: redHexStr).scanHexInt(&redIntStr)
        return Int(redIntStr)
    }
    
    func getG() -> Int {
        let startIndex = rgbCode.startIndex.advancedBy(2)
        let endIndex = rgbCode.startIndex.advancedBy(4)
        let greenHexStr = rgbCode.substringWithRange(Range<String.Index>(start: startIndex, end: endIndex))
        var greenIntStr: UInt32 = 0
        NSScanner(string: greenHexStr).scanHexInt(&greenIntStr)
        return Int(greenIntStr)
    }
    
    func getB() -> Int {
        let startIndex = rgbCode.startIndex.advancedBy(4)
        let endIndex = rgbCode.startIndex.advancedBy(6)
        let blueHexStr = rgbCode.substringWithRange(Range<String.Index>(start: startIndex, end: endIndex))
        var blueIntStr: UInt32 = 0
        NSScanner(string: blueHexStr).scanHexInt(&blueIntStr)
        return Int(blueIntStr)
    }
    
    func getC() -> Int {
        let startIndex = cmyk.startIndex.advancedBy(0)
        let endIndex = cmyk.startIndex.advancedBy(3)
        let cyanStr = cmyk.substringWithRange(Range<String.Index>(start: startIndex, end: endIndex))
        return Int(cyanStr)!
    }
    
    func getM() -> Int {
        let startIndex = cmyk.startIndex.advancedBy(3)
        let endIndex = cmyk.startIndex.advancedBy(6)
        let magentaStr = cmyk.substringWithRange(Range<String.Index>(start: startIndex, end: endIndex))
        return Int(magentaStr)!
    }
    
    func getY() -> Int {
        let startIndex = cmyk.startIndex.advancedBy(6)
        let endIndex = cmyk.startIndex.advancedBy(9)
        let yellowStr = cmyk.substringWithRange(Range<String.Index>(start: startIndex, end: endIndex))
        return Int(yellowStr)!
    }
    
    func getK() -> Int {
        let startIndex = cmyk.startIndex.advancedBy(9)
        let endIndex = cmyk.startIndex.advancedBy(12)
        let blackStr = cmyk.substringWithRange(Range<String.Index>(start: startIndex, end: endIndex))
        return Int(blackStr)!
    }
}