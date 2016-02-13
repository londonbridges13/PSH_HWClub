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
    
    var oldPic : PFFile?
    var ido : String?
    var newPic : UIImage?
    
    var notinum = 0
    var theSchool : String?
    var txt : String?
    var sentIMG : UIImage?
    var sendingIMG : Bool?
    
    var user : String?
    
    let cUser = PFUser.currentUser()

    let yy = CH_Username()
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//        tableView.setContentOffset(CGPointZero, animated:true)

//        yy.delegate = self
        queryMyClasses()
        queryNotiis()
        
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
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()

//        yy.delegate = self

//        notiNumLabel.layer.cornerRadius = 16
//        notiNumLabel.layer.masksToBounds = true
        if cUser != nil{
//            usernameLabel.text = "@\((cUser?.username)!)"
        }
        userInfoQuery()
        UIApplication.sharedApplication().endIgnoringInteractionEvents()

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
                if myClassArray.count != 0{
                    cell.myClassLabel.text = "- \(self.myClassArray[indexPath.row - 4])"
                }
                return cell
            }
//        }
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
//                    self.notiNumLabel.text = "\(results.count)"
//                    self.notiNumLabel.alpha = 1 //0
                    if results.count == 0 {
//                        self.notiNumLabel.alpha = 0                        
                    }
                }
            }
        }
    }
    
    
    
    
    
    
    func queryMyClasses(){

        self.myClassArray.removeAll()
        self.myTeacherArray.removeAll()
        
        let myClassQuery = PFQuery(className: "ClassesFollowed")
        
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
                        self.tableView.reloadData()
                        
                    }
                    self.tableView.reloadData()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                }
            }else{
                print("\(error) ..... \(error!.userInfo)")
            }
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
            
            let miko = (tableView.indexPathForSelectedRow?.row)! - 4
            vc.derp = "KLM" // Might need to change
            
            if self.oldPic != nil{
                vc.proppie = self.oldPic!
            }
            vc.theTeacher = "\(myTeacherArray[miko])"
            vc.theClass = "\(myClassArray[miko)"
            vc.theSchool = self.theSchool!
        }
    }
    

}
