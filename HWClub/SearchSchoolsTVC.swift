//
//  SearchSchoolsTVC.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 1/7/16.
//  Copyright © 2016 Lyndon Samual McKay. All rights reserved.
//

import UIKit
import Parse

class SearchSchoolsTVC: UITableViewController, UISearchResultsUpdating, UINavigationBarDelegate {
    
    var schools = [String]()
    var locations = [String]()
    var qI = 0
    var allResults = [schoolio]()

    var cUser = PFUser.currentUser()
    
    var theSchool : String?
    
    var filterCollegeArray = [String]()
    var resultSearchController = UISearchController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        querySchools()
        
        
        
        
        self.resultSearchController = UISearchController(searchResultsController: nil)
        self.resultSearchController.dimsBackgroundDuringPresentation = false
        self.resultSearchController.searchBar.sizeToFit()
        self.resultSearchController.searchResultsUpdater = self
        
        self.tableView.tableHeaderView = self.resultSearchController.searchBar
        
        self.resultSearchController.hidesNavigationBarDuringPresentation = false;
        self.definesPresentationContext = false;
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func unwindSegueSS(){
        schools.removeAll()
        querySchools()
        tableView.reloadData()
    }
    
    func ststst(){
        while qI < 8{
            var t = self.qI + 1
            self.qI = t
            print(self.qI)
            querySchools()
        }
    }
    
    
    func querySchools(){
        let s = PFQuery(className: "Schools")
        
        if self.qI == 2{
            s.skip = 1000
            print("skipped")
        }
        if self.qI == 3{
            s.skip = 2000
            print("skipped")
        }
        if self.qI == 4{
            s.skip = 3000
            print("skipped")
        }
        if self.qI == 5{
            s.skip = 4000
            print("skipped")
        }
        if self.qI == 6{
            s.skip = 5000
            print("skipped")
        }
        if self.qI == 7{
            s.skip = 6000
            print("skipped")
        }
        if self.qI == 8{
            s.skip = 7000
            print("skipped")
        }
        
        
        
        s.limit = 1000
        s.orderByAscending("Title")
        s.findObjectsInBackgroundWithBlock { (results : [PFObject]?, error : NSError?) -> Void in
            
            if error == nil{
                
                if let results = results as [PFObject]?{
                    
                    for result in results{
                        let aSchool = schoolio()
                        
                        let SchoolName = result["Title"] as! String
                        let st = result["State"] as! String
                        let loci = result["City_County"] as! String
                        let locy = "\(loci), \(st)"
                        self.locations.append(locy)
                        self.schools.append(SchoolName)
                        aSchool.SchoolName = SchoolName
                        aSchool.location = locy
                        self.allResults.append(aSchool)
                        print(SchoolName)
                    }
                    
                }
                
                
            }
//            self.noarray = self.SchoolArray
            self.tableView.reloadData()
            
        }

    }
    
    
    
    func followNewSchoolBYSTRING(Title : String){
        if let currentUser = PFUser.currentUser(){
            currentUser["School"] = Title
            currentUser["setUP"] = "yes"
            //set other fields the same way....
            currentUser.saveInBackground()
//            self.seggy()
            self.resultSearchController.searchBar.endEditing(true)
            self.resultSearchController.active = false

//            self.resultSearchController
            seggy()
            //performSegueWithIdentifier("getin", sender: nil)
        }else{
            print("folow new school error")
        }
    }

    
    
    func followNewSchool(row : Int){
        if let currentUser = PFUser.currentUser(){
            currentUser["School"] = self.schools[row]
            currentUser["setUP"] = "yes"
            //set other fields the same way....
            currentUser.saveInBackground()
            self.seggy()
        }else{
            print("folow new school error")
        }
    }
    
    func seggy(){
        LoadingDesign()
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        
        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 2 * Int64(NSEC_PER_SEC))
        dispatch_after(time, dispatch_get_main_queue()) {
            
            let vc: SWRevealViewController = storyboard.instantiateViewControllerWithIdentifier("homeR") as! SWRevealViewController
            self.presentViewController(vc, animated: true, completion: nil)
        }
        
    }
    
    
    
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (self.resultSearchController.active) {
            return  filterCollegeArray.count
        }else{
            return allResults.count
        }
    }

    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : SearchSchoolCell = tableView.dequeueReusableCellWithIdentifier("scol", forIndexPath: indexPath) as! SearchSchoolCell

        // Configure the cell...
//        if (self.resultSearchController.active) {
//            cell.SchoolLabel?.text = self.filterCollegeArray[indexPath.row]
//            
//            return cell
        if (self.resultSearchController.active) {
            cell.SchoolLabel?.text = self.filterCollegeArray[indexPath.row]//.classname as (String)
            let miss = self.filterCollegeArray[indexPath.row]
            if schools.contains(miss) == true{
                let trex = schools.indexOf(miss)
                //mikes[4]
                let theMix = locations[trex!]
                cell.LocationLabel?.text = theMix
                //                cell.teacherLabel?.text = self.filteredResults[indexPath.row]//.classname as (String)
            }
            return cell

            
        } else {
            
            cell.SchoolLabel?.text = self.schools[indexPath.row]
            cell.LocationLabel.text = self.locations[indexPath.row]

            return cell
            
        }

        //cell.SchoolLabel.text = self.schools[indexPath.row]
        
        
      //  return cell
    }
    
  
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        unfollowClass()
        if (self.resultSearchController.active) {
            let cO = self.allResults[indexPath.row]
//            sendC = cO.classname
            let cell : SearchSchoolCell = tableView.cellForRowAtIndexPath(indexPath) as! SearchSchoolCell
            
            followNewSchoolBYSTRING(cell.SchoolLabel.text!)
            
        }else{
            if let row = tableView.indexPathForSelectedRow?.row{
                self.followNewSchool(row)
            }
        }

    }
    
    
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        self.filterCollegeArray.removeAll(keepCapacity: false)
        
        
        let searchPredicate = NSPredicate(format: "SELF CONTAINS [c] %@", searchController.searchBar.text!)
        
        
        
        let array = (self.schools as NSArray).filteredArrayUsingPredicate(searchPredicate)
        
        self.filterCollegeArray = array as! [String]
        
        if array.count < 20 {
            print("ALERT")
        }
        
        print("CHECK!CHECK!CHECK!")
        
        self.tableView.reloadData()
        
        
        
    }
    
    
    
    
    func unfollowClass(){
        //        print("Class Unfollowed")
        let Class = PFQuery(className: "ClassesFollowed")
        Class.whereKey("UserID", equalTo: (cUser?.objectId)!)
        if self.theSchool != nil{
            //            Class.whereKey("School", equalTo: self.theSchool!)
        }
        //Class.whereKey("Username", equalTo: "\((cUser?.username)!)")
        Class.findObjectsInBackgroundWithBlock { (results:[PFObject]?, error:NSError?) -> Void in
            if error == nil{
                if let results = results as [PFObject]?{
                    for result in results{
                        let theIdo = result.objectId
                        if theIdo != nil{
                            self.deleteThatClass(theIdo!)
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
            print("ALLClassesUnfollowed")
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
