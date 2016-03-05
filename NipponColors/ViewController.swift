//
//  ViewController.swift
//  NipponColors
//
//  Created by 郭佳哲 on 2/27/16.
//  Copyright © 2016 郭佳哲. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var colorCollectionView: UICollectionView!
    var colors = [Color]()
    
    @IBOutlet weak var cRing: CmykRing!
    @IBOutlet weak var mRing: CmykRing!
    @IBOutlet weak var yRing: CmykRing!
    @IBOutlet weak var kRing: CmykRing!
    
    @IBOutlet weak var rLabel: AnimNumLabel!
    @IBOutlet weak var gLabel: AnimNumLabel!
    @IBOutlet weak var bLabel: AnimNumLabel!
    
    
    override func loadView() {
        super.loadView()
        initColorData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorCollectionView.dataSource = self
        colorCollectionView.delegate = self
        colorCollectionView.showsVerticalScrollIndicator = false
    }
    
    func initColorData() {
        let filePath = NSBundle.mainBundle().pathForResource("ColorsData", ofType: "json")
        let data =  NSData(contentsOfFile: filePath!)
        if let jsonData = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! [[String: String]] {
            for value in jsonData {
                //print("\(value)")
                colors.append(Color(dataSource: value))
            }
        }
    }
    
    let animDuration: CFTimeInterval = 1
    
    func bgColorAnimateTo(color: Color) {
        let newBgColor = UIColor(red: CGFloat(color.getR())/255.0, green: CGFloat(color.getG())/255.0, blue: CGFloat(color.getB())/255.0, alpha: 1.0).CGColor
        
        let anim = CABasicAnimation(keyPath: "backgroundColor")
        anim.fromValue = (view.layer.presentationLayer() as! CALayer).backgroundColor
        anim.toValue = newBgColor
        anim.duration = animDuration
        view.layer.backgroundColor = newBgColor
        view.layer.addAnimation(anim, forKey: "bgColorAnim")
    }
    
    func cmykRingsAnimTo(color:Color) {
        cRing.animateTo(color.getC(), withDuration: animDuration)
        mRing.animateTo(color.getM(), withDuration: animDuration)
        yRing.animateTo(color.getY(), withDuration: animDuration)
        kRing.animateTo(color.getK(), withDuration: animDuration)
    }
    
    func rgbLabelsAnimTo(color:Color) {
        rLabel.animTo(color.getR(), withDuration: animDuration)
        gLabel.animTo(color.getG(), withDuration: animDuration)
        bLabel.animTo(color.getB(), withDuration: animDuration)
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ColorCell", forIndexPath: indexPath) as! ColorCell
        cell.color = colors[indexPath.row]
        cell.updateUI()
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let color = colors[indexPath.row]
        
        bgColorAnimateTo(color)
        cmykRingsAnimTo(color)
        rgbLabelsAnimTo(color)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1
    }
}
