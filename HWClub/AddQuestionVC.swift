//
//  AddQuestionVC.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 1/17/16.
//  Copyright © 2016 Lyndon Samual McKay. All rights reserved.
//

import UIKit
import Parse

class AddQuestionVC: UIViewController {

    @IBOutlet var qeustionTX: UITextView!
    
    @IBOutlet var sendItButton: UIButton!
    @IBOutlet var uwnOther: UIButton!
    @IBOutlet var senditButty: UIButton!
    
    var GotHERE : String?
    var theTopic : String?
    var theSchool : String?
    var theClass : String?
    var theTeacher : String?
    var proppie : PFFile?
    var assID : String?
    let cUser = PFUser.currentUser()
    var diko : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        qeustionTX.becomeFirstResponder()

        print(diko)
        print("diko up")
        if diko != nil{
            qeustionTX.resignFirstResponder()
            var alert = SCLAlertView()
            alert.addButton("Follow Class", action: { () -> Void in
                let _ = self.followClass()
                self.qeustionTX.becomeFirstResponder()
            })
            alert.addButton("Go Back", action: { () -> Void in
                //
                self.uwnOther.sendActionsForControlEvents(.TouchUpInside)
                self.senditButty.sendActionsForControlEvents(.TouchUpInside)
            })
            alert.showCloseButton = false
            alert.showNotice("Hold Up", subTitle: "Not Following this Class")
            
        }

        // Do any additional setup after loading the view.
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
    @IBAction func Doner(sender: AnyObject) {
        if qeustionTX.text.characters.count > 6{
            if qeustionTX.text.characters.last != "?"{
                qeustionTX.text = "\(qeustionTX.text)?"
                let _ = postQuestion(qeustionTX.text)
            }else{
                let _ = postQuestion(qeustionTX.text)
            }
        }else{
            print("Question too Short")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func postQuestion(q: String){
        let aQ = PFObject(className: "Questions")
        aQ["School"] = theSchool!
        aQ["teacherName"] = theTeacher!
        aQ["classname"] = theClass!
        aQ["username"] = (cUser?.username)!
        aQ["assignmentName"] = theTopic
        aQ["numberOfAnswers"] = 0
        aQ["hasAnImage"] = false // for now
        aQ["assignmentId"] = assID!
        aQ["usernameID"] = (cUser?.objectId)!

        aQ["question"] = qeustionTX.text
        aQ.saveInBackgroundWithBlock { (suc:Bool, errror:NSError?) -> Void in
            if suc == true{
                self.gogoo()
            }else{
                print(errror?.description)
            }
        }
    }
    
    func gogoo(){
        ConG()
//        if GotHERE == nil{
            self.sendItButton.sendActionsForControlEvents(.TouchUpInside)
//        }else{
            // Got here from assignment or otherassignment TVC
            self.senditButty.sendActionsForControlEvents(.TouchUpInside)
            self.uwnOther.sendActionsForControlEvents(.TouchUpInside)
//        }
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
    
    
    func ConG(){
        let cn = SCLAlertView()
        cn.showSuccess("Added New Topic", subTitle: "Successfully Added New Topic 👌")
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
