//
//  EnterPasswordVC.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 1/5/16.
//  Copyright © 2016 Lyndon Samual McKay. All rights reserved.
//

import UIKit

class EnterPasswordVC: UIViewController, UITextFieldDelegate {

    var theSay : String?
    var theUsername : String?
    var thePassword :String?
    
    
    @IBOutlet var enterLabel: UILabel!
    @IBOutlet var PasswordTF : UITextField!
    @IBOutlet var invalidLabel : UILabel!
    @IBOutlet var Next: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.enterLabel.text = "\(theUsername!), please enter your secure password"
        
        PasswordTF.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func go(sender: AnyObject) {
        self.Next.sendActionsForControlEvents(.TouchUpInside)
    }
    
    
    @IBAction func checking(){
        if PasswordTF?.text!.characters.count >= 6{
            
            
            performSegueWithIdentifier("getNum", sender: self)
//            if PasswordTF.text!.lowercaseString.characters.contains(forbid) {
//                print("word contains \(forbid)")
//                invalidLabel.text = "Password cannot contain ')'"
//                invalidLabel.alpha = 1
//            }else{
//                print("Next")
//                
//            }
            
            
            
        }else{
            print("Password must have at least 6 characters")
            invalidLabel.text = "Password must have at least 6 characters"
            invalidLabel.alpha = 1
        }
    }

    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        self.Next.sendActionsForControlEvents(.TouchUpInside)
        
        return true
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc : EnterCellViewController = segue.destinationViewController as! EnterCellViewController
        
        
        
        self.thePassword = PasswordTF.text!
        vc.theUsername = self.theUsername!
        vc.thePassword = self.thePassword!
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
