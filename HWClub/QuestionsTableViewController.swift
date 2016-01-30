//
//  QuestionsTableViewController.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 9/29/15.
//  Copyright © 2015 Lyndon Samual McKay. All rights reserved.
//

import UIKit
import Parse


class QuestionsTableViewController: UITableViewController, toAnswerDelegate, SEGon{

    
    @IBOutlet var askQButton: UIButton!
    
    @IBOutlet var tableview: UITableView!
    var refreshControlelol = UIRefreshControl()
    var tranQ : String?
    var theClassname : String?
    var theTeachername: String?
    var theSchool : String?
    var theAssignment : String?
    var questionArray = [String]()
    var userArray : [String] = [String]()
    let whitty = UIColor.whiteColor()
    var assID : String?
    var qIDS = [String]()
    var askers = [String]()
    var QuestionID : String?
    var QuestionerID : String?
    var theQuestion : String?
    var proppie :PFFile?
    let cUser = PFUser.currentUser()
    
    var noQs : Bool?
//    var AssID : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(self.theAssignment!)
        print(self.theTeachername!)
        print(self.theClassname!)
        print(self.theSchool!)
        print(self.assID!)
        
        
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
        

        queryQuestions()

        piko()

        if self.proppie == nil{
            quickQuery()
        }
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 200
        
        
        //self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        
    }
    
    
    func piko(){
        self.refreshControl = refreshControlelol
        self.refreshControlelol.addTarget(self, action: "DidRefreshStrings", forControlEvents: UIControlEvents.ValueChanged)
    }

    
    func DidRefreshStrings(){
        
        
        LoadingDesign()
        self.askers.removeAll()
        self.qIDS.removeAll()
        self.questionArray.removeAll()
        self.userArray.removeAll()

        
        //this is me combining two different arrays, hitting two birds with one stone a me lad!!
        // this is vital to the follow function in DAC adding multiple arrays
        
        queryQuestions()
        // This ends the loading indicator
        self.refreshControlelol.endRefreshing()
        removeLoading()

        print("REFRESHED")
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
    
    


    
    @IBAction func unwindSegueQ(segue: UIStoryboardSegue){
        
        self.noQs == nil
        self.questionArray.removeAll()
        self.userArray.removeAll()
        self.queryQuestions()
//        self.tableView.reloadData()
        
    }
    
    func queryQuestions(){
//        UIApplication.sharedApplication().beginIgnoringInteractionEvents()

        let questionQuery = PFQuery(className: "Questions")
        
        if self.assID != nil{
            questionQuery.whereKey("assignmentId", equalTo: self.assID!)

        }else{
        questionQuery.whereKey("classname", equalTo: theClassname!)
        questionQuery.whereKey("teacherName", equalTo: theTeachername!)
        questionQuery.whereKey("assignmentName", equalTo: theAssignment!)
        if self.theSchool != nil{
            questionQuery.whereKey("School", equalTo: self.theSchool!)
        }else{
            print("theSchool equals nil")
        }
        }
        
        questionQuery.orderByDescending("createdAt")
        questionQuery.findObjectsInBackgroundWithBlock { (results: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil{
                
                if let results = results as [PFObject]?{
                    
                    for result in results{
                        
                        let aQuestion = result["question"] as! String
                        
//                        let aAssignment = result["assignmentName"] as! String
      
                        let Asker = result["usernameID"] as? String
                        
//                        let aTeacher = result["teacherName"] as! String
                        
//                        let aImage = result["questionIMG"] as! UIImage
                        
//                        let aUser = result["username"] as! String
                        
                        //Append
                        if Asker != nil{
                            self.askers.append(Asker!)
                        }else{print("no asker")}
                        self.questionArray.append(aQuestion)
                        print(aQuestion)
                        self.qIDS.append(result.objectId!)
//                        self.userArray.append(aUser)
                        self.tableView.reloadData()
                    }
                    sleep(1/2)
                    self.removeLoading()
//                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    self.tableView.reloadData()

                }
            }else{
                print("Error \(error)  \(error?.userInfo)")
//                UIApplication.sharedApplication().endIgnoringInteractionEvents()

            }
            self.tableView.reloadData()
            self.removeLoading()

            
        }
        self.tableView.reloadData()
        self.removeLoading()

    }
    
    
    func segit(){
        self.askQButton.sendActionsForControlEvents(.TouchUpInside)
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
    
    
    
    
    func opop(qID:String,asker: String, theQ: String){
        self.QuestionerID = asker
        self.QuestionID = qID
        self.theQuestion = theQ
        if self.QuestionID != nil{
            performSegueWithIdentifier("qListToAnswer", sender: self)
        }else{
            self.QuestionerID = asker
            self.QuestionID = qID
            if self.QuestionID != nil{
                performSegueWithIdentifier("qListToAnswer", sender: self)
            }
            
        }
    }
    
    
    
    
    
    
    @IBAction func segON(sender: AnyObject) {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
                self.performSegueWithIdentifier("toQ", sender: self)
        }

    }
    
    
    

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1{
            let cell : QuestionTableViewCell = tableView.dequeueReusableCellWithIdentifier("questionCell") as! QuestionTableViewCell
            
            if self.noQs != true{
            //cell.questionLabel.text = self.tranQ
            performSegueWithIdentifier("AtoQ", sender: cell)
            }
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
        // return 3 for iAd
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        switch (section){
        case 0:
            return 1
            
        case 1:
            if questionArray.count != 0{
                self.noQs = false
                return questionArray.count
            }else{
                self.noQs = true
                return 2
            }
            
        default:
            return 1
            
        }

        // return 3 For iAD
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        // Configure the cell...
        
        switch (indexPath.section){
        case 0:
            let cell : QHeaderCell = tableView.dequeueReusableCellWithIdentifier("qHeadcell") as! QHeaderCell
            
            cell.delegate = self
            
            tableView.rowHeight = 199 //267 //290
            //cell.askQuestionButton?.layer.cornerRadius = 26
            cell.AssignmenTitleLabel.text = theAssignment
            return cell
            
        case 1:
            let cell : QuestionTableViewCell = tableView.dequeueReusableCellWithIdentifier("questionCell") as! QuestionTableViewCell
            if self.noQs != true{
            cell.delegate = self

            cell.QuestionerID = self.askers[indexPath.row]
            cell.QuestionID = self.qIDS[indexPath.row]
            self.tableView.estimatedRowHeight = 128
            self.tableView.rowHeight = UITableViewAutomaticDimension
            //tableView.rowHeight = 200
//            cell.circle.layer.cornerRadius = 32
            cell.questionLabel.text = "\(questionArray[indexPath.row])"
            cell.answerQButton.alpha = 1

            }else{
                if indexPath.row == 0{
                    self.tableView.estimatedRowHeight = 128
                    self.tableView.rowHeight = UITableViewAutomaticDimension
                    cell.questionLabel.text = "Here is where you'll see all Questions related to the Topic Above."
                    cell.answerQButton.alpha = 0
                }else if indexPath.row == 1{
                    self.tableView.estimatedRowHeight = 128
                    self.tableView.rowHeight = UITableViewAutomaticDimension
                    cell.questionLabel.text = "Welcome to your New Class"
                    cell.answerQButton.alpha = 0
                }
            }
        return cell
            
        default:
            let cell : QHeaderCell = tableView.dequeueReusableCellWithIdentifier("quesiutionCell") as! QHeaderCell

        
        
        
        return cell
    
        }
    
    }

    
    
    
    func LoadingDesign(){
        
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toQ"{
            let vc: AddQuestionVC = segue.destinationViewController as! AddQuestionVC
            
            vc.theTopic = self.theAssignment!
            vc.theTeacher = self.theTeachername!
            vc.theClass = self.theClassname!
            vc.theSchool = self.theSchool!
            vc.assID = self.assID!
        }
        if segue.identifier == "AtoQ"{
            let vc : AnswersTableViewController = segue.destinationViewController as! AnswersTableViewController
            
            let row = tableview.indexPathForSelectedRow?.row
            
            print(self.questionArray[row!])
            
            if self.proppie != nil{
                vc.proppie = self.proppie!
            }
            vc.QuestionerID = self.askers[row!]
            vc.QuestionID = self.qIDS[row!]
            vc.theClass = self.theClassname
            vc.theAssignment = self.theAssignment
            vc.theTeacher = self.theTeachername
            vc.theQuestion = self.questionArray[row!]
        }
        if segue.identifier == "qListToAnswer"{
            let vc : AddHWViewController = segue.destinationViewController as! AddHWViewController
            
            vc.seger = "qListToAnswer"
            vc.theClass = self.theClassname!
            print(self.askers[0])
            print(self.qIDS[0])
            vc.theQuestion = self.theQuestion!
            vc.QuestionerID = self.QuestionerID
            vc.QuestionID = self.QuestionID
            vc.howMEhere = "notNIL"

//            let row = self.tableview.inde
            

//            vc.QuestionerID = self.askers[row]
//            vc.QuestionID = self.qIDS[row]
//        }
        }
        

    }
    

}