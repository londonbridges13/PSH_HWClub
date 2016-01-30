//
//  LoadingViewController.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 9/27/15.
//  Copyright © 2015 Lyndon Samual McKay. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {

    
    var THold : String?
    var CHold : String?
    
    @IBOutlet var actIndi: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()

        print("")
        print(CHold)
        print(THold)
        
        actIndi.startAnimating()
        Loading()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let vc : AssignmentsTableViewController = segue.destinationViewController as! AssignmentsTableViewController
        
        vc.theClass = CHold
        vc.theTeacher = THold
    }

    func Loading(){
        
        actIndi.startAnimating()
        _ = NSTimer.scheduledTimerWithTimeInterval(2.3, target: self, selector: "ggg", userInfo: nil, repeats: false)
        
        
        
    }
    
    func ggg(){
        
        func Verify(){
            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
            let vc: FindClassViewController = storyboard.instantiateViewControllerWithIdentifier("navi") as! FindClassViewController
            
            
          //  vc.theClass = CHold
          //  vc.theTeacher = THold
            self.presentViewController(vc, animated: true, completion: nil)
            
        }
        Verify()
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
