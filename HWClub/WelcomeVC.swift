//
//  WelcomeVC.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 1/3/16.
//  Copyright © 2016 Lyndon Samual McKay. All rights reserved.
//
import Darwin
import UIKit
import Parse

class WelcomeVC: UIViewController, UITextFieldDelegate {

    @IBOutlet var LoginButton: UIButton!
    @IBOutlet var SignUpButton: UIButton!
    @IBOutlet var letsGoButton: UIButton!
    @IBOutlet var CancelButton: UIButton!
    
    @IBOutlet weak var eUU: UITextField!
    @IBOutlet weak var ePP: UITextField!
    @IBOutlet var invalidLabel : UILabel!
    
    var greeny = UIColor(red: 49/255, green: 175/255, blue: 112/255, alpha: 1)
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//        LoginButton.layer.shadowRadius = 5
//        LoginButton.layer.shadowOpacity = 0.7
//        LoginButton.layer.shadowOffset = CGSizeMake(5, 5)
//      //  LoginButton.layer.shadowColor = UIColor.blackColor().CGColor
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        eUU.delegate = self
        ePP.delegate = self
        
        
        LoginButton.layer.cornerRadius = 13
        LoginButton.layer.borderColor = UIColor.whiteColor().CGColor
        LoginButton.layer.borderWidth = 1
        LoginButton.layer.shadowRadius = 1.5
        LoginButton.layer.shadowOpacity = 0.5
        LoginButton.layer.shadowOffset = CGSizeMake(0, 1)
        LoginButton.layer.shadowColor = UIColor.blackColor().CGColor
        //LoginButton.layer.masksToBounds = true

        SignUpButton.layer.cornerRadius = 13
        SignUpButton.layer.borderColor = UIColor.whiteColor().CGColor
        SignUpButton.layer.borderWidth = 1
        SignUpButton.layer.shadowRadius = 1.5
        SignUpButton.layer.shadowOpacity = 0.5
        SignUpButton.layer.shadowOffset = CGSizeMake(0, 1)
        SignUpButton.layer.shadowColor = UIColor.blackColor().CGColor
        
        letsGoButton.layer.cornerRadius = 13
        letsGoButton.layer.borderColor = UIColor.whiteColor().CGColor
        letsGoButton.layer.borderWidth = 1
        letsGoButton.layer.shadowRadius = 1.5
        letsGoButton.layer.shadowOpacity = 0.5
        letsGoButton.layer.shadowOffset = CGSizeMake(0, 1)
        letsGoButton.layer.shadowColor = UIColor.blackColor().CGColor
        
        CancelButton.layer.cornerRadius = 13
        CancelButton.layer.borderColor = UIColor.whiteColor().CGColor
        CancelButton.layer.borderWidth = 1
        CancelButton.layer.shadowRadius = 1.5
        CancelButton.layer.shadowOpacity = 0.5
        CancelButton.layer.shadowOffset = CGSizeMake(0, 1)
        CancelButton.layer.shadowColor = UIColor.blackColor().CGColor


        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        self.ePP.resignFirstResponder()
        self.eUU.resignFirstResponder()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func unwindSegueWELCOME(segue: UIStoryboardSegue){
        
    }
    
    
    
    

    @IBAction func CancelIt(sender: AnyObject) {
        self.ePP.fadeOut()
        self.eUU.fadeOut()
        self.CancelButton.alpha = 0
        self.letsGoButton.alpha = 0
        self.LoginButton.fadeIn()
        self.SignUpButton.fadeIn()
        
    }
    @IBAction func LetsGo(sender: AnyObject) {
        
        let user = PFUser()
        user.username = self.eUU.text!
        user.password = self.ePP.text!
        
        PFUser.logInWithUsernameInBackground(user.username!, password: user.password!) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                // Do stuff after successful login.
                print("Successfully Logged in")

                //SQL
                _ = SD.deleteTable("Login")
                
                if let _ = SD.createTable("Login", withColumnNamesAndTypes: ["username": .StringVal, "password": .StringVal]){
                }else{
                    // Created DataTable
                    print("Created Table")
                }
                
                
                if let _ = SD.executeChange("INSERT INTO Login (username, password) VALUES ('\(self.eUU.text!)', '\(self.ePP.text!)')") {
                    //there was an error during the insert, handle it here
                } else {
                    //no error, the row was inserted successfully
                    print("GgggggggggGGGGgGGg")
                }
                //End
                
                
                self.Verify()
            } else {
                print("Invalid User/Password")
                self.invalidLabel.fadeIn()
                // The login failed. Check error to see why.
            }
        }
    }
    @IBAction func SignUP(sender: AnyObject) {
    }
    @IBAction func Login(sender: AnyObject) {
       // let alert = SCLAlertView()
       // let eUU = alert.addTextField("Username")
        //let ePP = alert.addSecureTextField("Password")
     //   alert.addButton("Login") { () -> Void in
            // Search Parse for this name and password

            self.ePP.fadeIn()
            self.eUU.fadeIn()
            self.CancelButton.fadeIn()
            self.letsGoButton.fadeIn()
            self.LoginButton.alpha = 0
            self.SignUpButton.alpha = 0
            eUU.becomeFirstResponder()

        
            let user = PFUser()
            user.username = self.eUU.text!
            user.password = self.ePP.text!
            
            PFUser.logInWithUsernameInBackground(user.username!, password: user.password!) {
                (user: PFUser?, error: NSError?) -> Void in
                if user != nil {
                    // Do stuff after successful login.
                    print("Successfully Logged in")
                    //SQL
                    let clear = SD.deleteTable("Login")

                    if let _ = SD.createTable("Login", withColumnNamesAndTypes: ["username": .StringVal, "password": .StringVal]){
                    }else{
                        // Created DataTable
                        print("Created Table")
                    }
                

                    if let err = SD.executeChange("INSERT INTO Login (username, password) VALUES ('\(self.eUU.text!)', '\(self.ePP.text!)')") {
                        //there was an error during the insert, handle it here
                    } else {
                        //no error, the row was inserted successfully
                        print("GgggggggggGGGGgGGg")
                    }
                    //End
                    
                    self.Verify()
                } else {
                    // The login failed. Check error to see why.
                }
            }
            
        //}
//        alert.addButton("Cancel", action: { () -> Void in
//            print("Cancel")
//        })
        
//        alert.showCloseButton = false
        
       // alert.showInfo("Login", subTitle: "Enter your Username and Password")
        
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if textField == eUU{
            ePP.becomeFirstResponder()
        }else {
            ePP.resignFirstResponder()
            ePP.endEditing(true)
        }
        return true

    }
    
    func sleeper(){
        sleep(1)
    }
    
    func Verify(){
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

extension UIView {
    func fadeIn() {
        // Move our fade out code from earlier
        UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.alpha = 1.0 // Instead of a specific instance of, say, birdTypeLabel, we simply set [thisInstance] (ie, self)'s alpha
            }, completion: nil)
    }
    
    func fadeOut() {
        UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.alpha = 0.0
            }, completion: nil)
    }
}
