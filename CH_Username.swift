//
//  CH_Username.swift
//  Dac
//
//  Created by Lyndon Samual McKay on 1/19/16.
//  Copyright © 2016 Lyndon Samual McKay. All rights reserved.
//

import UIKit
import Parse

protocol SidebarDelegate {
    func queryNotiis()
    func userInfoQuery()
}


class CH_Username: UIViewController, UITextFieldDelegate {

    @IBOutlet var usernameTX: UITextField! = nil
    @IBOutlet var diko: UIButton!
    
    @IBOutlet var invalidLabel: UILabel!
    let cUser = PFUser.currentUser()
    var theUsername : String?
    
    var theSay : String?
    
    var delegate =  SidebarDelegate?()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTX.delegate = self

        usernameTX.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goChange(sender: AnyObject) {
        
        if usernameTX?.text!.characters.count < 5{
            print("Username is too Short!")
            //Show Short water later
            self.invalidLabel.text = "Username must contain at least 5 letters"
            self.invalidLabel.alpha = 1
            theSay = "no"
            
        }else{
            theSay = "yes"
            
            if theSay == "yes"{
                self.theUsername = self.usernameTX.text
                checkForUsername(theUsername!)
            }else{
                // show INVALID LABEL
                print("Invalid username")
                self.invalidLabel.text = "Sorry, this Username has been taken"
                self.invalidLabel.alpha = 1
                
            }
            
        }

        
    }
    
    func chUserName(){
        if let currentUser = PFUser.currentUser(){
            currentUser.username = self.theUsername!
            //set other fields the same way....
            currentUser.saveInBackground()
            self.sendher()
        }else{
            print("name change error")
        }
    }
    
    
    func checkForUsername(textfield : String){
        print(textfield)
        let uC = PFQuery(className: "_User")
        //var iii = 0
        if theUsername != nil{
            uC.whereKey("username", equalTo: textfield)
            uC.findObjectsInBackgroundWithBlock({ (results : [PFObject]?, error: NSError?) -> Void in
                if error == nil{
                    // self.checker.removeAll()
                    
                    if results!.count > 0{
                        self.cThat()
                    }else{
                        self.chUserName()
                    }
                    
                    
                    
                    
                }
            })
        }
        //sleep(1)
    }

    func cThat(){
        // show that this username is taken
        
    }
    
    
    func sendher(){
        self.theUsername = self.usernameTX.text
        if let delegate = self.delegate{
            delegate.queryNotiis()
            delegate.userInfoQuery()
        }
//        let yy = SidebarViewController()
//        yy.userInfoQuery()
//        yy.viewDidLoad()
        if self.theUsername != nil{
            //diko.sendActionsForControlEvents(.TouchUpInside)
            seggy()
        }
        
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
