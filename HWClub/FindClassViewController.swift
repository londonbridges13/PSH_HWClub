//
//  FindClassViewController.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 9/25/15.
//  Copyright © 2015 Lyndon Samual McKay. All rights reserved.
//

import UIKit
import Parse

class FindClassViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userInfoQuery()
        
        let testFrame : CGRect = CGRectMake(0,0,self.view.frame.width,self.view.frame.height - 60)
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
            if newClass.text?.characters.count > 3{
                if newTeach.text?.characters.count > 3{
                    
                    self.ccc = newClass.text
                    self.ttt = newTeach.text
                    if newClass.text?.characters.count > 3 && newTeach.text?.characters.count > 3{
                        self.checkForUsername(self.ccc!, tTextfield: self.ttt!)
                    }
                    
                    self.tableview.reloadData()
                }else{
                    self.NoCongTeach()
                }
            }else{
                self.NoCongClass()
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
                        self.addThat()
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
            return classnameArray.count
        }else{
            theSay = "no"
            return 1
        }

        //return classnameArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if theSay == "yes"{
            let cell : FindClassTableViewCell = tableview.dequeueReusableCellWithIdentifier("FindClassCell", forIndexPath: indexPath) as! FindClassTableViewCell
            
            cell.classnameLabel.text = "\(classnameArray[indexPath.row])"
            cell.teacherNameLabel.text = "\(teacherNameArray[indexPath.row])"
            // AddClassButton
            
            tableview.rowHeight = 80
            
            return cell

        }else{
            let cell : noFindCellClass  = tableView.dequeueReusableCellWithIdentifier("noFindClass", forIndexPath: indexPath) as! noFindCellClass
            
            cell.findClassButton.layer.borderColor = teal.CGColor
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = 209
            
            // Configure the cell...
            
            return cell

        }

    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        className = "\(classnameArray[indexPath.row])"
        teachName = "\(teacherNameArray[indexPath.row])"
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "classToAss"){
        let vc : AssignmentsTableViewController = segue.destinationViewController as! AssignmentsTableViewController
        let codeIndex = tableview.indexPathForSelectedRow!.row
        print(codeIndex)
        print("UPPPPP")
        vc.theClass = "\(classnameArray[codeIndex])"
        //vc.CHold = className
        vc.theTeacher = "\(teacherNameArray[codeIndex])"
        vc.derp = "FINDER"
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
    

    func LoadingDesign(){
        
        let testFrame : CGRect = CGRectMake(0,0,self.view.frame.width,self.view.frame.height - 60)
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
