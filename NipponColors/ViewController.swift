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
    
    override func loadView() {
        super.loadView()
        initColorData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorCollectionView.dataSource = self
        colorCollectionView.delegate = self
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
        let bgColor = UIColor(red: CGFloat(color.getR())/255.0, green: CGFloat(color.getG())/255.0, blue: CGFloat(color.getB())/255.0, alpha: 1.0).CGColor
        
        let anim = CABasicAnimation(keyPath: "backgroundColor")
        anim.fromValue = view.layer.backgroundColor
        view.layer.backgroundColor = bgColor
        anim.toValue = bgColor
        anim.duration = 1.5
        anim.fillMode = kCAFillModeBoth
        view.layer.addAnimation(anim, forKey: "bgColorAnim")
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1
    }
}


