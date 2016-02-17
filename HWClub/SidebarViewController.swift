//
//  SidebarViewController.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 9/24/15.
//  Copyright © 2015 Lyndon Samual McKay. All rights reserved.
//

import UIKit
import Parse

class SidebarViewController: UITableViewController{//, SidebarDelegate {

//    @IBOutlet var SchoolLabel: UILabel!
//    @IBOutlet var usernameLabel: UILabel!
//    @IBOutlet var proPic: UIImageView!
    var imagePicker: UIImagePickerController!
//    @IBOutlet var notiNumLabel: UILabel!
    
    var myTeacherArray : [String] = [String]()
    var myClassArray : [String] = [String]()
    var uniq : [String] = [String]()
    
    var oldPic : PFFile?
    var ido : String?
    var newPic : UIImage?
    
    var notinum = 0
    var theSchool : String?
    var txt : String?
    var sentIMG : UIImage?
    var sendingIMG : Bool?
    
    var theClass : String?
    var theTeacher : String?
    var user : String?
    
    let cUser = PFUser.currentUser()

    let yy = CH_Username()
    
    var tealler = UIColor(red: 9/255, green: 209/255, blue: 196/255, alpha: 1)
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.myClassArray.removeAll()
        self.myTeacherArray.removeAll()
        
        view.endEditing(true)

//        tableView.setContentOffset(CGPointZero, animated:true)

//        yy.delegate = self

        queryMyClasses()
        queryNotiis()
        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 3/13 * Int64(NSEC_PER_SEC))
        dispatch_after(time, dispatch_get_main_queue()) {
            self.view.endEditing(false)
        }
//        tableView.setContentOffset(CGPointZero, animated:true)

    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
//        tableView.reloadData()

//        tableView.setContentOffset(CGPointZero, animated:true)
//        tableView.setContentOffset(CGPoint(x: 0, y: 20), animated:true)

        print("Gone")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        tableView.setContentOffset(CGPoint(x: 0, y: -20), animated:true)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
        view.endEditing(true)
//        yy.delegate = self

//        notiNumLabel.layer.cornerRadius = 16
//        notiNumLabel.layer.masksToBounds = true
        if cUser != nil{
//            usernameLabel.text = "@\((cUser?.username)!)"
        }
        let _ = userInfoQuery()
//        UIApplication.sharedApplication().endIgnoringInteractionEvents()

//        if self.notiNumLabel.text == "0"{
//            self.notiNumLabel.alpha = 0 //0
//        }
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1//2 //1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4 + myClassArray.count // myClassArray.count + 4     //5
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
//        if indexPath.section == 0{
            if indexPath.row == 0{
                let cell : SideBarSchoolCell = tableView.dequeueReusableCellWithIdentifier("sideSchool", forIndexPath: indexPath) as! SideBarSchoolCell
                tableView.rowHeight = 116
                cell.proPic.layer.cornerRadius = 26
                cell.proPic.layer.masksToBounds = true
                cell.proPic.layer.borderWidth = 2
                cell.proPic.layer.borderColor = UIColor.whiteColor().CGColor
                
                if self.newPic != nil{
                    cell.proPic.image = self.newPic
                }
                if self.theSchool != nil{
                    cell.SchoolLabel.text = self.theSchool!
                }
                if cUser?.username != nil{
                    cell.usernameLabel.text = cUser!.username!
                }
                return cell

            }else if indexPath.row == 1{
                let cell = tableView.dequeueReusableCellWithIdentifier("sideHome", forIndexPath: indexPath)
                tableView.rowHeight = 79
                return cell
            }else if indexPath.row == 2{
                let cell : SideBarNotiCell = tableView.dequeueReusableCellWithIdentifier("sideNoti", forIndexPath: indexPath) as! SideBarNotiCell
                        cell.notiLabel.layer.cornerRadius = 16
                        cell.notiLabel.layer.masksToBounds = true
                if self.notinum == 0 {
                    cell.notiLabel.alpha = 0
                }else{
                    cell.notiLabel.text = "\(notinum)"
                    cell.notiLabel.alpha = 1
                }
                tableView.rowHeight = 79
                return cell
            }else if indexPath.row == 3{
                let cell = tableView.dequeueReusableCellWithIdentifier("sidefinder", forIndexPath: indexPath)
                tableView.rowHeight = 79
                return cell
            
//            }else if indexPath.row == 4{
//                let cell = tableView.dequeueReusableCellWithIdentifier("sidemyCdire", forIndexPath: indexPath)
//                tableView.rowHeight = 79
//                return cell
////        }else{
            }else{
                let cell : SidebarMyClassCell = tableView.dequeueReusableCellWithIdentifier("sideMyClass", forIndexPath: indexPath) as! SidebarMyClassCell
                tableView.rowHeight = 79
                if myClassArray.count >= indexPath.row - 4 && myTeacherArray.count >= indexPath.row - 4{
                    if myClassArray.count != 0{
                        cell.myClassLabel.text = "  - \(self.myClassArray[indexPath.row - 4])"
                        cell.theTeacher = self.myTeacherArray[indexPath.row - 4]
                        cell.theClass = self.myClassArray[indexPath.row - 4]
                    }
                    cell.userInteractionEnabled = true
                }else{
//                    cell.userInteractionEnabled = false
                }
                return cell
            }
