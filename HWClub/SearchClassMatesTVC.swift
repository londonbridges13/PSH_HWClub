//
//  SearchClassMatesTVC.swift
//  Dac
//
//  Created by Lyndon Samual McKay on 5/30/16.
//  Copyright © 2016 Lyndon Samual McKay. All rights reserved.
//

import UIKit
import Parse


class SearchClassMatesTVC: UITableViewController {

    
    var students = [String]()
    var School : String?
    var AllClasses = [String]()
    var AllTeachers = [String]()
    var cUser = PFUser.currentUser()
    var Classmates = [MemberObject]()
    var Classes = [ClassObject]()
    
    var selectedArray = [String]()
    
    // Segued ZStuff
    var theClass : String?
    var theTeacher : String?
    var proppie : PFFile?
    
    
    //Button
    
    @IBOutlet var ddd: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.allowsMultipleSelection = true

        Phase1()
        
        
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
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Classmates.count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.Checkmark
        //Append to another array (at indexpath.row)
        
        self.selectedArray.append(self.Classmates[indexPath.row].userID!)
        print("Added \(self.Classmates[indexPath.row].userID!) to Selected Array")
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.None
        // if it is found in the selectedArray, take it out
        
        var leaveID = self.Classmates[indexPath.row].userID
        
        if self.selectedArray.contains(leaveID!) == true{
            print("We got her, taking \(leaveID!) out now")
            var byeID = self.selectedArray.indexOf(leaveID!)
            self.selectedArray.removeAtIndex(byeID!)
            print("Just removed \(leaveID!) at index: \(byeID!)")
            print("Selected Array : \(self.selectedArray)")
        }
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : ClassmateCell = tableView.dequeueReusableCellWithIdentifier("cclassmat", forIndexPath: indexPath) as! ClassmateCell
        // Configure the cell...
        
        tableView.rowHeight = 77

        if Classmates[indexPath.row].username != nil{
            cell.nameLabel.text = Classmates[indexPath.row].username
        }
        if Classmates[indexPath.row].proCachy != nil{
            cell.profilePic.image = Classmates[indexPath.row].proCachy!
            
            cell.profilePic.layer.cornerRadius = 28
            cell.profilePic.layer.masksToBounds = true
        }
        
        
        return cell
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

    
    
    
    
    
    
    
    
    
    
    func Phase1(){
        // Query all User's Classes
        print("Phase 1 intiated")
        let Class = PFQuery(className: "ClassesFollowed")
        print(cUser!.objectId!)
        Class.whereKey("UserID", equalTo: (cUser?.objectId)!) //sketch
        Class.findObjectsInBackgroundWithBlock { (results:[PFObject]?, error:NSError?) -> Void in
            if error == nil{
                if let results = results as [PFObject]?{
                    if results.count == 0{
                        print("You Have No Friends")
                    }
                    for result in results{
                        var cO = ClassObject()
                        
                        let myClass = result["classesFollowed"] as? String
                        let myTeacher = result["teacherName"] as? String
//                        let myClassID = result.objectId!
                        
                        
                        if myClass != nil{
                            cO.classname = myClass!
                            self.AllClasses.append(myClass!)
                        }else{
                            cO.classname = "myClass!"
                        }
                        if myTeacher != nil{
                            cO.teachername = myTeacher!
                            self.AllTeachers.append(myTeacher!)
                        }else{
                            cO.teachername = "myClass!"
                        }

                        self.Classes.append(cO)
                        print("Added One p1")
                    }
                    self.view.userInteractionEnabled = true
                    
//                    self.Phase2()

                }
            }else{
                print(error.debugDescription)
            }
            
            self.Phase2()
        }

    }
    
    
    
    
    
