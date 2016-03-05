//
//  NewLessonVC.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 1/17/16.
//  Copyright © 2016 Lyndon Samual McKay. All rights reserved.
//

import UIKit
import Parse

class NewLessonVC: UIViewController {

    @IBOutlet var newTopicTX: UITextField!
    @IBOutlet var senditButty: UIButton!
    @IBOutlet var uwnOther : UIButton!
    
    let cUser = PFUser.currentUser()
    var checker = [String]()
    var theTopic : String?
    var theSchool : String?
    var theClass : String?
    var theTeacher : String?
    var groupChat = "Group Chat"
    var diko : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newTopicTX.becomeFirstResponder()
        // Do any additional setup after loading the view.
        
        print(diko)
        print("diko up")
        if diko != nil{
            newTopicTX.resignFirstResponder()
            var alert = SCLAlertView()
            alert.addButton("Follow Class 🏃", action: { () -> Void in
                let _ = self.followClass()
            })
            alert.addButton("Go Back ⛔️", action: { () -> Void in
                //
                self.uwnOther.sendActionsForControlEvents(.TouchUpInside)
                self.senditButty.sendActionsForControlEvents(.TouchUpInside)
            })
            alert.showCloseButton = false
            alert.showNotice("Hold Up", subTitle: "Not Following this Class")

        }
    }

    
    func followClass(){
        //        print("Followed Class")
        
        let Class = PFObject(className: "ClassesFollowed")
        Class["classesFollowed"] = self.theClass
        Class["teacherName"] = self.theTeacher
        Class["UserID"] = (cUser?.objectId)! // here
        if self.theSchool != nil{
            Class["School"] = self.theSchool
            //self.addOne()
        }
        Class["Username"] = "\((cUser?.username)!)"
        Class.saveInBackgroundWithBlock { (success:Bool, error:NSError?) -> Void in
            if (success == true){
                self.diko = nil
                print("Followed Class")
            }else{
                print(error?.description)
            }
        }
        
    }

    @IBAction func AddIt(sender: AnyObject) {
        newTopicTX.resignFirstResponder()
        theTopic = newTopicTX.text
        
                while theTopic!.characters.last == " "{
                    //            if theTopic?.characters.last == " "{
                    print("remove")
                    //                theTopic = newTopicTX.text
                    print("\(theTopic)ttt")
                    var toko = theTopic!.substringToIndex(theTopic!.endIndex.predecessor())
                    self.theTopic = toko
                    print("\(theTopic)ttt")
                }
        if theTopic != groupChat{
            if newTopicTX?.text!.characters.count > 3{
                        //            theTopic = newTopicTX.text
                self.LoadingDesign()
                let _ = checkAndUpload(theTopic!)
                //
            }else{CGTooShort()}
        }else{
            var nono = SCLAlertView()
            nono.showError("Oops...", subTitle: "Cannot have a topic by the name \"Group Chat\"")
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkAndUpload(textfield:String){
        print(textfield)
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        self.checker.removeAll()
        let uC = PFQuery(className: "Assignments")
        let wago = NSDate().minusDays(1)
        //var iii = 0
        if theTopic != nil{
            uC.whereKey("assignmentName", equalTo: textfield)
            uC.whereKey("classname", equalTo: theClass!)
            uC.whereKey("teacherName", equalTo: theTeacher!)
            uC.whereKey("School", equalTo: theSchool!)
            uC.whereKey("createdAt", greaterThan: wago)
            uC.findObjectsInBackgroundWithBlock({ (results : [PFObject]?, error: NSError?) -> Void in
                if error == nil{
                    // self.checker.removeAll()
                    
                    if results!.count > 0{
                        self.checker.append("homie")
                        UIApplication.sharedApplication().endIgnoringInteractionEvents()
                        self.cThat()
                        UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    }else{
                        self.sendher()
                        UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    }
                    
                    
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                }
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
            })
        }
        //sleep(1)
    }

    
    
    
    
    func sendher(){
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        let yeet = PFObject(className: "Assignments")
        yeet["assignmentName"] = theTopic
        yeet["School"] = theSchool
        yeet["classname"] = theClass
        yeet["teacherName"] = theTeacher
        yeet.saveInBackgroundWithBlock { (suc :Bool, error:NSError?) -> Void in
            if suc == true {
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                self.ConG()
                self.senditButty.sendActionsForControlEvents(.TouchUpInside)
                self.uwnOther.sendActionsForControlEvents(.TouchUpInside)
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
            }else{
                print(error?.description)
                UIApplication.sharedApplication().endIgnoringInteractionEvents()

            }
            UIApplication.sharedApplication().endIgnoringInteractionEvents()

        }
        UIApplication.sharedApplication().endIgnoringInteractionEvents()

    }
    
    func cThat(){
        // error
        CGReused()
    }
    
    func ConG(){
        removeLoading()
        let cn = SCLAlertView()
        cn.showSuccess("Added New Topic", subTitle: "Successfully Added New Topic 👌")
        UIApplication.sharedApplication().endIgnoringInteractionEvents()

    }
    
    func CGTooShort(){
        removeLoading()
        let cn = SCLAlertView()
        cn.showNotice("Wait a Sec", subTitle: "This Title is too short")
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
        
    }
    
    func CGReused(){
        removeLoading()
        let cn = SCLAlertView()
        cn.showInfo("Wait a Sec", subTitle: "This Topic was added Earlier Today")
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
        
    }
    
    func removeLoading(){
        if let viewWithTag = self.view.viewWithTag(90) {
            print("Tag 100")
            viewWithTag.removeFromSuperview()
        }
        else {
            print("tag not found")
        }
    }

    
    func LoadingDesign(){
        
        let testFrame : CGRect = CGRectMake(0,0,self.view.frame.width,self.view.frame.height - 60)
        let testView : UIView = UIView(frame: testFrame)
        testView.backgroundColor = UIColor.clearColor()
        testView.alpha = 1
        testView.tag = 90
        self.view.addSubview(testView)
        
        let aFrame = CGRectMake((testView.frame.size.height / 4), 96, 80, 80)
        
        let loadingView: UIView = UIView()
        loadingView.frame = aFrame //CGRectMake(0, 0, 80, 80)
        loadingView.backgroundColor = UIColor(red: 52/255, green: 185/255, blue: 208/255, alpha: 1)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 40
        testView.addSubview(loadingView)
        
        
        let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        myActivityIndicator.color = UIColor.whiteColor()
        myActivityIndicator.frame = aFrame
        myActivityIndicator.hidden = false
        myActivityIndicator.startAnimating()
        testView.addSubview(myActivityIndicator)
        
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
