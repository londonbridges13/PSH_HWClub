//
//  noIMGViewController.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 10/3/15.
//  Copyright © 2015 Lyndon Samual McKay. All rights reserved.
//

import UIKit

class noIMGViewController: UIViewController {

    @IBOutlet var mylabel: UILabel!
    var theAnswer : String?
    override func viewDidLoad() {
        super.viewDidLoad()

        mylabel.text = theAnswer
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
