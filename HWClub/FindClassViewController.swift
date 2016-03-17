//
//  FindClassViewController.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 9/25/15.
//  Copyright © 2015 Lyndon Samual McKay. All rights reserved.
//

import UIKit
import Parse

class FindClassViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, AddClassDelegate, CreateClassDelegate {

    @IBOutlet var menuButton: UIBarButtonItem!
    @IBOutlet var tableview: UITableView!
    
    
    var classnameArray : [String] = [String]()
    var teacherNameArray : [String] = [String]()
    var theSay : String?
    var teachName : String?
    var className : String?
    var ccc : String?
    var ttt : String?
    var theSchool : String?
    var whitty = UIColor.whiteColor()
    let teal  = UIColor(red: 52/255, green: 185/255, blue: 208/255, alpha: 1)
    let cUser = PFUser.currentUser()
    
    var annotationViewController: FC_AnnotationVC?

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        presentAnnotation()

        
        let _ = userInfoQuery()
        
        let testFrame : CGRect = CGRectMake(0,0,self.view.frame.width,self.view.frame.height)
        let testView : UIView = UIView(frame: testFrame)
        testView.backgroundColor = self.whitty
        testView.alpha = 1
        testView.tag = 90
        self.view.addSubview(testView)
        
        let aFrame = CGRectMake((testView.frame.size.height / 4), 96, 80, 80)
        
        let loadingView: UIView = UIView()
        loadingView.frame = aFrame //CGRectMake(0, 0, 80, 80)
        loadingView.backgroundColor = UIColor(red: 52/255, green: 185/255, blue: 208/255, alpha: 0.6)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 40
        testView.addSubview(loadingView)
        
        
        let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        myActivityIndicator.color = UIColor.whiteColor()
        myActivityIndicator.frame = aFrame
        myActivityIndicator.hidden = false
        myActivityIndicator.startAnimating()
        testView.addSubview(myActivityIndicator)
        

        
        let th = [3,24,244,2444,42,53,456]
        
        print(th.indexOf(2))
        
