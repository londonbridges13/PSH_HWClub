//
//  AnnotationViewController.swift
//  Gecco
//
//  Created by yukiasai on 2016/01/19.
//  Copyright (c) 2016 yukiasai. All rights reserved.
//

import UIKit

class AnnotationViewController: SpotlightViewController {
    
    @IBOutlet var annotationViews: [UIView]!
    
    var stepIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
    }
    
    func next(labelAnimated: Bool) {
        updateAnnotationView(labelAnimated)
        
        let screenSize = UIScreen.mainScreen().bounds.size
        switch stepIndex {
        case 0:
//            spotlightView.move(Spotlight.RoundedRect(center: 1, 110), size: CGSizeMake(150, 71), cornerRadius: 6), moveType: .Disappear)
            spotlightView.appear(Spotlight.RoundedRect(center: CGPointMake(78, 100), size: CGSizeMake(150, 61), cornerRadius: 6))
        case 1:
//            spotlightView.move(Spotlight.Oval(center: CGPointMake(screenSize.width - 75, 42), diameter: 50))
            spotlightView.move(Spotlight.RoundedRect(center: CGPointMake(screenSize.width - 56, 88), size: CGSizeMake(120, 40), cornerRadius: 6), moveType: .Disappear)
            // Tap Here to Follow
        case 2:
            //Would you like to Follow this Class
            var FollowAlert = SCLAlertView()
            
            FollowAlert.addButton("Yes, Follow ", action: { () -> Void in
                // Follow
                print("Now Following")
            })
            
            FollowAlert.addButton("No, not my Class", action: { () -> Void in
                // Just Cancel
            })
            
            FollowAlert.showCloseButton = false
            
            FollowAlert.showSuccess("", subTitle: "Would you like to Follow this Class?")
            
            
            spotlightView.move(Spotlight.RoundedRect(center: CGPointMake(0, 0), size: CGSizeMake(0, 0), cornerRadius: 0), moveType: .Disappear)

//            break
        case 3:
            // Part 4, Scroll 'Where the magic Happens'
            
            spotlightView.move(Spotlight.RoundedRect(center: CGPoint(x: screenSize.width / 2, y: screenSize.height), size: CGSize(width: screenSize.width, height: screenSize.height + 60), cornerRadius: 6), moveType: .Disappear)
        case 4:
            // Tap Here to Post
            
            spotlightView.move(Spotlight.RoundedRect(center: CGPoint(x: 100, y: 270), size: CGSizeMake(120, 60), cornerRadius: 6), moveType: .Disappear)
//            spotlightView.move(Spotlight.Oval(center: CGPointMake( screenSize.width / 2, 200), diameter: 220), moveType: .Disappear)
        case 5:
            dismissViewControllerAnimated(true, completion: nil)
        default:
            break
        }
        
        stepIndex += 1
    }
    
    func updateAnnotationView(animated: Bool) {
        annotationViews.enumerate().forEach { index, view in
            UIView .animateWithDuration(animated ? 0.25 : 0) {
                view.alpha = index == self.stepIndex ? 1 : 0
            }
        }
    }
}

extension AnnotationViewController: SpotlightViewControllerDelegate {
    func spotlightViewControllerWillPresent(viewController: SpotlightViewController, animated: Bool) {
        next(false)
    }
    
    func spotlightViewControllerTapped(viewController: SpotlightViewController, isInsideSpotlight: Bool) {
        next(true)
    }
    
    func spotlightViewControllerWillDismiss(viewController: SpotlightViewController, animated: Bool) {
        spotlightView.disappear()
    }
}