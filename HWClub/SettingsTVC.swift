//
//  SettingsTVC.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 12/25/15.
//  Copyright © 2015 Lyndon Samual McKay. All rights reserved.
//

import UIKit
import Parse

class SettingsTVC: UITableViewController {

    
    @IBOutlet var logoutButton: UIButton!
    @IBOutlet var menuButton: UIBarButtonItem!
    @IBOutlet var navi: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        
        logoutButton.layer.cornerRadius = 8
        logoutButton.layer.masksToBounds = true

        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    @IBAction func unwindSegueSettings(segue: UIStoryboardSegue){
        print("back to settings")
    }
    
    
    func Verify(){
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc: WelcomeVC = storyboard.instantiateViewControllerWithIdentifier("Welcoming") as! WelcomeVC
        self.presentViewController(vc, animated: true, completion: nil)
        
    }

    
    
    @IBAction func logout(sender: AnyObject) {
        print("Are You Sure")
        
        
        
        let alertView = UIAlertController(title: "Are you sure?", message: "Do you really want to logout?", preferredStyle: .Alert)
        alertView.addAction(UIAlertAction(title: "Logout", style: .Destructive, handler: { (alertAction) -> Void in
            
            print("logged Out")
            self.logUserOut()
        }))
        alertView.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        presentViewController(alertView, animated: true, completion: nil)


    }
    
    func logUserOut(){
        
                if PFUser.currentUser()!.username != nil{
                    // move to front page and delete sqlite data
        
                    let clear = SD.deleteTable("Login")
        
                    if let _ = SD.createTable("Login", withColumnNamesAndTypes: ["username": .StringVal, "password": .StringVal]){
                    }else{
                        // Created DataTable
                        print("Created Table")
                        self.Verify()
                    }
                    
                    
                    
                }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2//4
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch(section){
          
        case 0:
            return 1
            
        case 1:
            return 3//4//3
            
        case 2:
            return 3
            
        case 3:
            return 5
            
        default:
            return 0
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
