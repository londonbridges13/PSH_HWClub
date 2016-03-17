//
//  SearchTVC.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 12/20/15.
//  Copyright © 2015 Lyndon Samual McKay. All rights reserved.
//

import UIKit
import Parse


class SearchTVC: UITableViewController, UISearchResultsUpdating, UINavigationBarDelegate {

    var sendC : String?
    var sendT : String?
    var School : String?
    var allClasses = [String]()
    var allTeachers = [String]()
    var allResults = [ClassObject]()
    var filteredResults = [String]()
    var resultSearchController = UISearchController()
    var qI = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        allResults.removeAll()
        
        let _ = ststst()
        
        
        self.resultSearchController = UISearchController(searchResultsController: nil)
        self.resultSearchController.dimsBackgroundDuringPresentation = false
        self.resultSearchController.searchBar.sizeToFit()
        self.resultSearchController.searchResultsUpdater = self
        
        self.tableView.tableHeaderView = self.resultSearchController.searchBar
        
        self.resultSearchController.hidesNavigationBarDuringPresentation = false;
        self.definesPresentationContext = false;
        
        self.tableView.reloadData()
        
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
//        view.addGestureRecognizer(tap)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        dismissKeyboard()
    }
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
        resultSearchController.resignFirstResponder()
        resultSearchController.active = false
    }
    
    
    
    
    func ststst(){
        while qI < 8{
            var t = self.qI + 1
            self.qI = t
            print(self.qI)
            let _ = classSearch()
        }
    }

    
    func classSearch(){
        let mike = PFQuery(className: "Classes")
        if School != nil{
            mike.whereKey("School", equalTo: self.School!)  // when you build the profile for universal use
        }
        if self.qI == 2{
            mike.skip = 1000
            print("skipped")
        }
        if self.qI == 3{
            mike.skip = 2000
            print("skipped")
        }
        if self.qI == 4{
            mike.skip = 3000
            print("skipped")
        }
        if self.qI == 5{
            mike.skip = 4000
            print("skipped")
        }
        if self.qI == 6{
            mike.skip = 5000
            print("skipped")
        }
        if self.qI == 7{
            mike.skip = 6000
            print("skipped")
        }
        if self.qI == 8{
            mike.skip = 7000
            print("skipped")
        }
        
        mike.limit = 1000
        mike.orderByAscending("classname")
        mike.findObjectsInBackgroundWithBlock { (results:[PFObject]?, error:NSError?) -> Void in
            if error == nil{
                if let results = results as[PFObject]?{
                    var io = 0 // your original ID

                    for result in results{
                        let cObject = ClassObject()
                        if let aClass = result["classname"] as? String{
                            print(aClass)
                            cObject.classname = aClass
                        }
                        if let aTeacher = result["teacherName"] as? String{
                            print(aTeacher)
                            cObject.teachername = aTeacher
                        }
                        
                        cObject.idrow = io
                        print(cObject.idrow)

                        self.allResults.append(cObject)
                        io += 1
                        print(io)
                        
                    }
                }
                self.tableView.reloadData()
            }else{
                print(error?.description) // try her out
            }
        }
        
    }
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        view.endEditing(false)

        if self.resultSearchController.active {
            return self.filteredResults.count
        }else{
            
            return self.allResults.count
        }

    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let row = tableView.indexPathForSelectedRow?.row
        let cell : SearchCell = tableView.dequeueReusableCellWithIdentifier("searchcell", forIndexPath: indexPath) as! SearchCell
        
        if (self.resultSearchController.active) {
            cell.classLabel?.text = self.filteredResults[indexPath.row]//.classname as (String)
            let miss = self.filteredResults[indexPath.row]
            if allClasses.contains(miss) == true{
                var trex = allClasses.indexOf(miss)
                //mikes[4]
                let theMix = allTeachers[trex!]
                cell.teacherLabel?.text = theMix
//                cell.teacherLabel?.text = self.filteredResults[indexPath.row]//.classname as (String)
            }
            return cell
            
            
        } else {
            
            cell.classLabel?.text = self.allResults[indexPath.row].classname as (String)
            cell.teacherLabel?.text = self.allResults[indexPath.row].teachername//.classname as (String)

            return cell
            
        }

    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Selected")
        
        let cO = self.allResults[indexPath.row]
        sendC = cO.classname
        sendT = cO.teachername
        let cell : SearchCell = tableView.cellForRowAtIndexPath(indexPath) as! SearchCell
        
        sendC = cell.classLabel.text
        sendT = cell.teacherLabel.text
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.performSegueWithIdentifier("searchToAss", sender: nil)
        }
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        searchController.searchBar.tintColor = UIColor.whiteColor()
        self.filteredResults.removeAll(keepCapacity: false)
        
        
        let searchPredicate = NSPredicate(format: "SELF CONTAINS [c] %@", searchController.searchBar.text!)
//        var allClasses = [String]()
        allClasses.removeAll()
        for aClass in allResults{
            allClasses.append(aClass.classname as (String))
        }
        for aTeacher in allResults{
            allTeachers.append(aTeacher.teachername as (String))
        }
        
        let array = (allClasses as NSArray).filteredArrayUsingPredicate(searchPredicate)
        
        self.filteredResults = array as! [String]
        
        
        if array.count < 20 {
            print("ALERT")
        }
        
        print("CHECK!CHECK!CHECK!")
        
        self.tableView.reloadData()
        

    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc : OtherAssignmentsTableViewController = segue.destinationViewController  as! OtherAssignmentsTableViewController
        self.resultSearchController.active = false
        let row = tableView.indexPathForSelectedRow?.row
        
        for cname in allResults{
            
        }
        var id : Int?
        
        //if (self.resultSearchController.active) {
            vc.theSchool = self.School
            vc.theClass = sendC
            vc.theTeacher = sendT
        //}else{
        //    vc.theClass = self.allResults[row!].classname
        //    vc.theTeacher = self.allResults[row!].teachername
        //}
    }
    
}
