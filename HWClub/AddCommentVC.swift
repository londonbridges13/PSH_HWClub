//
//  AddCommentVC.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 1/4/16.
//  Copyright © 2016 Lyndon Samual McKay. All rights reserved.
//

import UIKit
import Parse


class AddCommentVC: UIViewController, UITextViewDelegate {

    @IBOutlet var commentTV: UITextView!
    @IBOutlet var dr: UIButton!
    
    var theSay : String?  // photo or naw  PAnswerComment or AnswerComment
    var objectID : String?
    var userNotiID: String?
    var commenterID: String?  // if thisuser gave the answer then dont send a notification, this = cUser
    var AnswerID : String?
    var AnswerProviderID : String?
    var propy : UIImage?
    var proppie : PFFile?
    
    
    let queue = dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)
    
    let cUser = PFUser.currentUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.quickQuery()
        self.commentTV.delegate = self
        
        self.commentTV.becomeFirstResponder()
        
        print(AnswerID)
        print(theSay)
        print(userNotiID)
        print(AnswerProviderID)
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func it(){
        self.commentTV.isFirstResponder()

    }
    
    @IBAction func Doner(sender: AnyObject) {
        self.dr.sendActionsForControlEvents(.TouchUpInside)
    }
    
    @IBAction func doIT(sender: AnyObject) {
        if self.proppie == nil{
//            dispatch_async(queue, { () -> Void in
            self.quickQuery()
            self.sendComment()

//            })
        }else{
            self.sendComment()
            print("happytappy")}
    }
    
    @IBAction func cancel(sender: AnyObject) {
        itt()
    }
    
    func itt(){
        self.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
        self.presentingViewController?.viewDidLoad()
    }
    
    
    
    
    
    func sendComment(){
        if cUser != nil{
            print((self.cUser!.objectId)!)
            let iooo = (self.cUser!.objectId)!
            if self.AnswerProviderID == (self.cUser?.objectId)!{
                // DONT Send a Notification, just Comment, because this is the answerer
                print("I AM")
                let aC = PFObject(className: "Comment")
                aC["Comment"] = commentTV.text
                aC["AnswerID"] = self.AnswerID
                aC["NotifyUserID"] = self.AnswerProviderID //NotifyUserID is same as the AnswerProviderID
                aC["CommentUserID"] = iooo   //current user id
                aC["numOfDaps"] = 0
                aC["profilePic"] = self.proppie!  // new for img Query in COMMENTS
                aC["CommenterUserName"] = (cUser?.username)! // new for username Query
                aC.saveInBackgroundWithBlock({ (success:Bool, error:NSError?) -> Void in
                    if (success == true){
                        print("Added Comment")
                        self.itt()
                    }else{
                        print(error?.description)
                    }
                })
            }else{
                // Send a Notification + Comment
                print("I AM NOT")
                let aC = PFObject(className: "Comment")
                aC["Comment"] = commentTV.text
                aC["AnswerID"] = self.AnswerID
                aC["NotifyUserID"] = self.AnswerProviderID //NotifyUserID is same as the AnswerProviderID
                aC["CommentUserID"] = iooo   //current user id
                aC["numOfDaps"] = 0
                aC["profilePic"] = self.proppie!  // new for img Query in COMMENTS
                aC["CommenterUserName"] = (cUser?.username)! // new for username Query


                aC.saveInBackgroundWithBlock({ (success:Bool, error:NSError?) -> Void in
                    if (success == true){
                        print("Added Comment")
                        self.notifyUser(self.AnswerProviderID!)
                    }else{
                        print(error?.description)
                    }
                })

            }
        }
    }
    
    func notifyUser(notiUserid: String){
        print(notiUserid)
        let noti = PFObject(className: "Notifications")
        noti["recieved"] = false
        noti["getterID"] = self.AnswerProviderID
        noti["notiType"] = self.theSay
        noti["giverUserName"] = (cUser?.username)!
        noti["Comment"] = commentTV.text
        noti["AnswerID"] = self.AnswerID
        noti["profilePic"] = self.proppie!
        noti["thePic"] = self.proppie!  // setting this up to aviod error
        print("yes IMG")
        print("no IMG")
            // SCHOOL Doesn't matter for comments
        noti.saveInBackgroundWithBlock({ (success:Bool, error:NSError?) -> Void in
            if (success == true){
                print("Notified User, and Done")
                self.pushNotify(self.AnswerProviderID!)
                self.itt()
            }else{
                print(error?.description)
            }
        })
    }
    
    func pushNotify(notifyThisOne: String){
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
        push.setMessage("\(cUser!.username!) commented on your Answer")
        push.sendPushInBackground()
    }
    
    
    func quickQuery(){
        
        let pp = PFQuery(className: "_User")
        pp.getObjectInBackgroundWithId((cUser?.objectId)!) { (first:PFObject?, error:NSError?) -> Void in
            if first != nil{
                if let first = first{
                    let pp = first["profilePic"] as? PFFile
                
                    if pp != nil{
                        //self.getPic(pp!)
                        self.proppie = pp!
                        print(pp)
                    }else{
                        print("noIMG")
                    }
                }
            }
        }
        
    }
    
    func getPic(piffer: PFFile){
        piffer.getDataInBackgroundWithBlock { (theData:NSData?, error:NSError?) -> Void in
            if let img = UIImage(data: theData!){
                self.propy = img
                if self.propy != nil{
                    print("GOGOGOGOGOGOGO")
                }else{print("Fucking issues")}
            }
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
