//
//  HomeTVC.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 12/26/15.
//  Copyright © 2015 Lyndon Samual McKay. All rights reserved.
//

import UIKit
import Parse
import RealmSwift
//import Realm
import Foundation
import MessageUI


class HomeTVC: UITableViewController,EPPickerDelegate, MFMessageComposeViewControllerDelegate {
    
    let realm = try! Realm()

    var wAgo : NSDate = NSDate().minusDays(6)
    @IBOutlet var menuButton: UIBarButtonItem!
    
//    var leftBarButton: ENMBadgedBarButtonItem?

    @IBOutlet weak var newsletter: UIButton!
    
//    @IBOutlet var NewsletterButton: UIButton!
    
//    @IBOutlet var NewsletterItemButton: UIBarButtonItem!
    
    
    var Numbers = [String]()

    var theSay : String?
    var refreshControlelol = UIRefreshControl()
    var array : [String] = [String]()
    let teal  = UIColor(red: 52/255, green: 185/255, blue: 208/255, alpha: 1)
    var qArray = [QuestionObject]()
    var assArray = [AssignmentObject]()
    var assName = [String]()
    var cUser = PFUser.currentUser()
    var hPosts = [HomePost]()
    var copyPosts = [HomePost]()
    var theSchool = [String]() // its an array for query purposes
    var MyClasses = [ClassObject]()
    var classes = [String]()
    var teachers = [String]()
    var assID = [String]()
    var qIDs = [String]()
    var answers = [AnswerObject]()
    var anan = AnswerObject()
    var uniq = [HomePost]()
    var cachedPosts = [HomePost]()
    var cachedIDs = [String]()
    var displayedPosts : NSMutableArray = []
    var allPosts : NSMutableArray = []
    var currentPage = 0
    var nextpage = 0
    var proppie : PFFile?
    var prepre = 0
    var gogo = 0
    var School : String?
    var queue = dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)
    
    let dGreen = UIColor(red: 42/255, green: 182/255, blue: 172/255, alpha: 1)

    
    override func viewDidDisappear(animated: Bool) {
        view.endEditing(true)
        print("viewDidDisappear")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.alertInvite()
        
//        NewsletterButton.layer.cornerRadius = 15
//        NewsletterButton.frame.size.width = 30
        
        
//        if self.revealViewController() != nil {
//            NewsletterItemButton.target = self.revealViewController()
//            NewsletterItemButton.action = "rightRevealToggle:"
//            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
//        }
        
//        self.newsletter.badgeEdgeInsets = UIEdgeInsetsMake(10, 0, 0, 15)
//        
//        newsletter.badgeString = "1"
//        
//        newsletter.badgeBackgroundColor = UIColor.redColor()

//        self.navigationItem.leftBarButtonItem!.badgeValue = "5"; //your value
//        self.newsletter.badge //your value

        
//        
//        let newBarButton = ENMBadgedBarButtonItem(customView: newsletter, value: "1")
//        leftBarButton = newBarButton
//        navigationItem.rightBarButtonItem = leftBarButton

        
        
        
        try! self.realm.write {
//            realm.deleteAll()
        }
        
        
        
//        // Give cachedIDS SomeJuicy Data bytes
//        let ALLPosts = realm.objects(RealmHomePost)
////        self.cachedPosts = ALLPosts as HomePost
//        
//        for each in ALLPosts {
//            let PostsID = each.ObjectID
//            print("BOBOBO\(PostsID)")
//            self.cachedIDs.append(PostsID)
//            
//            var cachO = HomePost()
//            cachO.ObjectID = each.ObjectID
//            cachO.theTeacher = each.theTeacher
//            cachO.theClass = each.theClass
//            cachO.theDap = each.theDap
////            if each.thePicNSData != nil{
////                var koko = PFFile(data: each.thePicNSData!)
////                cachO.thePic = koko
////                cachO.hasIMG = true
////            } Waste sense you give the image
//            if each.cachedIMGNSData != nil{
////                var kokoi = PFFile(data: each.cachedIMGNSData!)
//                cachO.cachedIMG = UIImage(data: each.cachedIMGNSData!)
//                cachO.hasIMG = true
//
//            }else{
//                cachO.hasIMG = false
//            }
//            if each.proPicData != nil{
//                var kokok = PFFile(data: each.proPicData!)
//                cachO.cachedIMG = UIImage(data: each.proPicData!)
//            }
//            cachO.theQComment = each.theQComment
//            cachO.theQuestion = each.theQuestion
//            cachO.theQuestionID = each.theQuestionID
//            cachO.theSchool = each.theSchool
//            cachO.Type = each.Type
//            cachO.What = each.What
//            cachO.theAnswer = each.theAnswer
//            cachO.theAnswerID = each.theAnswerID
//            cachO.theAssignmentID = each.theAssignmentID
//            cachO.AskerID = each.AskerID
//            cachO.date = each.date
//            cachO.IDCheck = each.IDCheck
//            cachO.highWhat = each.highWhat
//            cachO.lowWhat = each.lowWhat
//            cachO.numOfDaps = each.numOfDaps
//            cachO.POSTERNAME = each.POSTERNAME
//            cachO.QuestionId = each.QuestionId
//            cachO.theAComment = each.theAComment
//            cachO.theLesson = each.theLesson
//            cachedPosts.append(cachO)
//        }
//        

        
        LoadingDesign()
        let cUser = PFUser.currentUser()
        print(cUser?.objectId!)
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        let _ = quickQuery()
//        preQuery()
        

        let _ = self.previewOP()
        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 10/3 * Int64(NSEC_PER_SEC))
        dispatch_after(time, dispatch_get_main_queue()) {
            self.removeLoading()
            self.prepre = 1
            self.view.userInteractionEnabled = true
            UIApplication.sharedApplication().endIgnoringInteractionEvents()
        }
        
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200

