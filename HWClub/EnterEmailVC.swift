//
//  EnterEmailVC.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 1/5/16.
//  Copyright © 2016 Lyndon Samual McKay. All rights reserved.
//

import UIKit
import Parse

class EnterEmailVC: UIViewController, UITextFieldDelegate  {

    var theSay : String?
    var theUsername : String?
    var theEmail :String?
    var thePassword :String?

    @IBOutlet var Next: UIButton!
    @IBOutlet var EmailTF : UITextField!
    @IBOutlet var invalidLabel : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(theUsername)
        print(thePassword)
        EmailTF.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func propicfunc()-> PFFile{
        let img = UIImage(named: "dbSWORD")
        let theData = UIImageJPEGRepresentation(img!, 1)
        let bb = PFFile(data: theData!)
        return bb
//        UIImage(named: "dbSWORD")
    }
    
    @IBAction func go(sender: AnyObject) {
        self.Next.sendActionsForControlEvents(.TouchUpInside)
    }
    
    
    @IBAction func checking(sender: AnyObject) {
        if self.EmailTF.text != nil{
            
            if isValidEmail(EmailTF.text!) == true{
                checkForEmail(EmailTF.text!)
            }else{
                print("inValid Email")
                self.invalidLabel.text = "Invalid Email"
                self.invalidLabel.alpha = 1
            }
            

        }
    }
    
    
    
    
    
    
    func isValidEmail(testStr:String) -> Bool {
        // println("validate calendar: \(testStr)")
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
    }
    
    func checkForEmail(textfield : String){
        let cE = PFQuery(className: "_User")
        cE.whereKey("email", equalTo: textfield)
        cE.findObjectsInBackgroundWithBlock { (results:[PFObject]?, error:NSError?) -> Void in
            if error == nil{
                if results?.count == 0{
                    print("your good")
                    self.addUser()
                }else{
                    print("This email has been used")
                    //Already Registered this Email
                    self.invalidLabel.text = "A User is Already Registered this Email"
                    self.invalidLabel.alpha = 1
                }
            }
        }
    }
    
    
    
    
    func addUser(){
        let aU = PFUser()
        aU.username = self.theUsername!
        aU.password = self.thePassword!
        aU["setUP"] = "no"
        aU["email"] = self.EmailTF.text!
        aU["profilePic"] = propicfunc()
        aU.signUpInBackgroundWithBlock { (success:Bool, error:NSError?) -> Void in
            if success == true{
                print("Saved, move on")
                self.excuteSegue()
            }else{
                print(error?.description)
                self.invalidLabel.text = "Bad Internet Connection, Try again later."
                self.invalidLabel.alpha = 1
            }
        }
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        self.Next.sendActionsForControlEvents(.TouchUpInside)
        
        return true
    }
    
    
    func excuteSegue(){
       // performSegueWithIdentifier("yourin", sender: self)
        //save username and password
        
        let clear = SD.deleteTable("Login")
        
        if let _ = SD.createTable("Login", withColumnNamesAndTypes: ["username": .StringVal, "password": .StringVal]){
        }else{
            // Created DataTable
            print("Created Table")
        }
        
        
        if let err = SD.executeChange("INSERT INTO Login (username, password) VALUES ('\(self.theUsername!)', '\(self.thePassword!)')") {
            //there was an error during the insert, handle it here
        } else {
            //no error, the row was inserted successfully
            print("\(self.theUsername!)', '\(self.thePassword!)') is now your username and password!")
            print("GgggggggggGGGGgGGg")

            SignIN()

        }

    }
    
    func SignIN(){
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc: FindSchoolsNAVI = storyboard.instantiateViewControllerWithIdentifier("FindSchools") as! FindSchoolsNAVI
        
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
