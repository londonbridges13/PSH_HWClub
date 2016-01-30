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
    
    var checker = [String]()
    var theTopic : String?
    var theSchool : String?
    var theClass : String?
    var theTeacher : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newTopicTX.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }

    @IBAction func AddIt(sender: AnyObject) {
        if newTopicTX?.text!.characters.count > 3{
//            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            theTopic = newTopicTX.text
            checkAndUpload(theTopic!)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkAndUpload(textfield:String){
        print(textfield)
        self.checker.removeAll()
        let uC = PFQuery(className: "Assignments")
        //var iii = 0
        if theTopic != nil{
            uC.whereKey("assignmentName", equalTo: textfield)
            uC.whereKey("classname", equalTo: theClass!)
            uC.whereKey("teacherName", equalTo: theTeacher!)
            uC.whereKey("School", equalTo: theSchool!)
            uC.whereKey("createdAt", lessThan: NSDate())
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
    }
    
    func ConG(){
        let cn = SCLAlertView()
        cn.showSuccess("Added New Topic", subTitle: "Successfully Added New Topic 👌")
        UIApplication.sharedApplication().endIgnoringInteractionEvents()

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
