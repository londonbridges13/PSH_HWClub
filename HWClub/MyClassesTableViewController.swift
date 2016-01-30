//
//  MyClassesTableViewController.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 9/29/15.
//  Copyright © 2015 Lyndon Samual McKay. All rights reserved.
//

import UIKit
import Parse

class MyClassesTableViewController: UITableViewController {

    var cUser = PFUser.currentUser()
    
    var refreshControlelol = UIRefreshControl()
    var theSay : String?
    var myTeacherArray : [String] = [String]()
    var myClassArray : [String] = [String]()
    var theSchool : String?
    let teal  = UIColor(red: 52/255, green: 185/255, blue: 208/255, alpha: 1)
    let whitty = UIColor.whiteColor()
    var proppie : PFFile?
    
    @IBOutlet var menuButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let testFrame : CGRect = CGRectMake(0,0,self.view.frame.width,self.view.frame.height - 60)
        let testView : UIView = UIView(frame: testFrame)
        testView.backgroundColor = whitty
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
    
        
        
        
        

        
        
        
        
        print(cUser!.username)
        
        previewOP()
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            // Uncomment to change the width of menu
            //   self.revealViewController().rearViewRevealWidth = 200
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.refreshControl = refreshControlelol
        self.refreshControlelol.addTarget(self, action: "DidRefreshStrings", forControlEvents: UIControlEvents.ValueChanged)
        
        
    }

    
    @IBAction func unwindSegueMCL(segue: UIStoryboardSegue){
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.myTeacherArray.removeAll()
            self.myClassArray.removeAll()
            self.previewOP()
            self.tableView.reloadData()
        }
    }
    
    
    
    func DidRefreshStrings(){
        
        //this is me combining two different arrays, hitting two birds with one stone a me lad!!
        // this is vital to the follow function in DAC adding multiple arrays
        self.myClassArray.removeAll()
        self.myTeacherArray.removeAll()
        previewOP()

        self.tableView.reloadData()
        
        // This ends the loading indicator
        self.refreshControlelol.endRefreshing()
        
        print("REFRESHED")
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
    
    
    func previewOP(){
        self.LoadingDesign()
        self.queryMyClasses()
        
        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 1 * Int64(NSEC_PER_SEC))
        dispatch_after(time, dispatch_get_main_queue()) {
            //put your code which should be executed with a delay here
            
            self.removeLoading()
            
        }
    }
    
    
    
    func queryMyClasses(){
        
        let myClassQuery = PFQuery(className: "ClassesFollowed")
        
        //myClassQuery.whereKey("Username", equalTo: cUser!.username!)
        myClassQuery.whereKey("UserID", equalTo: cUser!.objectId!)
        if self.theSchool != nil{
            myClassQuery.whereKey("theSchool", equalTo: self.theSchool!)
        }else{
            print("theSchool equals nil")
        }
        myClassQuery.findObjectsInBackgroundWithBlock { (results: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil{
                
                if let results = results as [PFObject]?{
                    
                    for result in results{
                        
                        let myClass = result["classesFollowed"] as! String
                        let myTeacher = result["teacherName"] as! String
                        
                        self.myClassArray.append(myClass)
                        self.myTeacherArray.append(myTeacher)
                        
                        print(myClass)
                        print(myTeacher)
                        
                    }
                    self.tableView.reloadData()
                    sleep(1/2)
                    self.removeLoading()
                }
            }else{
                print("\(error) ..... \(error!.userInfo)")
                self.removeLoading()
            }
        }
        
    }
    
    func LoadingDesign(){
        
        let testFrame : CGRect = CGRectMake(0,0,self.view.frame.width,self.view.frame.height - 60)
        let testView : UIView = UIView(frame: testFrame)
        testView.backgroundColor = UIColor.whiteColor()
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
    

    
    func removeLoading(){
        if let viewWithTag = self.view.viewWithTag(90) {
            print("Tag 100")
            viewWithTag.removeFromSuperview()
        }
        else {
            print("tag not found")
        }
    }
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "moToFi"{
            let vc : FindClassViewController = segue.destinationViewController as! FindClassViewController
            
            //let miko = tableView.indexPathForSelectedRow?.row
            
            vc.theSchool = self.theSchool
            //vc.theTeacher = "\(myTeacherArray[miko!])"
            //vc.theClass = "\(myClassArray[miko!])"
        }else{
            let vc : AssignmentsTableViewController = segue.destinationViewController as! AssignmentsTableViewController
            
            let miko = tableView.indexPathForSelectedRow?.row
            vc.derp = "MCL"
            
            if self.proppie != nil{
                vc.proppie = self.proppie!
            }
            vc.theTeacher = "\(myTeacherArray[miko!])"
            vc.theClass = "\(myClassArray[miko!])"
        }
       
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return myClassArray.count
        if myClassArray.count > 0 {
            theSay = "yes"
            return myClassArray.count
        }else{
            theSay = "no"
            return 1
        }

    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if theSay == "yes"{
            let cell : MyClassTableViewCell = tableView.dequeueReusableCellWithIdentifier("mCcell", forIndexPath: indexPath) as! MyClassTableViewCell
            
            // Configure the cell...
            
            cell.classNameLabel.text = "\(myClassArray[indexPath.row])"
            cell.teacherLabel.text = "\(myTeacherArray[indexPath.row])"
            
            
            tableView.rowHeight = 80
            return cell

        }else{
            let cell : noMyClassCell = tableView.dequeueReusableCellWithIdentifier("nomyClass", forIndexPath: indexPath) as! noMyClassCell
            
            cell.findClassButton.layer.borderColor = teal.CGColor
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = 209
            
            // Configure the cell...
            
            return cell

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
