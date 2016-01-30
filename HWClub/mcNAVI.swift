//
//  mcNAVI.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 12/19/15.
//  Copyright © 2015 Lyndon Samual McKay. All rights reserved.
//

import UIKit

class mcNAVI: UINavigationController {

    @IBOutlet var navibar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navibar.tintColor = UIColor.whiteColor()
        
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
}
