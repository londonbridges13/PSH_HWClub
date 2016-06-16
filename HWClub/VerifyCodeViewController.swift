//
//  VerifyCodeViewController.swift
//  
//
//  Created by Lyndon Samual McKay on 5/24/16.
//
//


import UIKit
import SinchVerification;

class VerifyCodeViewController: UIViewController {
    var verification:Verification?
    
    @IBOutlet weak var codeTX: UITextField!
    
    var PhoneNumber : String?
    
    var theUsername : String?
    var thePassword :String?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        self.codeTX.becomeFirstResponder();
    }
    
    @IBAction func verifyCode(sender: AnyObject) {
        verification?.verify(codeTX.text!, completion: { (success:Bool, error:NSError?) -> Void in
            if (success)
            {
                // Segue to EmaiVC
                print("Successfully Verified")
                self.performSegueWithIdentifier("part4", sender: self)
//                self.navigationController?.popToRootViewControllerAnimated(true)
                
            }
            else
            {
                print("Unable to Verify")
//                display some error message here
                
            }
            
        })
    }
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? EnterEmailVC {
            
            
            vc.theUsername = self.theUsername!
            vc.thePassword = self.thePassword!
            
            
            vc.PhoneNumber = self.PhoneNumber!
        }
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