//        piko()
        self.refreshControl = refreshControlelol
        self.refreshControlelol.addTarget(self, action: "DidRefreshStrings", forControlEvents: UIControlEvents.ValueChanged)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    
    
    func piko(){
//        LoadingDesign()
//        self.hPosts.removeAll()
        

        self.refreshControl = refreshControlelol
        

        self.refreshControlelol.addTarget(self, action: "DidRefreshStrings", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    
    func DidRefreshStrings(){
        
        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 10/3 * Int64(NSEC_PER_SEC))
        dispatch_after(time, dispatch_get_main_queue()) {
            self.removeLoading()
            self.prepre = 1
            self.view.userInteractionEnabled = true
            UIApplication.sharedApplication().endIgnoringInteractionEvents()
        }
        
        LoadingDesign()
        
        if self.gogo == 0{
//            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            self.view.userInteractionEnabled = false

            self.refreshControlelol.endRefreshing()

            print(gogo)
            print("gogo")

            
        self.allPosts.removeAllObjects()
        self.displayedPosts.removeAllObjects()
//        if self.hPosts.count != 0{
            self.hPosts.removeAll()
//        }
        self.qIDs.removeAll()
        self.array.removeAll()
        self.uniq.removeAll()
        self.answers.removeAll()
        self.assArray.removeAll()
        self.assID.removeAll()
        self.assName.removeAll()
        self.qArray.removeAll()
        self.classes.removeAll()
        self.MyClasses.removeAll()
        self.theSchool.removeAll()
        self.teachers.removeAll()
            
//        self.gogo += 1
        
        //this is me combining two different arrays, hitting two birds with one stone a me lad!!
        // this is vital to the follow function in DAC adding multiple arrays
//        preQuery()
            previewOP()

            self.refreshControlelol.endRefreshing()
//        removeLoading()
        
//        UIApplication.sharedApplication().endIgnoringInteractionEvents()

            print("REFRESHED")
            
            
        }else{
            self.refreshControlelol.endRefreshing()
            print("ALREADYRELOADING")
            removeLoading()
        }


        

    }
    
    
    
   


    func ICcheck(){
        if Reachability.isConnectedToNetwork() == true{
            print("No Connetion")
            var alert = SCLAlertView()
            alert.addButton("Okay", action: { () -> Void in
            })
            alert.showCloseButton = false
            alert.showNotice("Bad Connection", subTitle: "You have a bad Internet Connection")
            
            self.view.userInteractionEnabled = true
            UIApplication.sharedApplication().endIgnoringInteractionEvents()
        }
        self.view.userInteractionEnabled = true
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
    }
    
    func quickICcheck(){
        if Reachability.isConnectedToNetwork() == false{
            print("No Connetion")
            var alert = SCLAlertView()
            alert.addButton("Okay", action: { () -> Void in
            })
            alert.showCloseButton = false
            alert.showWarning("Bad Connection", subTitle: "You have a bad Internet Connection")
            
            self.view.userInteractionEnabled = true
            UIApplication.sharedApplication().endIgnoringInteractionEvents()
        }
        self.view.userInteractionEnabled = true
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
    }
    
    
    
    
    func previewOP(){

        
        // Give cachedIDS SomeJuicy Data bytes
        let ALLPosts = realm.objects(RealmHomePost).sorted("date")
        //        self.cachedPosts = ALLPosts as HomePost
        
        for each in ALLPosts {
            let PostsID = each.ObjectID
            print("BOBOBO\(PostsID)")
            self.cachedIDs.append(PostsID)
            
            var cachO = HomePost()
            if each.thePicNSData != nil{
                print("ITS TRUE YA")
                var koko = PFFile(data: each.thePicNSData!)
                cachO.thePic = koko
            } //Waste sense you give the image
            if each.cachedIMGNSData != nil{
                print("ITS TRUE YA")
//                var kokoi = PFFile(data: each.cachedIMGNSData!)
                cachO.cachedIMGDATA = each.cachedIMGNSData!
                print("CachyODataDataData")
//                cachO.cachedIMG = UIImage(data: each.cachedIMGNSData!)
                
            }else{
//                cachO.hasIMG = false
            }
            if each.proPicData != nil{
//                var kokok = PFFile(data: each.proPicData!)
                cachO.proCachy = UIImage(data: each.proPicData!)
            }
            
            cachO.hasIMG = each.hasIMG
            cachO.ObjectID = each.ObjectID
            cachO.theTeacher = each.theTeacher
            cachO.theClass = each.theClass
            cachO.theDap = each.theDap
            cachO.theQComment = each.theQComment
            cachO.theQuestion = each.theQuestion
            cachO.theQuestionID = each.theQuestionID
            cachO.theSchool = each.theSchool
            cachO.Type = each.Type
            cachO.What = each.What
            cachO.theAnswer = each.theAnswer
            cachO.theAnswerID = each.theAnswerID
            cachO.theAssignmentID = each.theAssignmentID
            cachO.AskerID = each.AskerID
            cachO.date = each.date
            cachO.IDCheck = each.IDCheck
            cachO.highWhat = each.highWhat
            cachO.lowWhat = each.lowWhat
            cachO.numOfDaps = each.numOfDaps
            cachO.POSTERNAME = each.POSTERNAME
            cachO.QuestionId = each.QuestionId
            cachO.theAComment = each.theAComment
            cachO.theLesson = each.theLesson
            cachedPosts.append(cachO)
            hPosts.append(cachO)
        }
        
//
//        let itime = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 9/2 * Int64(NSEC_PER_SEC))
//        dispatch_after(itime, dispatch_get_main_queue()) {
//            self.ICcheck()
//        }
    
        
        self.LoadingDesign()
        if self.gogo == 0{
            self.preQuery()
            self.gogo += 1
            print(self.gogo)


        }else{
            print("ALREADY IN PROGRESS")
        }

        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 3/2 * Int64(NSEC_PER_SEC))
        dispatch_after(time, dispatch_get_main_queue()) {
            //put your code which should be executed with a delay here
            if self.prepre != 0{
                self.removeLoading()
            }

        }
//        }
    }
    
    
    
    
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if hPosts.count > 0 {
            theSay = "yes"
            return hPosts.count
        }else{
            theSay = "no"
            return 1
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if self.hPosts.count > indexPath.row{

        if theSay == "yes"{
//            let cell : HomeCell1 = tableView.dequeueReusableCellWithIdentifier("HomeCell1", forIndexPath: indexPath) as! HomeCell1
//            
//            tableView.rowHeight = UITableViewAutomaticDimension
//            tableView.estimatedRowHeight = 200
            
            // Configure the cell...
            if hPosts[indexPath.row].Type == "Ass"{
//                let cell : HomeCell1 = tableView.dequeueReusableCellWithIdentifier("HomeCell1", forIndexPath: indexPath) as! HomeCell1
//                
//                tableView.rowHeight = UITableViewAutomaticDimension
//                tableView.estimatedRowHeight = 200
//                
//                cell.whatLabel.text = hPosts[indexPath.row].What!
//                cell.usernameLabel.text = hPosts[indexPath.row].theClass!
//                cell.dateLabel.text = dts(hPosts[indexPath.row].date!)
//                cell.classnameLabel.text = hPosts[indexPath.row].theClass!
//                cell.highStatusLabel.text = ""//"New Lesson:"
//                cell.byLabel.text = ""//           For"
//                
                let cell : HomeTopicCell = tableView.dequeueReusableCellWithIdentifier("HomeAssTopicCell", forIndexPath: indexPath) as! HomeTopicCell
                if self.hPosts[indexPath.row].theLesson != nil{
                    cell.WHatLabel.text = " New Topic Added: \"\(self.hPosts[indexPath.row].theLesson!)\""
                    cell.topicLabel.text = "\(self.hPosts[indexPath.row].theClass!)"
                }else{

                }
                if self.hPosts[indexPath.row].date != nil{
                    cell.dateLabel.text = dts(self.hPosts[indexPath.row].date!)
                }else{
                    cell.dateLabel.text = ""
                }
                tableView.rowHeight = UITableViewAutomaticDimension
                tableView.estimatedRowHeight = 99//106
                return cell

            }
            
            
            if hPosts[indexPath.row].Type == "Q"{
//                let cell : HomeCell1 = tableView.dequeueReusableCellWithIdentifier("HomeCell1", forIndexPath: indexPath) as! HomeCell1
//                
//                tableView.rowHeight = UITableViewAutomaticDimension
//                tableView.estimatedRowHeight = 200
//                cell.whatLabel.text = hPosts[indexPath.row].What!
//                cell.usernameLabel.text = hPosts[indexPath.row].POSTERNAME
//                cell.dateLabel.text = dts(hPosts[indexPath.row].date!)
//                cell.classnameLabel.text = hPosts[indexPath.row].theClass!
//                cell.highStatusLabel.text = "New Question:"
//                cell.byLabel.text = "Posted by"

                
                tableView.rowHeight = UITableViewAutomaticDimension
                tableView.estimatedRowHeight = 107
                if hPosts[indexPath.row].What == "ChatHub"{
                    tableView.rowHeight = 0
                }
                
                // New Assignments TableView
                let cell : HomeQuestionCell = tableView.dequeueReusableCellWithIdentifier("HomeQuestionCell", forIndexPath: indexPath) as! HomeQuestionCell
                cell.WHatLabel.text = hPosts[indexPath.row].What!
                if self.hPosts[indexPath.row].theClass != nil{
                    cell.topicLabel.text = "\(self.hPosts[indexPath.row].theClass!)"
                }else{
                    cell.topicLabel.text = ""
                }
                //                cell.usernameLabel.text = cPost[indexPath.row].POSTERNAME
                cell.dateLabel.text = dts(hPosts[indexPath.row].date!)
                //                cell.classnameLabel.text = cPost[indexPath.row].theClass!
                
                
                return cell

            }else if hPosts[indexPath.row].Type == "newbie"{
                //                    tableView.rowHeight = UITableViewAutomaticDimension
                tableView.rowHeight = 60
                
                print("JIJIJIONJION")
                let cell : AssNewMemberCell = tableView.dequeueReusableCellWithIdentifier("newbieCell", forIndexPath: indexPath) as! AssNewMemberCell
                if hPosts[indexPath.row].POSTERNAME != nil && hPosts[indexPath.row].theClass != nil{
                    cell.newMEMLabel.text = "\(hPosts[indexPath.row].POSTERNAME!) just joined \(self.hPosts[indexPath.row].theClass!)"
                }
                if hPosts[indexPath.row].date != nil{
                    cell.dateLabel.text = "\(dts(hPosts[indexPath.row].date!))"
                }
                
                
                return cell
                
            }

            
            else {//if hPosts[indexPath.row].Type == "A"{
                //homeCellA
                
                var celli : UITableViewCell?
                
                if hPosts[indexPath.row].hasIMG == false{
//                    let cell : HomeCellAnswer = tableView.dequeueReusableCellWithIdentifier("homeCellA", forIndexPath: indexPath) as! HomeCellAnswer
//                    
//                    tableView.rowHeight = UITableViewAutomaticDimension
//                    tableView.estimatedRowHeight = 200
//                    cell.dateLabel.text = dts(hPosts[indexPath.row].date!)
////                    cell.whatLabel.text = hPosts[indexPath.row].What!
//                    cell.QuestionLabel.text = hPosts[indexPath.row].theQuestion!
//                    cell.AnswerLabel.text = hPosts[indexPath.row].theAnswer!
//                    cell.usernameLabel.text = hPosts[indexPath.row].POSTERNAME!
//                    cell.classLabel.text = hPosts[indexPath.row].theClass!
//                    if hPosts[indexPath.row].proCachy != nil{
//                        cell.userPic.image = hPosts[indexPath.row].proCachy
//                        cell.userPic.layer.cornerRadius = 31
//                        cell.userPic.layer.masksToBounds = true
//
//
//                    }
////                    cell.userPic.layer.cornerRadius = 31
////                    cell.highStatusLabel.text = "Answer For:"
////                    cell.byLabel.text = "Answered by"
//                    
//                    
                    
                    let cell : HomeAnswerCell = tableView.dequeueReusableCellWithIdentifier("HomeAnswerCell", forIndexPath: indexPath) as! HomeAnswerCell
                    
                    tableView.rowHeight = UITableViewAutomaticDimension
                    tableView.estimatedRowHeight = 145
                    cell.dateLabel.text = dts(hPosts[indexPath.row].date!)
                    //                    cell.whatLabel.text = hPosts[indexPath.row].What!
                    if hPosts[indexPath.row].theQuestion != nil{
                        cell.QuestionLabel.text = hPosts[indexPath.row].theQuestion!
                    }
                    if hPosts[indexPath.row].theAnswer != nil{
                        cell.AnswerLabel.text = hPosts[indexPath.row].theAnswer!
                    }
                    if hPosts[indexPath.row].POSTERNAME != nil{
                        cell.usernameLabel.text = hPosts[indexPath.row].POSTERNAME!
                    }
                    if hPosts[indexPath.row].theClass != nil{
                        cell.topicLabel.text = hPosts[indexPath.row].theClass!
                    }else{
                        cell.topicLabel.text = ""
                    }
                    if hPosts[indexPath.row].proCachy != nil{
                        cell.proPicIMGView.image = hPosts[indexPath.row].proCachy
                        cell.proPicIMGView.layer.cornerRadius = 18
                        cell.proPicIMGView.layer.masksToBounds = true
                    }

                    
                    celli = cell
//                    return cell

                } else{
                    
                    let cell : HomeCellPic = tableView.dequeueReusableCellWithIdentifier("homePicPost", forIndexPath: indexPath) as! HomeCellPic
                    
                    tableView.rowHeight = UITableViewAutomaticDimension
                    tableView.estimatedRowHeight = 360 //350
//                    let okit = allPosts[indexPath.row] as! HomePost
//                    print("QUQUQUQUQUQu\(okit.date)")
                    print(hPosts[indexPath.row].date!)
                    cell.dateLabel.text = dts(hPosts[indexPath.row].date!)
                    cell.QuestionLabel.text = hPosts[indexPath.row].theQuestion!
                    cell.AnswerLabel.text = hPosts[indexPath.row].theAnswer!
                    
                    if hPosts[indexPath.row].cachedIMGDATA != nil{
                        cell.PictureView.image = UIImage(data: hPosts[indexPath.row].cachedIMGDATA!)
                        print("YUYUYUYUYUDODODODODODOl")
                    }else{
                        print("NONONOcachedIMGDATANpupupu")
                    }
                    if hPosts[indexPath.row].cachedIMG != nil{
                        cell.PictureView.image = hPosts[indexPath.row].cachedIMG!
                    }
                    //                    cell.whatLabel.text = hPosts[indexPath.row].What!
                    cell.usernameLabel.text = hPosts[indexPath.row].POSTERNAME!
                    cell.classLabel.text = hPosts[indexPath.row].theClass!
                    if hPosts[indexPath.row].proCachy != nil{
                        cell.userPic.image = hPosts[indexPath.row].proCachy
                        cell.userPic.layer.cornerRadius = 18//31
                        cell.userPic.layer.masksToBounds = true
                    }
                    
                    //                    cell.highStatusLabel.text = "Answer For:"
                    //                    cell.byLabel.text = "Answered by"
                    celli = cell
                    //                    return cell
                }
                
            
            
                return celli!
                
                

            }
            
            
//            return cell
        }else{
            let cell : NoClassHomeCell = tableView.dequeueReusableCellWithIdentifier("noClass", forIndexPath: indexPath) as! NoClassHomeCell
            
            cell.findClassButton.layer.borderColor = teal.CGColor
            cell.findClassButton.backgroundColor = UIColor.whiteColor()
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = 400  // 209
            
            // Configure the cell...
            
            return cell
        }
        }else{ // This Can Be Your Error Cell
            let cell : NoClassHomeCell = tableView.dequeueReusableCellWithIdentifier("noClass", forIndexPath: indexPath) as! NoClassHomeCell
            
            cell.findClassButton.layer.borderColor = teal.CGColor
            cell.findClassButton.backgroundColor = UIColor.whiteColor()
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = 400 // 209
            
            // Configure the cell...
            
            return cell
        }
//        return cell
            
        

    }
    
    
    /*
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        //        if allObjectArray.count >= indexPath.row{
        
        let ro = allPosts.count - currentPage  //space between current and the end
        print(ro)
        var stop = ro - 1
        print(stop)
        
        print("")
        
        print(indexPath.row)
        print(allPosts.count)
        //        if allObjectArray.count > indexPath.row{
        if ro > indexPath.row{
            nextpage = self.displayedPosts.count - 5
            if indexPath.row == nextpage {
                currentPage++
                nextpage = displayedPosts.count - 5
                //            nextpage = elements.count - 1
                
                if ro > 5{ //maybe move
                    displayedPosts.addObjectsFromArray(allPosts.subarrayWithRange(NSMakeRange(currentPage, 1)))
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.tableView.reloadData()
                    })
                }else{
                    displayedPosts.addObjectsFromArray(allPosts.subarrayWithRange(NSMakeRange(currentPage, 0)))
//                    tableView.reloadData()
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.tableView.reloadData()
                    })
                    
                }
            }
        }
    }
    */
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Going somewhere")
        if hPosts.count == 0{
            
        }else{
            if hPosts[indexPath.row].AskerID != nil && hPosts[indexPath.row].AskerID != ""{
                print("viewAs")
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.performSegueWithIdentifier("homeToAnswer", sender: self)
                })
            }
            if hPosts[indexPath.row].theAssignmentID != nil && hPosts[indexPath.row].theAssignmentID != ""{
                print("viewQs")
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.performSegueWithIdentifier("homeToASS", sender: self)
                })
            }
        }
    }
    
    
    
    
    
    
    
    
    func HomeQuery(){
        
        let hq = PFQuery(className: "Questions")
        
        hq.whereKey("assignmentId", containedIn: self.assArray)
        hq.findObjectsInBackgroundWithBlock { (results:[PFObject]?, error:NSError?) -> Void in
            
            if error == nil{
                
                if let results = results as [PFObject]?{
                    
                    for result in results{
                        var hp = HomePost()
                        
                        let aQ = result["question"] as? String
                        print(aQ)
                        
                        hp.QuestionId = result.objectId
// =
                        if aQ != nil{
                            hp.theQuestion = aQ!
                        }
                        

                        
                    }
                }
            }else{
                print(error?.description)
                self.quickICcheck()
            }
        }
    }
    
    
    
    //classesFollowed
    func preQuery(){
        // goes in viewwillappear
        
        
        
//        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        self.view.userInteractionEnabled = false

        
        let Class = PFQuery(className: "ClassesFollowed")
        print(cUser!.objectId!)
        Class.whereKey("UserID", equalTo: (cUser?.objectId)!)
        Class.findObjectsInBackgroundWithBlock { (results:[PFObject]?, error:NSError?) -> Void in
            if error == nil{
                if let results = results as [PFObject]?{
                    if results.count == 0{
//                        self.tableView.reloadData()
                    }
                    for result in results{
                        var cO = ClassObject()
                        var reCO = RealmHomePost()
                        
                        let myClass = result["classesFollowed"] as? String
                        let myTeacher = result["teacherName"] as? String
                        let mySchool = result["School"] as? String
                        let myClassID = result.objectId!
                        
                        cO.classID = myClassID
                        if myClass != nil{
                            cO.classname = myClass!
                            print(myClass)
                            self.classes.append(myClass!)
                        }
                        if myTeacher != nil{
                            cO.teachername = myTeacher!
                            self.teachers.append(myTeacher!)
                        }
                        if mySchool != nil{
                            self.theSchool.append(mySchool!)
                        }
                        self.MyClasses.append(cO)
                        
                    }
                    self.queryAssignments()
                    //if statement here
                    self.sortIt()
//                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    self.view.userInteractionEnabled = true

//                    self.tableView.reloadData()

                }
            }else{
                print(error.debugDescription)
                self.quickICcheck()
            }
        }
        
        if self.MyClasses.count == 0{
//            sleep(1)
            self.removeLoading()
        }

    }

    
    
    func queryAssignments(){
        
//        dispatch_async(dispatch_queue_create("underground", nil)) {

        let Ass = PFQuery(className: "Assignments")
//        
//        let wAgo = NSDate().minusDays(6)
//        Ass.whereKey("createdAt", greaterThanOrEqualTo: wAgo)
//        print("This is wago \(wAgo)")
//        Ass.whereKey("updatedAt", greaterThan: wAgo)
//        Ass.whereKey("createdAt", greaterThan: wAgo)
        Ass.whereKey("classname", containedIn: self.classes)
        Ass.whereKey("teacherName", containedIn: self.teachers)
        Ass.whereKey("School", containedIn: self.theSchool)
//        Ass.whereKey("objectId", notContainedIn: self.cachedIDs)
        
        Ass.findObjectsInBackgroundWithBlock { (results:[PFObject]?, error:NSError?) -> Void in
            if error == nil{
                if let results = results as [PFObject]?{
                    for result in results{
                        
                        var aO = HomePost() //AssignmentObject()
                        var reaO = RealmHomePost()

                        let aAss = result["assignmentName"] as? String
                        let myClass = result["classname"] as? String
                        let myTeacher = result["teacherName"] as? String
                        let ASSid = result.objectId!
                       
                        aO.Type = "Ass"
                        reaO.Type = "Ass"
                        aO.date = result.createdAt!
                        reaO.date = result.createdAt!
                        aO.theAssignmentID = ASSid
                        reaO.theAssignmentID = ASSid
                        self.assID.append(ASSid)
                        aO.IDCheck = result.objectId
                        reaO.IDCheck = result.objectId!
                        reaO.ObjectID = result.objectId!
                        
                        if myTeacher != nil{
                            aO.theTeacher = myTeacher!
                            reaO.theTeacher = myTeacher!
                        }
                        if myClass != nil{
                            aO.theClass = myClass
                            reaO.theClass = myClass!
                        }
                        if aAss != nil{
                            aO.theLesson = aAss!
                            reaO.theLesson = aAss!
                            
                            aO.What = "New Topic Added to \(myClass!): \(aAss!)"
//                            aO.theLesson = aAss!
                            reaO.What = "New Topic Added to \(myClass!): \(aAss!)"
                            print("Assignment/Topic : \(aAss!)")
                            aO.highWhat = "New Topic"
                            reaO.highWhat = "New Topic"
                        }

                        
                        
//                        self.assArray.append(aO)
                        try! self.realm.write {
                            self.realm.add(reaO)
                        }
                        self.hPosts.append(aO)
                        self.cachedPosts.append(aO)
                    }
                    if self.theSchool.count != 0{
                        self.memberClassQuery()
                    }
                    self.queryQuestions()
                    let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 3 * Int64(NSEC_PER_SEC))
                    dispatch_after(time, dispatch_get_main_queue()) {
                        //put your code which should be executed with a delay here
                        self.gogo = 0
//                        self.sortIt()
                    }
//                    self.tableView.reloadData()

                }
            }else{
                print(error?.description)
                self.quickICcheck()
            }
        }
