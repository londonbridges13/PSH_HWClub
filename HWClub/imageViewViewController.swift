//
//  imageViewViewController.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 10/1/15.
//  Copyright © 2015 Lyndon Samual McKay. All rights reserved.
//

import UIKit
import iAd
class imageViewViewController: UIViewController , UIScrollViewDelegate, ADBannerViewDelegate {
    

    @IBOutlet var adBanner: ADBannerView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var theImageView: UIImageView!
    var theImage: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 6
        
        self.canDisplayBannerAds = true
        self.adBanner.delegate = self
        self.adBanner.hidden = true
        
        
        
        theImageView.image = theImage
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func bannerViewWillLoadAd(banner: ADBannerView!) {
        
        
    }
    
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        
        self.adBanner.hidden = false
    }
    
    func bannerViewActionDidFinish(banner: ADBannerView!) {
        
        
    }
    
    func bannerViewActionShouldBegin(banner: ADBannerView!, willLeaveApplication willLeave: Bool) -> Bool {
        
        return true
        
    }
    
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
        print("No FUCKING ADS")
        
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        
        return self.theImageView
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
