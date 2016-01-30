//
//  LoginScraps.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 1/3/16.
//  Copyright © 2016 Lyndon Samual McKay. All rights reserved.
//

import Foundation
import Parse
// LoginScraps



public func DapComment(objectID:String){
    let dT = PFQuery(className: "Comment")
    let ioioiooioio = PFUser.currentUser()
    dT.getObjectInBackgroundWithId(objectID) { (result:PFObject?, error:NSError?) -> Void in
        if error == nil{
            if let result = result{
                print(result["numOfDaps"])
                let chi = result["Dappers"] as? NSMutableArray
                if chi?.containsObject(ioioiooioio!.objectId!) == true{
                    print("dicks")
                    //Remove Dap Here
                    var it = result["numOfDaps"] as? Int
                    var nit : Int?
                    if it == nil{
                        nit = 0
                        result["numOfDaps"] = nit
                        result.removeObject((ioioiooioio?.objectId!)!, forKey: "Dappers")
                        result.saveInBackground()
                    }else{
                        print(it)
                        print(nit)
                        nit = it! - 1
                        print(nit)
                        result["numOfDaps"] = nit
                        result.removeObject((ioioiooioio?.objectId!)!, forKey: "Dappers")
                        result.saveInBackground()
//                        result.saveInBackgroundWithBlock({ (suc:Bool, error :NSError?) -> Void in
//                            if error == nil{
//                                
//                            }
//                        })
                    }

                }else{
                    var it = result["numOfDaps"] as? Int
                    var nit : Int?
                    if it == nil{
                        nit = 1
                        result["numOfDaps"] = nit
                        result.addUniqueObject((ioioiooioio?.objectId!)!, forKey: "Dappers")
//                        result.saveInBackground()
                        result.saveInBackgroundWithBlock({ (suc:Bool, error :NSError?) -> Void in
                            if error == nil{
                                
                            }
                        })
                    }else{
                        print(it)
                        print(nit)
                        nit = it! + 1
                        print(nit)
                        result["numOfDaps"] = nit
                        result.addUniqueObject((ioioiooioio?.objectId!)!, forKey: "Dappers")
//                        result.saveInBackground()
                        result.saveInBackgroundWithBlock({ (suc:Bool, error :NSError?) -> Void in
                            if error == nil{
                                
                            }
                        })
                    }
                    //                result.saveInBackground()
                }
            }
        }
    }
}
    
public  func dapNotifyUser(notiUserid: String, cDapORaDap: String, giverUserName: String,pAoRvA: String, answerID : String, proppie: PFFile, theMessage : String){
    print(notiUserid)
    let cUser = PFUser.currentUser()
    
    let noti = PFObject(className: "Notifications")
    noti["recieved"] = false
    noti["getterID"] = notiUserid
    noti["notiType"] = "\(cDapORaDap)"
    noti["giverUserName"] = "\((cUser!.username)!)"
    noti["DType"] = pAoRvA
    noti["AnswerID"] = answerID
    noti["profilePic"] = proppie
    noti["thePic"] = proppie  // setting this up to aviod error
    print("yes IMG")
    print("no IMG")
    // SCHOOL Doesn't matter for comments
    noti.saveInBackgroundWithBlock({ (success:Bool, error:NSError?) -> Void in
        if (success == true){
            print("Notified User, and Done")
            if cDapORaDap == "DapComment"{
                dapPushNotify(notiUserid, commentOrAnswer: "Comment", theMessage: theMessage)
            }else{
                dapPushNotify(notiUserid, commentOrAnswer: "Answer", theMessage: theMessage)
            }
        }else{
            print(error?.description)
        }
    })
}



public func dapPushNotify(notifyThisOne: String, commentOrAnswer: String, theMessage : String){
    let cUser = PFUser.currentUser()

    // Find users near a given location
    let userQuery = PFUser.query()
    userQuery!.whereKey("objectId", equalTo: notifyThisOne)
    
    // Find devices associated with these users
    let pushQuery = PFInstallation.query()
    //pushQuery!.whereKey("userID", equalTo: notifyThisOne)
    pushQuery!.whereKey("user", matchesQuery: userQuery!)
    
    
    // Send push notification to query
    let push = PFPush()
    push.setQuery(pushQuery) // Set our Installation query
    push.setMessage("\(cUser!.username!) dapped your \(commentOrAnswer): \(theMessage)")
    push.sendPushInBackground()
}




public func DapAnswer(objectID:String){
    let dT = PFQuery(className: "Answers")
    let ioioiooioio = PFUser.currentUser()
    dT.getObjectInBackgroundWithId(objectID) { (result:PFObject?, error:NSError?) -> Void in
        if error == nil{
            if let result = result{
                print(result["numOfDaps"])
                let chi = result["Dappers"] as? NSMutableArray
                if chi?.containsObject(ioioiooioio!.objectId!) == true{
                    print("dicks")
                    //Remove Dap Here
                    var it = result["numOfDaps"] as? Int
                    var nit : Int?
                    if it == nil{
                        nit = 0
                        result["numOfDaps"] = nit
                        result.removeObject((ioioiooioio?.objectId!)!, forKey: "Dappers")
                        result.saveInBackground()
                    }else{
                        print(it)
                        print(nit)
                        nit = it! - 1
                        print(nit)
                        result["numOfDaps"] = nit
                        result.removeObject((ioioiooioio?.objectId!)!, forKey: "Dappers")
                        result.saveInBackground()
                    }
                    
                }else{
                    var it = result["numOfDaps"] as? Int
                    var nit : Int?
                    if it == nil{
                        nit = 1
                        result["numOfDaps"] = nit
                        result.addUniqueObject((ioioiooioio?.objectId!)!, forKey: "Dappers")
                        result.saveInBackground()
                    }else{
                        print(it)
                        print(nit)
                        nit = it! + 1
                        print(nit)
                        result["numOfDaps"] = nit
                        result.addUniqueObject((ioioiooioio?.objectId!)!, forKey: "Dappers")
                        result.saveInBackground()
                    }
                    //                result.saveInBackground()
                }
            }
            
        }
    }
}


class llggkgkgkg {
/*
    @IBAction func Login(sender: AnyObject) {
        let alert = SCLAlertView()
        let eUU = alert.addTextField("Username")
        let ePP = alert.addSecureTextField("Password")
        alert.addButton("Login") { () -> Void in
            // Search Parse for this name and password
            
            let user = PFUser()
            user.username = eUU.text!
            user.password = ePP.text!
            
            PFUser.logInWithUsernameInBackground(user.username!, password: user.password!) {
                (user: PFUser?, error: NSError?) -> Void in
                if user != nil {
                    // Do stuff after successful login.
                    print("Successfully Logged in")
                    self.Verify()
                } else {
                    // The login failed. Check error to see why.
                }
            }
            
        }
        alert.addButton("Cancel", action: { () -> Void in
            print("Cancel")
        })
        
        alert.showCloseButton = false
        
        alert.showEdit("Login", subTitle: "Enter your Username and Password")
        
        
    }
*/
}