//        }
    }
    
    
    
    
    func memberClassQuery(){
        let Class = PFQuery(className: "ClassesFollowed")
        Class.whereKey("classesFollowed", containedIn: self.classes)
        Class.whereKey("teacherName", containedIn: self.teachers)
        Class.whereKey("School", equalTo: self.theSchool[0])
        
        Class.findObjectsInBackgroundWithBlock { (results:[PFObject]?, error:NSError?) -> Void in
            if error == nil{
                if let results = results as [PFObject]?{
                    for result in results{
                        var mo = MemberObject()
                        var cmo = HomePost()
                        
                        let aUsername = result["Username"] as? String
                        let aClass = result["classesFollowed"] as? String
                        let aTeach = result["teacherName"] as? String
                        
                        cmo.Type = "newbie"
                        cmo.theClass = aClass
                        cmo.IDCheck = result.objectId!
                        
                        if aClass != nil{
                            cmo.theClass = aClass
                        }
                        if aTeach != nil{
                            cmo.theTeacher = aTeach!
                        }
                        if aUsername != nil{
                            mo.username = aUsername
                            cmo.POSTERNAME = aUsername
                            print("New Joiner\(aUsername!)")
                        }
                        mo.date = result.createdAt!
                        cmo.date = result.createdAt!
                        
                        self.hPosts.append(cmo)
                        self.cachedPosts.append(cmo)
                        //                            self.Classmates.append(mo)
                        
                    }
                }
            }
        }
        
    }
    
    
    
    
    func queryQuestions(){
//        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
//        LoadingDesign()

        let questionQuery = PFQuery(className: "Questions")
        
        questionQuery.whereKey("assignmentId", containedIn: self.assID)  // contained in
//        questionQuery.whereKey("objectId", notContainedIn: self.cachedIDs)

        
        questionQuery.limit = 1000
        questionQuery.findObjectsInBackgroundWithBlock { (results: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil{
                
                if let results = results as [PFObject]?{
                    
                    for result in results{
                        
                        
                        
                        var quba = HomePost()//QuestionObject()
                        var rquba = RealmHomePost()

                        quba.Type = "Q"
                        rquba.Type = "Q"
                        let aQuestion = result["question"] as! String
                        
                        
                        let Asker = result["usernameID"] as? String
                        let AskerName = result["username"] as? String
                        let aClass = result["classname"] as? String
                        
                        quba.theClass = aClass!
                        rquba.theClass = aClass!
                        quba.date = result.createdAt!
                        rquba.date = result.createdAt!

                        quba.highWhat = "New Question"
                        rquba.highWhat = "New Question"
                        
                        
                        //Append
                        if Asker != nil{
                            quba.AskerID = Asker!
                            rquba.AskerID = Asker!
                            quba.POSTERNAME = AskerName!
                            rquba.POSTERNAME = AskerName!
//                            self.askers.append(Asker!)
                        }else{print("no asker")}
                        
                        quba.theQuestion = aQuestion
                        rquba.theQuestion = aQuestion
                        quba.What = "\(aQuestion)"
                        rquba.What = "\(aQuestion)"
//                        self.questionArray.append(aQuestion)
//                        print(aQuestion)
                        print("Question : \(aQuestion)")

//                        self.qIDS.append(result.objectId!)
                        quba.theQuestionID = result.objectId!
                        rquba.theQuestionID = result.objectId!
                        quba.IDCheck = result.objectId
                        rquba.IDCheck = result.objectId!
                        rquba.ObjectID = result.objectId!
                        
                        self.qIDs.append(result.objectId!)
                        self.hPosts.append(quba)
                        self.cachedPosts.append(quba)
                        try! self.realm.write {
                            self.realm.add(rquba)
                        }
                        self.queryAnswers()
//                        self.tableView.reloadData()
                    }
                    sleep(1/2)
//                    self.removeLoading()
//                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    self.view.userInteractionEnabled = true
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                        self.tableView.reloadData()
                        self.sortIt()
                    })

                }
            }else{
                print("Error \(error)  \(error?.userInfo)")
                self.quickICcheck()
//                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                self.view.userInteractionEnabled = true

                self.sortIt()
            }
            
            
        }