        self.tableview.dataSource = self
        self.tableview.delegate = self
        
        
//        FindClasses()
        
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        
        

    }
    


    @IBAction func buttonPressed(sender: AnyObject) {
//        presentAnnotation()
    }
    
    func presentAnnotation() {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("FC_AnnotationVC") as! FC_AnnotationVC
        viewController.alpha = 0.5
        presentViewController(viewController, animated: true, completion: nil)
        annotationViewController = viewController
    }
    
    
    /*if error == nil {
    // The find succeeded.
    println("Successfully retrieved \(objects!.count) scores.")
    // Do something with the found objects
    if let objects = objects as? [PFObject] {
    for object in objects {
    println(object.objectId)
    }
    }
    } else {
    // Log details of the failure
    println("Error: \(error!) \(error!.userInfo!)")
    }*/
    
    
    @IBAction func unwindSeggyFINDER(segue: UIStoryboardSegue){
        
        self.classnameArray.removeAll()
        self.teacherNameArray.removeAll()
        self.FindClasses()
        //        self.tableView.reloadData()
        
    }
    
    
    
    func ConG(){
        let cn = SCLAlertView()
        cn.showSuccess("Class Added", subTitle: "Successfully Added Class")
    }
    
    @IBAction func addAClass(sender: AnyObject) {
        let addV = SCLAlertView()
        let newClass = addV.addTextField("Class")
        let newTeach = addV.addTextField("Teacher")
        
        newClass.delegate = self
        newTeach.delegate = self
        
        addV.showCloseButton = false


        

        addV.addButton("Done") { () -> Void in
            // IF ERROR CHECK THIS AREA

            print("pressed")
            
            self.ccc = newClass.text
            self.ttt = newTeach.text
            
            while self.ccc!.characters.last == " "{
                //            if theTopic?.characters.last == " "{
                print("remove")
                //                theTopic = newTopicTX.text
                print("\(self.ccc)ttt")
                var toko = self.ccc!.substringToIndex(self.ccc!.endIndex.predecessor())
                self.ccc = toko
                print("\(self.ccc)ttt")
            }
            while self.ttt!.characters.last == " "{
                //            if theTopic?.characters.last == " "{
                print("remove")
                //                theTopic = newTopicTX.text
                print("\(self.ttt)ttt")
                var toko = self.ttt!.substringToIndex(self.ttt!.endIndex.predecessor())
                self.ttt = toko
                print("\(self.ttt)ttt")
            }
            let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 1/13 * Int64(NSEC_PER_SEC))
            dispatch_after(time, dispatch_get_main_queue()) {
            if self.ccc!.characters.count > 3{
                if self.ttt!.characters.count > 3{
                    
                    
                    if self.ccc!.characters.count > 3 && self.ttt!.characters.count > 3{
                        let _ = self.checkForUsername(self.ccc!, tTextfield: self.ttt!)
                    }
                    
                    self.tableview.reloadData()
                }else{
                    self.NoCongTeach()
                }
            }else{
                self.NoCongClass()
                }
            }
            
        }
        
        addV.addButton("Cancel") { () -> Void in
            
        }
        
        addV.showInfo("Add Class", subTitle: "Don't see your class, Add it")

    }
    
    func checkForUsername(ctextfield : String, tTextfield : String ){
        print(ctextfield)
        let uC = PFQuery(className: "Classes")
            uC.whereKey("teacherName", equalTo: tTextfield)
            uC.whereKey("classname", equalTo: ctextfield)
            uC.whereKey("School", equalTo: self.theSchool!)
            uC.findObjectsInBackgroundWithBlock({ (results : [PFObject]?, error: NSError?) -> Void in
                if error == nil{
                    // self.checker.removeAll()
                    
                    if results!.count > 0{
                        self.NoCongEXISTS() // Sorry this Class Already Exists
                    }else{
                        let _ = self.addThat()
                    }
                    
                    
                    
                    
                }
            })
        //sleep(1)
    }

    
    
    func addThat(){
            let adding = PFObject(className: "Classes")

            adding["classname"] = ccc
            adding["teacherName"] = ttt
            adding["School"] = self.theSchool
            adding.saveInBackgroundWithBlock({ (success : Bool, error : NSError?) -> Void in
                
                if (success == true){
                    print("Saved New Class")
                    self.ConG()
                    self.classnameArray.removeAll()
                    self.teacherNameArray.removeAll()
                    self.tableview.reloadData()
                    self.FindClasses()
                    self.sendher() // Adding New Topic: "Group Chat"
                } else{
                    
                    print(error?.description)
                    
                    
                }
            })
        }
    
    
    func NoCongEXISTS(){
        let cn = SCLAlertView()
        cn.showNotice("Lucky you", subTitle: "This Class already Exists in your School. Search for this Class and Start connecting with your Classmates")
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
        
    }
    
    
    func NoCongClass(){
        let cn = SCLAlertView()
        cn.showError("Problem", subTitle: "The Class cannot be less then 4 characters.")
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
        
    }
    
    func NoCongTeach(){
        let cn = SCLAlertView()
        cn.showError("Problem", subTitle: "The Teacher's Name cannot be less then 4 characters.")
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

    
    func userInfoQuery(){
        let qUser = PFQuery(className: "_User")
        qUser.whereKey("username", equalTo: (cUser?.username)!)
        qUser.findObjectsInBackgroundWithBlock { (results :[PFObject]?, error:NSError?) -> Void in
            if error == nil{
                if let results = results as [PFObject]?{
                    for result in results{
                        let School = result["School"] as? String
                        if School != nil{
                            self.theSchool = School!
                            self.FindClasses()
                        }else{
                            print("User Has No School")
                        }
                        
                        
                    }
                }
            }
        }
    }
    
    
    func addNewOne(){
        
        print("Two Tap")
        let addV = SCLAlertView()
        let newClass = addV.addTextField("Class")
        let newTeach = addV.addTextField("Teacher")
        
        newClass.delegate = self
        newTeach.delegate = self
        
        addV.showCloseButton = false
        
        
        
        
        addV.addButton("Done") { () -> Void in
            // IF ERROR CHECK THIS AREA
            
            print("pressed")
            
            self.ccc = newClass.text
            self.ttt = newTeach.text
            
            while self.ccc!.characters.last == " "{
                //            if theTopic?.characters.last == " "{
                print("remove")
                //                theTopic = newTopicTX.text
                print("\(self.ccc)ttt")
                var toko = self.ccc!.substringToIndex(self.ccc!.endIndex.predecessor())
                self.ccc = toko
                print("\(self.ccc)ttt")
            }
            while self.ttt!.characters.last == " "{
                //            if theTopic?.characters.last == " "{
                print("remove")
                //                theTopic = newTopicTX.text
                print("\(self.ttt)ttt")
                var toko = self.ttt!.substringToIndex(self.ttt!.endIndex.predecessor())
                self.ttt = toko
                print("\(self.ttt)ttt")
            }
            let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 1/13 * Int64(NSEC_PER_SEC))
            dispatch_after(time, dispatch_get_main_queue()) {
                if self.ccc!.characters.count > 3{
                    if self.ttt!.characters.count > 3{
                        
                        
                        if self.ccc!.characters.count > 3 && self.ttt!.characters.count > 3{
                            let _ = self.checkForUsername(self.ccc!, tTextfield: self.ttt!)
                        }
                        
                        self.tableview.reloadData()
                    }else{
                        self.NoCongTeach()
                    }
                }else{
                    self.NoCongClass()
                }
            }
            
        }
        
        addV.addButton("Cancel") { () -> Void in
            
        }
        
        addV.showInfo("Add Class", subTitle: "Don't see your class, Add it")
    }
    
    
    func FindClasses(){
        
        let CFquery = PFQuery(className: "Classes")
        if self.theSchool != nil{
            CFquery.whereKey("School", equalTo: self.theSchool!)
        }else{
            print("theSchool equals nil")
        }
        
        CFquery.findObjectsInBackgroundWithBlock { (results: [PFObject]?, Error: NSError?) -> Void in
            
            if Error == nil{
            
            
                if let results = results as [PFObject]?{
            
                    for result in results{
            print(result.objectId)
                        let aClass = result["classname"] as! String
                        let aTeacher = result["teacherName"] as! String
                        self.classnameArray.append(aClass)
                        self.teacherNameArray.append(aTeacher)
                    
                        print(aClass)
                        print(aTeacher)
                        
                    }
                    self.tableview.reloadData()
                    self.removeLoading()

                }
            } else{
                print("Error: \(Error!) \(Error!.userInfo)")
            }
            
        }
    
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if classnameArray.count > 0 {
            theSay = "yes"
            return classnameArray.count + 2
        }else{
            theSay = "no"
            return 2
        }

        //return classnameArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if theSay == "yes"{
            
            //sittingClass
            if indexPath.row == 0{
                let cell = tableView.dequeueReusableCellWithIdentifier("sittingClass", forIndexPath: indexPath)
                tableview.rowHeight = 129//132
                return cell
            }
            if indexPath.row == 1{
                let cell : CreateClassCell = tableview.dequeueReusableCellWithIdentifier("CreateClassCell", forIndexPath: indexPath) as! CreateClassCell
                
                cell.delegate = self
                cell.findClassButton.layer.borderColor = teal.CGColor
                cell.findClassButton.layer.borderWidth = 1
                cell.findClassButton.layer.cornerRadius = 8
                
                tableview.rowHeight = 60
                
                return cell
            }else{
                let cell : FindClassTableViewCell = tableview.dequeueReusableCellWithIdentifier("FindClassCell", forIndexPath: indexPath) as! FindClassTableViewCell
                
                cell.classnameLabel.text = "\(classnameArray[indexPath.row - 2])"
                cell.teacherNameLabel.text = "\(teacherNameArray[indexPath.row - 2])"
                // AddClassButton
                
                tableview.rowHeight = 80
                
                return cell
            }

        }else{
            if indexPath.row == 0{
                let cell : noFindCellClass  = tableView.dequeueReusableCellWithIdentifier("noFindClass", forIndexPath: indexPath) as! noFindCellClass
                
                cell.delegate = self
                cell.findClassButton.layer.borderColor = teal.CGColor
                cell.findClassButton.layer.borderWidth = 1
                cell.findClassButton.layer.cornerRadius = 8
                tableView.rowHeight = UITableViewAutomaticDimension
                tableView.estimatedRowHeight = 400//209
                
                // Configure the cell...
                
                return cell
                

            }else{
                let cell = tableView.dequeueReusableCellWithIdentifier("blank", forIndexPath: indexPath)
                tableview.rowHeight = 0//132
                return cell
            }

        }

    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if classnameArray.count > 0 && indexPath.row > 1{
            print("Selected")
            print(indexPath.row)
            className = "\(classnameArray[indexPath.row - 2])"
            teachName = "\(teacherNameArray[indexPath.row - 2])"
            //        performSegueWithIdentifier("classToAss", sender: self)
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "classToAss"{
//            let vc : AssignmentsTableViewController = segue.destinationViewController as! AssignmentsTableViewController
            let vc : OtherAssignmentsTableViewController = segue.destinationViewController as! OtherAssignmentsTableViewController
            //OtherAssignmentsTableViewController
        let codeIndex = tableview.indexPathForSelectedRow!.row
        print(codeIndex)
        print("UPPPPP")
        vc.theClass = "\(classnameArray[codeIndex - 2])"
        //vc.CHold = className
        vc.theTeacher = "\(teacherNameArray[codeIndex - 2])"
//        vc.derp = "FINDER"
        vc.derp = "KLM"
        vc.theSchool = self.theSchool
        // NOT DONE HERE
        } else {
            let vc : SearchTVC = segue.destinationViewController as! SearchTVC
            
            vc.School = self.theSchool
            
        }
        
    }
    
    
    func Verify(){
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc: LoadingViewController = storyboard.instantiateViewControllerWithIdentifier("lPage") as! LoadingViewController
        
        self.presentViewController(vc, animated: true, completion: nil)
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func sendher(){
//        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        let yeet = PFObject(className: "Assignments")
        yeet["assignmentName"] = "Group Chat"
        yeet["School"] = theSchool
        yeet["classname"] = ccc
        yeet["teacherName"] = ttt
        yeet.saveInBackgroundWithBlock { (suc :Bool, error:NSError?) -> Void in
            if suc == true {
                print(yeet.objectId)
                print("whats that up there?")
                if yeet.objectId != nil{
                    self.postQuestion("ChatHub", assID: yeet.objectId!)
                }
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
//                self.ConG()
//                self.senditButty.sendActionsForControlEvents(.TouchUpInside)
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
            }else{
                print(error?.description)
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                
            }
            UIApplication.sharedApplication().endIgnoringInteractionEvents()
            
        }
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
        
    }

    
    func postQuestion(q: String, assID : String){
        let aQ = PFObject(className: "Questions")
        aQ["School"] = theSchool!
        aQ["teacherName"] = ttt!
        aQ["classname"] = ccc!
        aQ["username"] = "Su9eRf8USER"
        aQ["assignmentName"] = "Group Chat"
        aQ["numberOfAnswers"] = 0
        aQ["hasAnImage"] = false // for now
        aQ["assignmentId"] = assID
        aQ["usernameID"] = "Su9eRf8ID"
        
        aQ["question"] = "ChatHub" // Must = ChatHub //"Group Chat"
        aQ.saveInBackgroundWithBlock { (suc:Bool, errror:NSError?) -> Void in
            if suc == true{
//                self.gogoo()
            }else{
                print(errror?.description)
            }
        }
    }
    

    
    
    func LoadingDesign(){
        
        let testFrame : CGRect = CGRectMake(0,0,self.view.frame.width,self.view.frame.height )
        let testView : UIView = UIView(frame: testFrame)
        testView.backgroundColor = self.whitty
        testView.alpha = 1
        testView.tag = 90
        self.view.addSubview(testView)
        
        let aFrame = CGRectMake((testView.frame.size.height / 4), 96, 80, 80)
        
        let loadingView: UIView = UIView()
        loadingView.frame = aFrame //CGRectMake(0, 0, 80, 80)
        loadingView.backgroundColor = UIColor(red: 52/255, green: 185/255, blue: 208/255, alpha: 0.6)
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
    

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    

}
