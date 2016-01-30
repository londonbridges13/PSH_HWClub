//
//  FeedbackViewController.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 9/27/15.
//  Copyright © 2015 Lyndon Samual McKay. All rights reserved.
//

import UIKit
import Parse

class FeedbackViewController: UIViewController, UITextViewDelegate {

    
    var uc = PFUser.currentUser()
    
    @IBOutlet var sendFeedback: UIBarButtonItem!
    //@IBOutlet var menuButton: UIBarButtonItem!
    @IBOutlet var feedbackTxTView: UITextView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if self.revealViewController() != nil {
//            menuButton.target = self.revealViewController()
//            menuButton.action = "revealToggle:"
//            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
//            
//            // Uncomment to change the width of menu
//            //   self.revealViewController().rearViewRevealWidth = 200
//        }
//        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func sendit(sender: AnyObject) {
        if feedbackTxTView.text != ""{
            let feedback = PFObject(className: "Feedback")
        
            feedback["feedback"] = feedbackTxTView.text
            
            feedback["username"] = uc!.username!
            
            feedback.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
                
                if (success == true){
                    print("sent \(self.feedbackTxTView.text)")
                }
            })
            
            feedbackTxTView.text = nil
            feedbackTxTView.endEditing(true)
        }
        
        let aa = SCLAlertView()
        aa.showSuccess("Sent", subTitle: "Thank you for the feedback")
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