//        self.queryAnswers()
    }
    

    
    
    func queryAnswers(){
        
        let anS = PFQuery(className: "Answers")
//        let wAgo = NSDate().minusDays(6)
//        print("This is wago \(wAgo)")
//        anS.whereKey("createdAt", greaterThan: wAgo)

        anS.whereKey("QuestionID", containedIn: self.qIDs)
        anS.whereKey("objectId", notContainedIn: self.cachedIDs)

        anS.limit = 1000
//        anS.limit = 2
        anS.findObjectsInBackgroundWithBlock { (results:[PFObject]?, error:NSError?) -> Void in
            if error == nil{
                if let results = results as [PFObject]?{
                    for result in results{
                        
                        var aO = HomePost()//AnswerObject()
                        var raO = RealmHomePost()

                        let q = result["Question"] as? String
                        let a = result["Answer"] as? String
                        let qID = result["QuestionID"] as? String
                        let poster = result["username"] as? String
                        let aClass = result["classname"] as? String
                        let aPic = result["profilePic"] as? PFFile
                        let thePic = result["AnswerImage"] as? PFFile
                        let hasIMG = result["hasAnImage"] as? Bool

                        
                        if hasIMG != nil{
                            aO.hasIMG = hasIMG!
                            raO.hasIMG = hasIMG!
                            print("HASSYIMG\(raO.hasIMG)")
                        }
                        if thePic != nil{
                            aO.thePic = thePic!

                            var nninn = dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)
                            dispatch_async(nninn, { () -> Void in
                                
                            aO.thePic?.getDataInBackgroundWithBlock({ (theData:NSData?, error:NSError?) -> Void in
                                
                                if theData != nil{
                                    let img = UIImage(data: theData!)!
//                                    raO.thePicNSData = theData!

                                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                    aO.cachedIMG = img
                                    print("YEYEYEYEYEYEYEY")
                                    self.tableView.reloadData()
                                    })
                                    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) {
//                                        self.getIMG(thePic!, objy: result.objectId!)
                                    }
                                    raO.thePicNSData = theData!
                                    raO.cachedIMGNSData = theData!
//                                    var finder = self.realm.objects(RealmHomePost).filter("ObjectID = '\(result.objectId)'")
//                                    for each in finder{
//                                        try! self.realm.write{ () -> Void in
//                                            each.setValue(theData!, forKeyPath: "cachedIMGNSData")
//                                            each.setValue(theData!, forKeyPath: "thePicNSData")
//                                            print("Updating cachyNSDATA")
//                                            //                finder.first?.setValue(theData!, forKeyPath: "cachedIMGNSData")
//                                            //                finder.first?.setValue(theData!, forKeyPath: "thePicNSData")
//                                            
//                                        }
//                                    }

                                }
                            })
                            
                            })

                        }
                        
                        if aPic != nil{
                            aO.proPic = aPic!
                            dispatch_async(dispatch_queue_create("underground", nil)) {
//                                self.getProIMG(aPic!, objy: result.objectId!)
                            }
                            let nninn = dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)
                            dispatch_async(nninn, { () -> Void in
                                
                                aO.proPic?.getDataInBackgroundWithBlock({ (theData:NSData?, error:NSError?) -> Void in
                                    
                                    if theData != nil{
                                        let img = UIImage(data: theData!)!

                                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                            
//                                        raO.proCachyNSData = theData!

                                        aO.proCachy = img
                                            self.tableView.reloadData()

                                        print("YEYEYEYEYEYEYEY")
                                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                                self.tableView.reloadData()
                                            })
                                            //                                            self.removeLoading()

                                        })
                                        raO.proPicData = theData

                                    }
                                })
                                
                            })
                        }
                        
                        aO.IDCheck = result.objectId
                        raO.IDCheck = result.objectId!
                        raO.ObjectID = result.objectId!
                        aO.theClass = aClass!
                        raO.theClass = aClass!
                        aO.highWhat = "Answer to"
                        raO.highWhat = "Answer to"
                        aO.Type = "A"
                        raO.Type = "A"
                        aO.date = result.createdAt!
                        raO.date = result.createdAt!
                        aO.theAnswerID = result.objectId!
                        raO.theAnswerID = result.objectId!
                        if qID != nil{
                            aO.theQuestionID = qID
                            raO.theQuestionID = qID!
                        }
                        if a != nil{
                            aO.theAnswer = a!
                            raO.theAnswer = a!
                            aO.What = "\(q!)"
                            raO.What = "\(q!)"
                            aO.lowWhat = "Answered By"
                            raO.lowWhat = "Answered By"
                            aO.POSTERNAME = poster!
                            raO.POSTERNAME = poster!
                            print("Answer : \(a!)")
                        }
                        if q != nil{
                            aO.theQuestion = q!
                            raO.theQuestion = q!
                        }
