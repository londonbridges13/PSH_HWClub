//
//  EnterUsernameVC.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 1/5/16.
//  Copyright © 2016 Lyndon Samual McKay. All rights reserved.
//

import UIKit
import Parse

class EnterUsernameVC: UIViewController, UITextFieldDelegate   {

    var theSay : String?
    var theUsername : String?
    var checker = [String]()
    var bo : Bool?
    var io = 0
    
    @IBOutlet var Next: UIButton!
    @IBOutlet var UsernameTF : UITextField!
    @IBOutlet var invalidLabel : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UsernameTF.becomeFirstResponder()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func topNext(sender: AnyObject) {
        self.Next.sendActionsForControlEvents(.TouchUpInside)
    }
    
    
    @IBAction func checking(){
        // Check for Username Validation
        self.checker.removeAll()
//
        while self.UsernameTF?.text!.characters.last == " "{
            //            if theTopic?.characters.last == " "{
            print("remove")
            //                theTopic = newTopicTX.text
            print("\(self.UsernameTF?.text!)ttt")
            var toko = self.UsernameTF?.text!.substringToIndex((self.UsernameTF?.text!.endIndex.predecessor())!)
            self.UsernameTF?.text! = toko!
            print("\(self.UsernameTF?.text!)ttt")
        }

        if UsernameTF?.text!.characters.count < 5{
            print("Username is too Short!")
            //Show Short water later
            self.invalidLabel.text = "Username must contain at least 5 letters"
            self.invalidLabel.alpha = 1
            theSay = "no"

        }else{
                theSay = "yes"
            
                if theSay == "yes"{
                    self.theUsername = self.UsernameTF.text
                    checkForUsername(theUsername!)
                }else{
                    // show INVALID LABEL
                    print("Invalid username")
                    self.invalidLabel.text = "Sorry, this Username has been taken"
                    self.invalidLabel.alpha = 1

            }

        }
        
    }
    
    
    
    
    func checkForUsername(textfield : String){
        print(textfield)
        self.checker.removeAll()
        let uC = PFQuery(className: "_User")
        //var iii = 0
        if theUsername != nil{
            uC.whereKey("username", equalTo: textfield)
            uC.findObjectsInBackgroundWithBlock({ (results : [PFObject]?, error: NSError?) -> Void in
                if error == nil{
                   // self.checker.removeAll()

                    if results!.count > 0{
                        self.checker.append("homie")
                        self.cThat()
                    }else{
                        self.sendher()
                    }
                    
                            
                        

                }
            })
        }
      //sleep(1)
    }
    
    
    
    func sendher(){
        self.theUsername = self.UsernameTF.text
        if self.theUsername != nil{
            self.performSegueWithIdentifier("part2", sender: EnterUsernameVC())
        }

    }
    
    func cThat(){
            print(self.checker.count)
//            if self.checker.count == 0{
//                print("Your Good, No Username by this name")
//                //Execute Segue
//                self.theUsername = self.UsernameTF.text
//                
//                    if self.theUsername != nil{
//                        self.performSegueWithIdentifier("part2", sender: EnterUsernameVC())
//                    }
//
//            }else{
                print("cThatIssue")
                print("Sorry, User's are already by this name")
                self.invalidLabel.text = "Sorry, this Username has been taken"
                self.invalidLabel.alpha = 1
                
//            }
        
    }
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        self.Next.sendActionsForControlEvents(.TouchUpInside)

        return true
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("Segueing")
        if segue.identifier == "part2"{
        let vc : EnterPasswordVC = segue.destinationViewController as! EnterPasswordVC
        vc.theUsername = self.theUsername!
        
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
