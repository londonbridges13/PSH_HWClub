//
//  ViewController.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 9/23/15.
//  Copyright © 2015 Lyndon Samual McKay. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    
    var veko = "String?"
    var login : Bool?
    
    var localPW : String?
    var localUser : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let testObject = PFObject(className: "TestObject")
        //testObject["foo"] = "bar"
        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            print("Object has been saved.")
            self.uso()
        }


        //self.Verify()

        
        create()
        
    //
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            // do some task
            print("thread 2")
            dispatch_async(dispatch_get_main_queue(), {
                // update some UI
                });
            });
        //
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    

    // Creating Database
    func create(){
        
        if let _ = SD.createTable("Login", withColumnNamesAndTypes: ["username": .StringVal, "password": .StringVal]){
    }else{
            // Created DataTable
            print("Created Table")
        }
    }
    // End Creation
    
    
    
    func autoLogin(){
        let (resultSet, err) = SD.executeQuery("SELECT * FROM Login")
        
        if err != nil {
            //there was an error during the query, handle it here
        } else {
            for row in resultSet {
                if let name = row["username"]?.asString() {
                    print("The City name is: \(name)")
                    self.localUser = name
                }
                if let pass = row["password"]?.asString() {
                    print("The City name is: \(pass)")
                    self.localPW = pass
                }
                
            }
        }
    }
    
    func uso(){

//Start autoLogin
        let (resultSet, err) = SD.executeQuery("SELECT * FROM Login")
        
        if err != nil {
            //there was an error during the query, handle it here
            print("issue")
        } else {
            for row in resultSet {
                if let name = row["username"]?.asString() {
                    print("The Username is: \(name)")
                    self.localUser = name
                }
                if let pass = row["password"]?.asString() {
                    print("The Password is: \(pass)")
                    self.localPW = pass
                }
                
            }
        }
//End autoLogin
        
        
        let ckUser = PFUser.currentUser()
        //User Verification                 change password
        if self.localUser != nil{
            if self.localPW != nil{
                PFUser.logInWithUsernameInBackground(self.localUser!, password: self.localPW!) { (user:PFUser?, error:NSError?) -> Void in
                    if user != nil{
                        print("Logged IN")
                        // Go from HERE
                        //self.Verify()                     THIS WAS HERE BEFORE VERIFY()
                        self.setUpCheckUP(self.localUser!)
                    }else{
                        self.SignIN()
                    }
                }

            }
        }else{
            print("No current user")
            self.SignIN()
        }
  }
    
    
    
    
//    
//    @IBAction func Login(sender: AnyObject) {
//        let alert = SCLAlertView()
//        let eUU = alert.addTextField("Username")
//        let ePP = alert.addSecureTextField("Password")
//        alert.addButton("Login") { () -> Void in
//            // Search Parse for this name and password
//            
//            let user = PFUser()
//            user.username = eUU.text!
//            user.password = ePP.text!
//            
//            PFUser.logInWithUsernameInBackground(user.username!, password: user.password!) {
//                (user: PFUser?, error: NSError?) -> Void in
//                if user != nil {
//                    // Do stuff after successful login.
//                    print("Successfully Logged in")
//                    //SQL
//                    if let clear = SD.executeChange("DELETE * FROM Login") {
//                        //there was an error during the insert, handle it here
//                    } else {
//                        print("Cleared")
//                    }
//                    if let err = SD.executeChange("INSERT INTO Login (username, password) VALUES ('\(eUU.text!)', '\(ePP.text!)')") {
//                        //there was an error during the insert, handle it here
//                    } else {
//                        //no error, the row was inserted successfully
//                        print("GgggggggggGGGGgGGg")
//                    }
//                    //End
//                    
//                    
//                    self.Verify()
//                } else {
//                    // The login failed. Check error to see why.
//                }
//            }
//            
//        }
//        alert.addButton("Cancel", action: { () -> Void in
//            print("Cancel")
//        })
//        
//        alert.showCloseButton = false
//        
//        alert.showEdit("Login", subTitle: "Enter your Username and Password")
//        
//    
//    }
    
    
    
    func setUpCheckUP(user: String){
        
        let sU = PFQuery(className: "_User")
        sU.whereKey("username", equalTo: user)
        sU.findObjectsInBackgroundWithBlock { (results:[PFObject]?, error:NSError?) -> Void in
            if error == nil{
                if let results = results as [PFObject]?{
                    for result in results{
                        let jimmy = result["setUP"] as? String
                        
                        if jimmy != nil{
                            if jimmy == "no"{
                                self.FinishUp()
                            }else{
                                self.Verify()
                            }
                        }else{
                            print("Nothing in for SetUP")
                        }
                    }
                }
            }
        }
    }
    
    
    @IBAction func mygo(sender: AnyObject) {
    }
    
    func Verify(){
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc: SWRevealViewController = storyboard.instantiateViewControllerWithIdentifier("homeR") as! SWRevealViewController
        
        self.presentViewController(vc, animated: true, completion: nil)
        
    }
    //Welcoming
    func SignIN(){
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc: WelcomeVC = storyboard.instantiateViewControllerWithIdentifier("Welcoming") as! WelcomeVC
        
        self.presentViewController(vc, animated: true, completion: nil)

    }
    
    //Finish SetUp
    func FinishUp(){
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc: FindSchoolsNAVI = storyboard.instantiateViewControllerWithIdentifier("FindSchools") as! FindSchoolsNAVI
        
        self.presentViewController(vc, animated: true, completion: nil)
        
    }
    
    
    
}