//                        let rero = RLMObject()
//                        self.answers.append(aO)
                        try! self.realm.write {
                            print("WRITING IT DONE")
                            self.realm.add(raO)
//                            dispatch_async(self.queue, { () -> Void in
////                                self.getIMG(aO.thePic!, objy: result.objectId!)
//                            })
                        }
                        var finder = self.realm.objects(RealmHomePost).filter("ObjectID = '\(result.objectId)'")
                        for each in finder{
                            try! self.realm.write{ () -> Void in
//                                each.setValue(raO.cachedIMGNSData!, forKeyPath: "cachedIMGNSData")
//                                each.setValue(raO.cachedIMGNSData!, forKeyPath: "thePicNSData")
//                                print("Updating cachyNSDATA")
                                //                finder.first?.setValue(theData!, forKeyPath: "cachedIMGNSData")
                                //                finder.first?.setValue(theData!, forKeyPath: "thePicNSData")
                                
                            }
                        }

                        
                        self.hPosts.append(aO)
                        self.cachedPosts.append(aO)
                    }
                    
//                    if self.answers.count > 1{
//                    print("rerere")
//                    print(self.answers[0].date)
//                    self.answers.sortInPlace({$0.date! < $1.date!})
//                    print(self.answers[0].date)
//                    }
                }
                self.sortIt()
            }else{
                print(error?.description)
                self.quickICcheck()
            }
        }
    }
    
    
    func sortIt(){
        
//        hPosts.removeAll()
//        UIApplication.sharedApplication().endIgnoringInteractionEvents()
        
        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 3/2 * Int64(NSEC_PER_SEC))
        dispatch_after(time, dispatch_get_main_queue()) {
            self.view.userInteractionEnabled = true
        }

