//
//  findNAVI.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 12/14/15.
//  Copyright © 2015 Lyndon Samual McKay. All rights reserved.
//

import UIKit

class findNAVI: UINavigationController {

    @IBOutlet var navibar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navibar.tintColor = UIColor.whiteColor()
        
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
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
