//
//  SidebarViewController.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 9/24/15.
//  Copyright © 2015 Lyndon Samual McKay. All rights reserved.
//

import UIKit
import Parse

class SidebarViewController: UITableViewController, SidebarDelegate {

    @IBOutlet var SchoolLabel: UILabel!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var proPic: UIImageView!
    var imagePicker: UIImagePickerController!
    @IBOutlet var notiNumLabel: UILabel!
    
    var oldPic : PFFile?
    var ido : String?
    var newPic : UIImage?
    
    var theSchool : String?
    var txt : String?
    var sentIMG : UIImage?
    var sendingIMG : Bool?
    
    var user : String?
    
    let cUser = PFUser.currentUser()

    let yy = CH_Username()
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        yy.delegate = self

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        yy.delegate = self

        notiNumLabel.layer.cornerRadius = 16
        notiNumLabel.layer.masksToBounds = true
        if cUser != nil{
            usernameLabel.text = "@\((cUser?.username)!)"
        }
        userInfoQuery()
        queryNotiis()
        self.notiNumLabel.alpha = 0
        
        
        
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
        return 5
    }

    
    func userInfoQuery(){
        
        yy.delegate = self
        
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
                            self.SchoolLabel.text = thisSchool!
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
            //self.profilePictureButton.setImage(image, forState: .Normal)
            self.proPic.image = image!
            self.proPic.layer.cornerRadius = 26
            self.proPic.layer.masksToBounds = true
            self.proPic.layer.borderWidth = 2
            self.proPic.layer.borderColor = UIColor.whiteColor().CGColor

        }
    }

    
    func queryNotiis(){
        
        yy.delegate = self

        let qN = PFQuery(className: "Notifications")
        qN.whereKey("getterID", equalTo: (cUser?.objectId)!)
        qN.whereKey("recieved", equalTo: false)
        qN.orderByDescending("createdAt")
        qN.findObjectsInBackgroundWithBlock { (results: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil{
                
                if let results = results as [PFObject]?{
                    self.notiNumLabel.text = "\(results.count)"
                    
                }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}