//        if self.cachedPosts.count > 1{
        if self.hPosts.count > 1{
            print("rerere")
//            print(self.hPosts[0].date)
            self.cachedPosts.sortInPlace{ $0.date!.compare($1.date!) == .OrderedDescending}
            self.hPosts.sortInPlace{ $0.date!.compare($1.date!) == .OrderedDescending}
//            print(self.hPosts[0].date)
            print(hPosts.count)
            var checker = [String]()
            
            for each in cachedPosts{
//            for each in hPosts{
                if checker.contains(each.IDCheck!) == false {//&& each.date!.isGreaterThan(self.wAgo) == true{// && each.date! >= self.wAgo {
                        checker.append(each.IDCheck!)
                        uniq.append(each)
                        print(hPosts.count)
                        print(uniq.count)
                    }else{
                        print("WE GOTONE")
                    }
//                }
            }
            self.hPosts = uniq
            self.allPosts.addObjectsFromArray(uniq)
//            displayedPosts.addObjectsFromArray(allPosts.subarrayWithRange(NSMakeRange(0, 6)))
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
            })
            
            uniq.removeAll()
//            cachedPosts.removeAll
            print("reloaded")
        }
    }
    
    
    
    func getIMG(pif : PFFile, objy : String){
        var imageData : NSData?
        pif.getDataInBackgroundWithBlock { (theData:NSData?, error:NSError?) -> Void in
            
            if theData != nil{
                imageData = theData!
            
            var finder = self.realm.objects(RealmHomePost).filter("ObjectID = '\(objy)'")
            for each in finder{
//            try! self.realm.write{ () -> Void in
//                each.setValue(theData!, forKeyPath: "cachedIMGNSData")
//                each.setValue(theData!, forKeyPath: "thePicNSData")
//                finder.first?.setValue(theData!, forKeyPath: "cachedIMGNSData")
//                finder.first?.setValue(theData!, forKeyPath: "thePicNSData")
                
//            }
            }
        }
        }
        // update object and save where id eqals objectId
    }
    
    func getProIMG(pif : PFFile, objy : String){
        var imageData : NSData?
        pif.getDataInBackgroundWithBlock { (theData:NSData?, error:NSError?) -> Void in
            
            if theData != nil{
            imageData = theData!
            
            var finder = self.realm.objects(RealmHomePost).filter("ObjectID = '\(objy)'")
            for each in finder{
                try! self.realm.write{ () -> Void in
//                    finder.first?.setValue(theData!, forKeyPath: "proPicData")
                    each.setValue(theData!, forKeyPath: "proPicData")
                }
            }
            }
        }
        // update object and save where id eqals objectId
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
        loadingView.backgroundColor = UIColor(red: 52/255, green: 185/255, blue: 208/255, alpha: 1.0)
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
    

    internal func removeDuplicates<C: RangeReplaceableCollectionType where C.Generator.Element : Equatable>(aCollection: C) -> C {
        var container = C()
        
        for element in aCollection {
//            if !contains(container, element) {
            if container.contains(element){
                container.append(element)
            }
        }
        
        return container
    }

    
    
    func quickQuery(){
        
        let pp = PFQuery(className: "_User")
        pp.getObjectInBackgroundWithId((cUser?.objectId)!) { (first:PFObject?, error:NSError?) -> Void in
            if first != nil{
                if let first = first{
                    let pp = first["profilePic"] as? PFFile
                    
                    if pp != nil{
                        print("Grabbed the ProfilePic")
                        //self.getPic(pp!)
                        self.proppie = pp!
                        dispatch_async(self.queue) { () -> Void in
                            self.UpdateProPIC()
                        }
                        print(pp)
                    }else{
                        print("noIMG")
                    }
                }
            }
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

    
    
    
    
    
    func UpdateProPIC(){
        print("Starting the back updates")
        dispatch_async(queue) { () -> Void in
            
        let ll = PFQuery(className: "Answers")
        
        ll.whereKey("usernameID", equalTo: self.cUser!.objectId!)
        
        ll.findObjectsInBackgroundWithBlock { (results:[PFObject]?, error:NSError?) -> Void in
            if error == nil{
                if let results = results as [PFObject]?{
                    for result in results{
                        print("CHANGING1")
                        if self.proppie != nil{
                            result["profilePic"] = self.proppie!
                        }
                        result["username"] = self.cUser!.username!
                        result.saveInBackground()
                    }
                }
            }
        }
        
        
        let cc = PFQuery(className: "Comment")
        
        cc.whereKey("CommentUserID", equalTo: self.cUser!.objectId!)
        
        cc.findObjectsInBackgroundWithBlock { (results:[PFObject]?, error:NSError?) -> Void in
            if error == nil{
                if let results = results as [PFObject]?{
                    for result in results{
                        print("CHANGING2")
                        result["profilePic"] = self.proppie!
                        print(result["CommenterUserName"])
                        result["CommenterUserName"] = self.cUser!.username!
                        result.saveInBackground()
                    }
                }
            }
        }
        
        
        
        let qq = PFQuery(className: "Questions")
        
        qq.whereKey("usernameID", equalTo: self.cUser!.objectId!)
        
        qq.findObjectsInBackgroundWithBlock { (results:[PFObject]?, error:NSError?) -> Void in
            if error == nil{
                if let results = results as [PFObject]?{
                    for result in results{
                        print("CHANGING3")
                        print(result["username"])
                        result["username"] = self.cUser!.username!
                        result.saveInBackground()
                    }
                }
            }
        }
        
        
                }

    }
    
    
    
    
    
    
    
    
    
    // Invitation Feature
    
    func alertInvite(){
        let realm = try! Realm()
        let asked = realm.objects(InviteCheck)
        if asked.count == 0{
            // Never asked User
            print("Print yays")
            askToInvite()
            var didAsk = InviteCheck()
            didAsk.asked = "yes"
            try! realm.write({ 
                realm.add(didAsk)
            })
        }else{
            print("We Already Asked")
        }
        
    }
    
    
    func askToInvite(){
        
        var alert = SCLAlertView()
        alert.addButton("Invite From Contacts") {
            self.showContacts()
        }
        alert.addButton("Not Yet") {
        }
        alert.showCloseButton = false
        alert.showInfo("Invite Friends", subTitle: "")
        

    }
    
    
    func showContacts(){
        
        let contactPickerScene = EPContactsPicker(delegate: self, multiSelection:true, subtitleCellType: SubtitleCellValue.PhoneNumer)
        let navigationController = UINavigationController(rootViewController: contactPickerScene)
        navigationController.navigationBar.barTintColor = self.dGreen
        self.presentViewController(navigationController, animated: true, completion: nil)
    }

    
    
    func DelayTime(){
        let triggerTime = (Int64(NSEC_PER_MSEC) * 10)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
            self.sendMessage()
        })
        
    }
    
    
    
    // Send a message
    func sendMessage() {
        let messageVC = MFMessageComposeViewController()
        messageVC.body = "Hey, Come Check Out Dac. Download Dac: https://appsto.re/us/YSIyab.i"
        messageVC.recipients = Numbers // Optionally add some tel numbers
        messageVC.messageComposeDelegate = self
        
        presentViewController(messageVC, animated: true, completion: nil)
        
        
    }

    
    
    
    
    // Conform to the protocol
    // MARK: - Message Delegate method
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        switch result.rawValue {
        case MessageComposeResultCancelled.rawValue :
            print("message canceled")
            Numbers = []
            
        case MessageComposeResultFailed.rawValue :
            print("message failed")
            
        case MessageComposeResultSent.rawValue :
            print("message sent")
            // Do Parse Function Here
            print("Sent Message")
        default:
            break
        }
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
    
    func getDigits(Num : String) -> String {
        
        let stringArray = Num.componentsSeparatedByCharactersInSet(
            NSCharacterSet.decimalDigitCharacterSet().invertedSet)
        var newNum = stringArray.joinWithSeparator("")
        
        if newNum.characters.count == 10{
            return "1\(newNum)"
        }else{
            return "\(newNum)"
        }
    }
    
    

    
    
    
    
    // MARK: - EPContactsDelegate
    //MARK: EPContactsPicker delegates
    func epContactPicker(_: EPContactsPicker, didContactFetchFailed error : NSError)
    {
        print("Failed with error \(error.description)")
    }
    
    func epContactPicker(_: EPContactsPicker, didSelectContact contact : EPContact)
    {
        print("Contact \(contact.displayName()) has been selected")
        // Append to Numbers
        for each in contact.phoneNumbers{
            print(each.phoneNumber)
            print("Added: \(getDigits(each.phoneNumber)) to Numbers Array")
            
            // Run the numbers through getDigits Func
            self.Numbers.append(getDigits(each.phoneNumber))
            // Take Each and Append it to the Phone Numbers in the Notification Class
            
        }
        self.DelayTime()
    }
    
    func epContactPicker(_: EPContactsPicker, didCancel error : NSError)
    {
        print("User canceled the selection");
        Numbers = []
    }
    
    func epContactPicker(_: EPContactsPicker, didSelectMultipleContacts contacts: [EPContact]) {
        print("The following contacts are selected")
        for contact in contacts {
            print("\(contact.displayName())")
            for each in contact.phoneNumbers{
                print(each.phoneNumber)
                
                print("Added: \(getDigits(each.phoneNumber)) to Numbers Array")
                // Run the numbers through getDigits Func
                self.Numbers.append(getDigits(each.phoneNumber))
                
            }
            //            print(contact.phoneNumbers[0].phoneNumber)
            print("")
        }
        
        self.DelayTime()
        
    }

    
    
    
    
    
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        //homeQtoPVA
        //homeToASS
        //newbieSeggy
        if segue.identifier == "newbieSeggy"{
            let vc : OtherAssignmentsTableViewController = segue.destinationViewController as! OtherAssignmentsTableViewController
            
            let row = tableView.indexPathForSelectedRow?.row
            
//            vc.assID = self.hPosts[row!].theAssignmentID
            vc.theTeacher = self.hPosts[row!].theTeacher!
            vc.theClass = self.hPosts[row!].theClass
//            vc.theAssignment = self.hPosts[row!].theLesson
            vc.theSchool = self.theSchool[0]
            //            vc.derp = "not nil"
        }
        if segue.identifier == "homeToASS"{
            let vc : QuestionsTableViewController = segue.destinationViewController as! QuestionsTableViewController
            
            let row = tableView.indexPathForSelectedRow?.row
            
            vc.assID = self.hPosts[row!].theAssignmentID
            vc.theTeachername = self.hPosts[row!].theTeacher!
            vc.theClassname = self.hPosts[row!].theClass
            vc.theAssignment = self.hPosts[row!].theLesson
            vc.theSchool = self.theSchool[0]
//            vc.derp = "not nil"
        }

        if segue.identifier == "homeQtoPVA"{
            let vc : ViewPhotoAnswerTVC = segue.destinationViewController as! ViewPhotoAnswerTVC
            
            let row = tableView.indexPathForSelectedRow?.row

            vc.School = self.theSchool[0]

            vc.theAnswerID = self.hPosts[row!].theAnswerID
            vc.derp = "not nil"
            vc.chit = "seggy"
            vc.theQ = self.hPosts[row!].theQuestion
            vc.QuestionID = self.hPosts[row!].theQuestionID
            if self.hPosts[row!].theClass != nil{
                vc.theClassname = self.hPosts[row!].theClass
            }
            if self.hPosts[row!].POSTERNAME != nil{
                vc.AnswererUsername = self.hPosts[row!].POSTERNAME!
            }
            if self.hPosts[row!].proCachy != nil{
                vc.userPic = self.hPosts[row!].proCachy
            }
        }

        if segue.identifier == "homeQtoVA"{
            let vc : ViewAnswerTVC = segue.destinationViewController as! ViewAnswerTVC
            
            let row = tableView.indexPathForSelectedRow?.row
            
            vc.School = self.theSchool[0]
            
            if  self.hPosts[row!].theAnswer != nil{
                vc.theAnswer = self.hPosts[row!].theAnswer!
            }
            vc.derp = "not nil"
            vc.theAnswerID = self.hPosts[row!].theAnswerID!
            vc.chit = "seggy"
            vc.theQ = self.hPosts[row!].theQuestion
            vc.QuestionID = self.hPosts[row!].theQuestionID
            if self.hPosts[row!].theClass != nil{
                vc.theClassname = self.hPosts[row!].theClass
            }
            if self.hPosts[row!].POSTERNAME != nil{
                vc.AnswererUsername = self.hPosts[row!].POSTERNAME!
            }
            if self.hPosts[row!].proCachy != nil{
                vc.userPic = self.hPosts[row!].proCachy
            }
        }
        if segue.identifier == "homeToAnswer"{
            // Send AnswerID Over
            // Send QuestionID
            let vc : AnswersTableViewController = segue.destinationViewController as! AnswersTableViewController
            
            vc.theSchool = self.theSchool[0]
            
            let row = tableView.indexPathForSelectedRow?.row

            if self.hPosts[row!].theClass != nil{
                vc.theClass = self.hPosts[row!].theClass!
            }
            if self.proppie != nil{
                vc.proppie = self.proppie!
            }
            if self.hPosts[row!].AskerID != nil{
                vc.QuestionerID = self.hPosts[row!].AskerID
            }
            if self.hPosts[row!].theQuestionID != nil{
                vc.QuestionID = self.hPosts[row!].theQuestionID
            }else{print("no QuestionID")}
            if self.hPosts[row!].theQuestion != nil{
                vc.theQuestion = self.hPosts[row!].theQuestion
            }
            
        }
    }

}
extension Array where Element: Hashable {
    var setValue: Set<Element> {
        return Set<Element>(self)
    }
}

//extension Array where Element : Equatable {
//    var unique: [Element] {
//        var uniqueValues: [Element] = []
//        forEach { item in
//            if !uniqueValues.contains(item) {
//                uniqueValues += [item]
//            }
//        }
//        return uniqueValues
//    }
//}

extension Array where Element : Hashable {
    var unique: [Element] {
        return Array(Set(self))
    }
}