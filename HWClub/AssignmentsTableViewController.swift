//
//  AssignmentsTableViewController.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 9/27/15.
//  Copyright © 2015 Lyndon Samual McKay. All rights reserved.
//

import UIKit
import Parse

class AssignmentsTableViewController: UITableViewController,AssignmentDelagate {

   // let queue = dispatch_get_global_queue(QOS_CLASS_USER_INITIATED.rawValue, 0)

    var refreshControlelol = UIRefreshControl()
    var proppie : PFFile?
    @IBOutlet var tableview: UITableView!
    @IBOutlet var MCL : UIButton!
    @IBOutlet var FINDER : UIButton!
    var AssignmentsArray: [String] = [String]()
    var teacherArray: [String] = [String]()
    var classArray: [String] = [String]()
    var numQuArray: [String] = [String]()
    var createDateArray = [NSDate]()
    let whitty = UIColor.whiteColor()
    var assys = [String]()
    let cUser = PFUser.currentUser()
    var derp : String?
    var array = [String]()
    var ido : String?
    var isFollowing : Bool?
// Segue labels
    var theSchool : String?
    var theClass : String?
    var theTeacher : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        showActivityIndicatory(self.view)

        
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
        

//        let thread = NSThread(target: self, selector: "Assignments", object: nil)

//        thread.start()
            //self.queryAssignments()
            self.userInfoQuery()
        
        
        print(theClass)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.refreshControl = refreshControlelol
        self.refreshControlelol.addTarget(self, action: "DidRefreshStrings", forControlEvents: UIControlEvents.ValueChanged)
        
        
    }


    func DidRefreshStrings(){
        
        //this is me combining two different arrays, hitting two birds with one stone a me lad!!
        // this is vital to the follow function in DAC adding multiple arrays
        
        self.tableView.reloadData()
        
        // This ends the loading indicator
        self.refreshControlelol.endRefreshing()
        
        print("REFRESHED")
    }

    
    @IBAction func unwindSegueASS(segue:UIStoryboardSegue){
        teacherArray.removeAll()
        classArray.removeAll()
        AssignmentsArray.removeAll()
        numQuArray.removeAll()
        createDateArray.removeAll()
        array.removeAll()
//        self.queryAssignments()
        self.userInfoQuery()
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
    
    func removeLoading30(){
        if let viewWithTag = self.view.viewWithTag(30) {
            print("Tag 100")
            viewWithTag.removeFromSuperview()
        }
        else {
            print("tag not found")
        }
    }

    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "newLesson"{
            let vc : NewLessonVC = segue.destinationViewController as! NewLessonVC
            
            vc.theSchool = self.theSchool
            vc.theClass = self.theClass
            vc.theTeacher = self.theTeacher
            
        }
        if segue.identifier == "classToAss"{
            let vc : FindClassViewController = segue.destinationViewController as! FindClassViewController
            
            
        }
        if segue.identifier == "myAss"{
            let vc : MyClassesTableViewController = segue.destinationViewController as! MyClassesTableViewController
        }
        else if segue.identifier == "iQ"{
        let vc: QuestionsTableViewController = segue.destinationViewController as! QuestionsTableViewController
        let ASSS = tableView.indexPathForSelectedRow?.row
        if self.proppie != nil{
            vc.proppie = self.proppie!
        }
        vc.theAssignment = "\(AssignmentsArray[ASSS!])"
        vc.assID = "\(assys[ASSS!])"
        vc.theClassname = theClass
        vc.theSchool = self.theSchool
        vc.theTeachername = theTeacher
        
/* POTENTIAL SOLUTION TO ALL PROBLEMS
        if let fergy = tableView.indexPathForSelectedRow?.row{
            var had = classArray[fergy]
        }
*/
        print("<<<<<<<\(theTeacher)>>>>>>>>>")
        }
    }
    
    
    
    func userInfoQuery(){
        let qUser = PFQuery(className: "_User")
        qUser.whereKey("objectId", equalTo: (cUser?.objectId)!)
        qUser.findObjectsInBackgroundWithBlock { (results :[PFObject]?, error:NSError?) -> Void in
            if error == nil{
                if let results = results as [PFObject]?{
                    for result in results{
                        let thisSchool = result["School"] as? String
                        let theIDO = result.objectId
                        self.ido = theIDO!
                        if thisSchool != nil{
                            self.theSchool = thisSchool!
                            self.queryAssignments()
                        }else{
                            print("No School Found")
                        }
                    }
                }
            }
        }
    }

    
    
    
    
    func queryAssignments(){
        
//        let newQueue = dispatch_queue_create("com.happymappy.prodown", nil)
        //dispatch_async(newQueue) { () -> Void in
            
        let assignmentsQuery = PFQuery(className: "Assignments")
        
        assignmentsQuery.whereKey("classname", equalTo: self.theClass!)
        assignmentsQuery.whereKey("teacherName", equalTo: self.theTeacher!)
        if self.theSchool != nil{
            assignmentsQuery.whereKey("School", equalTo: self.theSchool!)
        }else{
            print("theSchool equals nil")
        }
        assignmentsQuery.orderByDescending("createdAt")
        assignmentsQuery.findObjectsInBackgroundWithBlock { (results: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil{
                
                
                if let results = results as [PFObject]?{
                    
                    for result in results{
                        
                        print("Undr")
                        
                        let aAssignment = result["assignmentName"] as! String
                        let aClass = result["classname"] as! String
                        let aTeacher = result["teacherName"] as! String
                        let aNumQ = result["numberOfQuestions"] as? String
                        
                        // Append
                        
                        self.AssignmentsArray.append(aAssignment)
                        self.classArray.append(aClass)
                        self.teacherArray.append(aTeacher)
                        if aNumQ != nil{
                            self.numQuArray.append(aNumQ!)
                        }
                        self.createDateArray.append(result.createdAt!)
                        self.assys.append(result.objectId!)
                        print(aAssignment)
                        print(aClass)
                        print(aTeacher)
                        print(aNumQ)
                        print(result.createdAt)
                        
                        self.tableView.reloadData()
                        self.removeLoading()
                    }
                    self.removeLoading()
                }
                self.removeLoading()

                
                
            }else{
                print("Error \(error)  \(error?.userInfo)")
            }
            
        }
//        }//dis
    }
    
    
    
    
    
    
    
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        
        switch (section){
        
        case 0:
            return 1

        case 1:
            if AssignmentsArray.count != 0{
                return AssignmentsArray.count
            }else{
                return 2
            }

        default:
            return 0

            
        }
        
            
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        // Configure the cell...

        
        switch (indexPath.section){
        
        case 0:
            let cell : AssignmentHeaderViewCell = tableView.dequeueReusableCellWithIdentifier("assHeadercell", forIndexPath: indexPath) as! AssignmentHeaderViewCell
           
            func preQuery(){
                // goes in viewwillappear
                let Class = PFQuery(className: "ClassesFollowed")
                Class.whereKey("classesFollowed", equalTo: self.theClass!)
                Class.whereKey("teacherName", equalTo: self.theTeacher!)
                if self.theSchool != nil{
                    Class.whereKey("School", equalTo: self.theSchool!)
                }
                Class.whereKey("Username", equalTo: "\((cUser?.username)!)")
                Class.whereKey("UserID", equalTo: (cUser?.objectId)!)
                Class.findObjectsInBackgroundWithBlock { (results:[PFObject]?, error:NSError?) -> Void in
                    if error == nil{
                        if let results = results as [PFObject]?{
                            for result in results{
                                self.array.append(result.objectId!)
                                if self.array.count > 0{
                                    let lBlue = UIColor(red: 134/255, green: 218/255, blue: 233/255, alpha: 1)
                                    cell.followButton.setTitle("Following", forState: UIControlState.Normal)
                                    cell.followButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
                                    cell.followButton.backgroundColor = lBlue
                                    cell.newLessonButton.alpha = 1
                                    self.isFollowing = true
                                }
                            }
                        }
                    }
                }
            }
            preQuery()
            cell.delegate = self
            cell.classnameLabel.text = theClass
            cell.teachernameLabel.text = theTeacher
            tableView.rowHeight = 162
            return cell
            
        case 1:
            let cell : AssignmentTableViewCell = tableView.dequeueReusableCellWithIdentifier("AssignmentsCell", forIndexPath: indexPath) as! AssignmentTableViewCell
            if AssignmentsArray.count != 0{
            cell.assignmentName.text = "\(AssignmentsArray[indexPath.row])"
//            cell.numOfQ.text = "  \(numQuArray[indexPath.row]) Questions"
            cell.date.text = "Created: \(dts(createDateArray[indexPath.row]))"//"\(createDateArray[indexPath.row])"
            
            tableView.rowHeight = 101
            }else{
                if indexPath.row == 0{
                    tableView.rowHeight = 101
                    cell.assignmentName.text = "Welcome to your New Class" //"This is where all Topics / Lessons are Posted"
                }
                if indexPath.row == 1{
                    tableView.rowHeight = UITableViewAutomaticDimension
                    tableView.estimatedRowHeight = 101
                    cell.assignmentName.text = "This is where all Topics / Lessons are Posted"
                }
            }
            
            
            return cell
        
            
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
            
            return cell
        
        }
    
    
    }
    
    
    
    
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if AssignmentsArray.count != 0{
            if self.isFollowing == true{
                performSegueWithIdentifier("iQ", sender: self)
            }
        }
    }
    
    
