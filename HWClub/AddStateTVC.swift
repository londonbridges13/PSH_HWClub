//
//  AddStateVC.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 1/7/16.
//  Copyright © 2016 Lyndon Samual McKay. All rights reserved.
//

import UIKit
import Parse

class AddStateTVC: UITableViewController {

    var SchoolName : String?
    var theState : String?
    var City_County : String?
    
    var States = ["Alabama",
        "Alaska",
        "Arizona",
   "Arkansas",
    "California",
     "Colorado",
      "Connecticut",
       "Delaware",
        "Florida",
"Georgia",
 "Hawaii",
  "Idaho",
   "Illinois",
    "Indiana",
     "Iowa",
      "Kansas",
       "Kentucky",
        "Louisiana",
"Maine",
"Maryland",
"Massachusetts",
 "Michigan",
  "Minnesota",
   "Mississippi",
    "Missouri",
     "Montana",
      "Nebraska",
       "Nevada",
        "New Hampshire",
"New Jersey",
 "New Mexico",
  "New York",
   "North Carolina",
    "North Dakota",
     "Ohio",
      "Oklahoma",
        "Oregon",
        "Pennsylvania",
        "Rhode Island",
        "South Carolina",
        "South Dakota",
        "Tennessee",
        "Texas",
        "Utah",
        "Vermont",
        "Virginia",
        "Washington",
        "West Virginia",
        "Wisconsin",
        "Wyoming",

]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func addSchool(){
        let aS = PFObject(className: "Schools")
            aS["Title"] = self.SchoolName!
            aS["City_County"] = self.City_County!
            aS["State"] = self.theState!
        aS.saveInBackgroundWithBlock { (success:Bool, error:NSError?) -> Void in
            if success == true{
                print("Saved, move on")
                self.followNewSchool()
            }else{
                print(error?.description)
            }
        }

    }
    
    
    func followNewSchool(){
        if let currentUser = PFUser.currentUser(){
            currentUser["School"] = self.SchoolName!
            currentUser["setUP"] = "yes"
            //set other fields the same way....
            currentUser.saveInBackground()
            self.seggy()
        }else{
            print("folow new school error")
        }
    }
    
    func seggy(){
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc: SWRevealViewController = storyboard.instantiateViewControllerWithIdentifier("homeR") as! SWRevealViewController
        self.presentViewController(vc, animated: true, completion: nil)
        
    }

    
    
    
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return States.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("stater", forIndexPath: indexPath)
    
    // Configure the cell...
        
        cell.textLabel!.text = self.States[indexPath.row]
        
    
    return cell
    }
    

    
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        let row = tableView.indexPathForSelectedRow?.row
        self.theState = cell?.textLabel?.text
        
        if self.theState != nil{
            theState = States[row!]
            addSchool()
        }
        
    }
    
    
    
    
    
    

}
