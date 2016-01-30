//
//  loadSETUPVC.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 1/8/16.
//  Copyright © 2016 Lyndon Samual McKay. All rights reserved.
//

import UIKit

class loadSETUPVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        seggy()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func seggy(){
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc: SWRevealViewController = storyboard.instantiateViewControllerWithIdentifier("homeR") as! SWRevealViewController
        self.presentViewController(vc, animated: true, completion: nil)
        
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