//        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row > 4{
            let cell : SidebarMyClassCell = tableView.dequeueReusableCellWithIdentifier("sideMyClass", forIndexPath: indexPath) as! SidebarMyClassCell
            tableView.rowHeight = 79

            self.theTeacher = cell.theTeacher
            self.theClass = cell.theClass
            
            if theClass != nil && theTeacher != nil{
                print("GOOD TO GO CLASS")
//                performSegueWithIdentifier("Sidebar Class", sender: self)
            }
        }
    }
    
    
    func userInfoQuery(){
        
//        yy.delegate = self
        
        let qUser = PFQuery(className: "_User")
        qUser.whereKey("username", equalTo: (cUser?.username)!)
        qUser.findObjectsInBackgroundWithBlock { (results :[PFObject]?, error:NSError?) -> Void in
            if error == nil{
                if let results = results as [PFObject]?{
                    for result in results{
                        let thePic = result["profilePic"] as? PFFile
                        let thisSchool = result["School"] as? String
                        let theIDO = result.objectId
                        self.ido = theIDO!
                        if thisSchool != nil{
//                            self.SchoolLabel.text = thisSchool!
                            self.theSchool = thisSchool
                        }else{
                            print("No School Found")
                        }
                        if thePic != nil{
                            self.oldPic = thePic!
                            self.displayUserPic(self.oldPic!)
                        }else{
                            print("NO USER PIC")
                        }
                    }
                }
            }
        }
    }
    
    func displayUserPic(pfdata:PFFile){
        pfdata.getDataInBackgroundWithBlock { (theData: NSData?, error: NSError?) -> Void in
            let image = UIImage(data: theData!)
            self.newPic = image!
            self.tableView.reloadData()
//            self.proPic.image = image!
//            self.proPic.layer.cornerRadius = 26
//            self.proPic.layer.masksToBounds = true
//            self.proPic.layer.borderWidth = 2
//            self.proPic.layer.borderColor = UIColor.whiteColor().CGColor

        }
    }

    
    func queryNotiis(){
        
//        yy.delegate = self

        let qN = PFQuery(className: "Notifications")
        qN.whereKey("getterID", equalTo: (cUser?.objectId)!)
        qN.whereKey("recieved", equalTo: false)
        qN.orderByDescending("createdAt")
        qN.findObjectsInBackgroundWithBlock { (results: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil{
                
                if let results = results as [PFObject]?{
                    self.notinum = results.count
                    self.tableView.reloadData()
//                    UIApplication.sharedApplication().endIgnoringInteractionEvents()

//                    self.notiNumLabel.text = "\(results.count)"
//                    self.notiNumLabel.alpha = 1 //0
                    if results.count == 0 {
                        self.view.endEditing(false)
                        UIApplication.sharedApplication().endIgnoringInteractionEvents()

//                        self.notiNumLabel.alpha = 0
                    }
                }
            }
        }
    }
    
    
    
//    
//    func revealController(revealController: SWRevealViewController!, didMoveToPosition position: FrontViewPosition) {
//        if(position.rawValue == 4)
//        {
//            //move to rear
//            self.revealViewController().frontViewController.view.userInteractionEnabled =  false
//            print("JKJKJKJKJ")
//        }
//        else if (position.rawValue == 3)
//        {
//            //move to front - dashboard VC
//            self.revealViewController().frontViewController.view.userInteractionEnabled =  true
//        }
//    }
//    func revealController(revealController: SWRevealViewController!, willMoveToPosition position: FrontViewPosition) {
//        
//        //will perform the same function as the above delegate method.
//    }

    
    
    
    func queryMyClasses(){
//
//        self.myClassArray.removeAll()
//        self.myTeacherArray.removeAll()
        
        let myClassQuery = PFQuery(className: "ClassesFollowed")
//        myClassQuery.whereKey("teacherName", containedIn: myTeacherArray)
        myClassQuery.whereKey("UserID", equalTo: cUser!.objectId!)
        if self.theSchool != nil{
            //            myClassQuery.whereKey("School", equalTo: self.theSchool!)
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
                        
                        print("GOT MILK")
                        print(myClass)
                        print(myTeacher)
//                        self.tableView.reloadData()
                        
                    }
//                    self.tableView.reloadData()
                    self.sortIt()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    self.view.endEditing(false)

                }
            }else{
                print("\(error) ..... \(error!.userInfo)")
            }
        }
        
    }
    

    func sortIt(){
        
        //        hPosts.removeAll()
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
        
        //        if self.cachedPosts.count > 1{
        if self.myClassArray.count > 1{
            print("rerere")
            //            print(self.hPosts[0].date)
            //            print(self.hPosts[0].date)
            print(myClassArray.count)
            var checker = [String]()
            
            for each in myClassArray{
                //            for each in hPosts{
                if checker.contains(each) == false {//&& each.date!.isGreaterThan(self.wAgo) == true{// && each.date! >= self.wAgo {
                    checker.append(each)
                    uniq.append(each)
                    print(myClassArray.count)
                    print(myClassArray.count)
                }else{
                    print("WE GOTONE")
                }
                //                }
            }
            self.myClassArray = uniq
            //            displayedPosts.addObjectsFromArray(allPosts.subarrayWithRange(NSMakeRange(0, 6)))
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
            })
            
            uniq.removeAll()
            //            cachedPosts.removeAll
            print("reloaded")
        }
    }
    

    
    
    
    
    
    
    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
            if segue.identifier == "Sidebar Class"{
                let navi : AssNAVI = segue.destinationViewController as! AssNAVI
                
                let vc = navi.viewControllers.first as! AssignmentsTableViewController
                
                //            let vc : AssignmentsTableViewController = segue.destinationViewController as! AssignmentsTableViewController
                
                let miko = tableView.indexPathForSelectedRow!.row - 4
                vc.derp = "KLM" // Might need to change
                
                if self.oldPic != nil{
                    vc.proppie = self.oldPic!
                }
                
                vc.theSchool = self.theSchool!
                if theClass != nil && theTeacher != nil{
                    print("Cloud FLOW")
                    vc.theTeacher = theTeacher
                    vc.theClass = theClass
                }else{
                    print("From Source")
//                    if myTeacherArray[miko] != ""{
                    if myTeacherArray.count != 0{
                        vc.theTeacher = "\(myTeacherArray[miko])"
                    }else{
                         vc.theTeacher = "Error"
                    }
                    if myClassArray.count != 0{
                        vc.theClass = "\(myClassArray[miko)"
                    }else{
                        vc.theClass = "Bad Internet Connection"
                    }
//                    }
                }
            }
        if segue.identifier == "toNOTI"{
            let vvc : notiNAVI = segue.destinationViewController as! notiNAVI
            let vc : NotiTVC = vvc.viewControllers.first as! NotiTVC
            if newPic != nil{
                vc.proppie = self.newPic!
            }
            if self.theSchool != nil{
                vc.School = theSchool
            }
        }
    }
    

}
