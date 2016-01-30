//
//  SecondViewController.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 9/24/15.
//  Copyright © 2015 Lyndon Samual McKay. All rights reserved.
//
import Parse
import UIKit

class SecondViewController: UIViewController {
    @IBOutlet var mylabel: UILabel!

    var cUser = PFUser.currentUser()
    override func viewDidLoad() {
        super.viewDidLoad()

        mylabel.text = cUser?.username
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