    func Phase2(){
        // Find Other Classmates
        print("Phase 2 intiated")
        let Class = PFQuery(className: "ClassesFollowed")
        print(cUser!.objectId!)
        Class.whereKey("School", equalTo: self.School!)
        Class.whereKey("teacherName", containedIn: AllTeachers)
        Class.whereKey("classesFollowed", containedIn: AllClasses)
        
        Class.findObjectsInBackgroundWithBlock { (results:[PFObject]?, error:NSError?) -> Void in
            if error == nil{
                if let results = results as [PFObject]?{
                    if results.count == 0{
                        print("You Have No Friends")
                    }
                    for result in results{
                        
                        let myClassID = result["UserID"] as! String
                        print(myClassID)
                        print("cheese")
                        self.students.append(myClassID)
                        
                        print("Added One p2")

                    }
                    self.view.userInteractionEnabled = true
                    
                }
            }else{
                print(error.debugDescription)
            }
            let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 1 * Int64(NSEC_PER_SEC))
            dispatch_after(time, dispatch_get_main_queue()) {
                self.Phase3()
            }
        }

    }
    
    
    
    
    
    
    
    func Phase3(){
        // Find Other Classmates
        print("Phase 3 intiated")
        let Class = PFQuery(className: "_User")
        print(cUser!.objectId!)
        Class.whereKey("objectId", containedIn: self.students)
        
        Class.findObjectsInBackgroundWithBlock { (results:[PFObject]?, error:NSError?) -> Void in
            if error == nil{
                if let results = results as [PFObject]?{
                    if results.count == 0{
                        print("You Have No Friends")
                    }
                    for result in results{
                        var cO = MemberObject()

                        
                        let name = result["username"] as? String
                        let propic = result["profilePic"] as? PFFile
                        let ido = result.objectId
                        
                        cO.userID = ido!
                        
                        if name != nil{
                            cO.username = name!
                            print(name!)
                        }else{
                            cO.username = "name!"
                        }
                        
                        
                        if propic != nil{
                            cO.pp = propic!
                            self.Classmates.append(cO)

                                dispatch_async(dispatch_queue_create("underground", nil)) {
                                    //                                self.getProIMG(aPic!, objy: result.objectId!)
                                }
                                let nninn = dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)
                                dispatch_async(nninn, { () -> Void in
                                    
                                    cO.pp?.getDataInBackgroundWithBlock({ (theData:NSData?, error:NSError?) -> Void in
                                        
                                        if theData != nil{
                                            let img = UIImage(data: theData!)!
                                            
                                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                                
                                                cO.proCachy = img
                                                self.tableView.reloadData()
                                                
                                                print("YEYEYEYEYEYEYEY")
                                                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                                    self.tableView.reloadData()
                                                })
                                                //                                            self.removeLoading()
                                                
                                            })
                                            
                                        }
                                    })
                                    
                                })
                            }

                        
                        
                    }
                    print("Added One p3")

                    self.view.userInteractionEnabled = true
                    self.tableView.reloadData()

                    
                }
            }else{
                print(error.debugDescription)
            }
            self.tableView.reloadData()
            print(self.Classmates.count)
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func pressedDone(sender: AnyObject) {
        print("pressed Done")
        sendNotifsInvites()
    }
    
    
    
    
    
    func sendNotifsInvites(){
        
        print("Sending Invites")
        
        let cUser = PFUser.currentUser()
        
        let noti = PFObject(className: "Notifications")
        noti["recieved"] = false
        noti["gettersIDs"] = selectedArray
        noti["notiType"] = "Invite"
        noti["giverUserName"] = "\((cUser!.username)!)"
        if School != nil{
            noti["School"] = self.School!
        }
        if theClass != nil{
            noti["classname"] = self.theClass!
        }
        if theTeacher != nil{
            noti["teacherName"] = self.theTeacher!
        }
        noti["profilePic"] = proppie
        noti["thePic"] = proppie  // setting this up to aviod error
        // SCHOOL Doesn't matter for comments
        noti.saveInBackgroundWithBlock({ (success:Bool, error:NSError?) -> Void in
            if (success == true){
                print("Notified Users, and Done")
                self.ddd.sendActionsForControlEvents(.TouchUpInside)
            }else{
                print(error?.description)
            }
        })

        
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