/*
    func preQuery(){
        // goes in viewwillappear
        let Class = PFQuery(className: "ClassesFollowed")
        Class.whereKey("classesFollowed", equalTo: self.theClass!)
        Class.whereKey("teacherName", equalTo: self.theTeacher!)
        if self.theSchool != nil{
            Class.whereKey("School", equalTo: self.theSchool!)
        }
        Class.whereKey("Username", equalTo: "\((cUser?.username)!)")
        Class.findObjectsInBackgroundWithBlock { (results:[PFObject]?, error:NSError?) -> Void in
            if error == nil{
                if let results = results as [PFObject]?{
                    for result in results{
                        self.array.append(result.objectId!)
                        if self.array.count > 0{
                            followButton.setTitle("Following", forState: UIControlState.Normal)
                        }
                    }
                }
            }
        }
    }
    */

    
    
    
    
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
        isFollowing = true
        Class["Username"] = "\((cUser?.username)!)"
        self.addOne()
        Class.saveInBackgroundWithBlock { (success:Bool, error:NSError?) -> Void in
            if (success == true){
                print("Followed Class")
            }else{
                print(error?.description)
            }
        }
        
    }
    
    func unfollowClass(){
//        print("Class Unfollowed")
        isFollowing = false
        let Class = PFQuery(className: "ClassesFollowed")
        Class.whereKey("classesFollowed", equalTo: self.theClass!)
        Class.whereKey("teacherName", equalTo: self.theTeacher!)
        Class.whereKey("UserID", equalTo: (cUser?.objectId)!)
        if self.theSchool != nil{
            Class.whereKey("School", equalTo: self.theSchool!)
        }
        //Class.whereKey("Username", equalTo: "\((cUser?.username)!)")
        Class.findObjectsInBackgroundWithBlock { (results:[PFObject]?, error:NSError?) -> Void in
            if error == nil{
                if let results = results as [PFObject]?{
                    for result in results{
                        let theIdo = result.objectId
                        if theIdo != nil{
                            self.ido = theIdo!
                            self.deleteThatClass(theIdo!)
                            //self.minusOne()
                            self.BACK()
                        }
                    }
                }
            }
        }
    }
    
    
    func deleteThatClass(id: String){
        let Class = PFQuery(className: "ClassesFollowed")
        Class.getObjectInBackgroundWithId(id) { (result:PFObject?, error:NSError?) -> Void in
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), { () -> Void in
                result!.deleteInBackground()
            })
//            result!.deleteInBackground()
            print("Class Unfollowed")
        }
    }
    
    func addOne(){
        let id = self.cUser?.objectId!
        let thisUser = PFQuery(className: "_User")
        thisUser.whereKey("Username", equalTo: (cUser?.username)!)
        thisUser.getObjectInBackgroundWithId(id!) { (results:PFObject?, error :NSError?) -> Void in
            if error != nil{
            }else if let results = results  {
                var tiki : Int?
                var cNum = results["numOfClasses"] as? Int
                if cNum == nil{
                    cNum = 0
                    tiki = cNum
                    print(cNum)
                    tiki! += 1
                    results["numOfClasses"] = tiki!
                }else{
                    print(cNum)
                    tiki = cNum
                    tiki! += 1
                    results["numOfClasses"] = tiki!
                }
//                print(cNum)
//
//                tiki! += 1
//                results["numOfClasses"] = tiki
                
                results.saveInBackground()
                }
            }
    }
    
    
    
    func minusOne(){
        showActivityIndicatory(self.view)
        let id = self.cUser?.objectId!
        let thisUser = PFQuery(className: "_User")
        thisUser.whereKey("Username", equalTo: (cUser?.username)!)
        thisUser.getObjectInBackgroundWithId(id!) { (results:PFObject?, error :NSError?) -> Void in
            if error != nil{
                self.removeLoading30()
                print(error?.description)
            }else if let results = results  {
                UIApplication.sharedApplication().beginIgnoringInteractionEvents()

                var tiki : Int?
                var cNum = results["numOfClasses"] as? Int
                if cNum == nil{
                    cNum = 0
                    tiki = cNum
                    print(cNum)
                    tiki! -= 1
                    results["numOfClasses"] = tiki!
                    
                }else{
                    print(cNum)
                    tiki = cNum
                    tiki! -= 1
                    results["numOfClasses"] = tiki!
                }

//                print(cNum)
//                
//                cNum -= 1
//                results["numOfClasses"] = cNum
                
                results.saveInBackground()
                self.removeLoading30()
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                
            }
        }
    }
    
    
    
    func showActivityIndicatory(uiView: UIView) {
        let container: UIView = UIView()
        container.frame = uiView.frame
        container.center = uiView.center
        container.tag = 30
        
        let loadingView: UIView = UIView()
        loadingView.frame = CGRectMake(0, 0, 80, 80)
        loadingView.center = uiView.center
        loadingView.backgroundColor = UIColor(red: 68/255, green: 68/255, blue: 68/255, alpha: 0.7)//UIColorFromHex(0x444444, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        actInd.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
        actInd.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.WhiteLarge
        actInd.center = CGPointMake(loadingView.frame.size.width / 2,
            loadingView.frame.size.height / 2);
        loadingView.addSubview(actInd)
        container.addSubview(loadingView)
        uiView.addSubview(container)
        actInd.startAnimating()
    }

    
    
    func BACK(){
        if self.derp == "MCL"{
            self.MCL.sendActionsForControlEvents(.TouchUpInside)
        }else{
            self.FINDER.sendActionsForControlEvents(.TouchUpInside)
        }
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
