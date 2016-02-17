//
//  AssignmentsTableViewController.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 9/27/15.
//  Copyright © 2015 Lyndon Samual McKay. All rights reserved.
//

import UIKit
import Parse

class AssignmentsTableViewController: UITableViewController,AssignmentDelagate, Childing {

   // let queue = dispatch_get_global_queue(QOS_CLASS_USER_INITIATED.rawValue, 0)

    var refreshControlelol = UIRefreshControl()
    var proppie : PFFile?
    @IBOutlet var tableview: UITableView!
    @IBOutlet var MCL : UIButton!
    @IBOutlet var FINDER : UIButton!
    @IBOutlet var menuButton: UIBarButtonItem!
    @IBOutlet var OtherContine: UIView!
    @IBOutlet var contine: UIView!

    var sgeControl = 0
    var ToppyPosts = [FullClassPost]()
    var QuestionPosts = [FullClassPost]()
    var wAgo : NSDate = NSDate().minusDays(6)
    var uniq = [FullClassPost]()
    var gogo = 0
    var cachedPosts = [FullClassPost]()
    var assID = [String]()
    var qIDs = [String]()
    
    var cPost = [FullClassPost]()
    var AssignmentsArray: [String] = [String]()
    var teacherArray: [String] = [String]()
    var classArray: [String] = [String]()
    var numQuArray: [String] = [String]()
    var createDateArray = [NSDate]()
    let whitty = UIColor.whiteColor()
    var assys = [String]()
    let cUser = PFUser.currentUser()
    var derp : String?
    var array = [String]()
    var ido : String?
    var isFollowing : Bool?
// Segue labels
    var theSchool : String?
    var theClass : String?
    var theTeacher : String?
    var GroupChatID : String?  // For Say Something Button
    var ChatID : String?     // For Say Something Button
    
    var queue = dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)

    let dRed = UIColor(red: 234/255, green: 141/255, blue: 158/255, alpha: 1)

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        GroupChatInfo()

        KLMpreQuery()
        self.userInfoQuery()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if theTeacher == "Error"{
            print("EROROROROROROORORO")
            let cvc = childViewControllers.first as! ChildViewController
            cvc.view.userInteractionEnabled = false

            quickICcheck()
            
            self.view.endEditing(false)
            self.view.userInteractionEnabled = false
        }

        
        if derp == "KLM"{
//        tableview.rowHeight = UITableViewAutomaticDimension
//        tableview.estimatedRowHeight = 106
            
            let _ = KLMpreQuery()
            let _ = previewOP()
            let cvc = childViewControllers.first as! ChildViewController
            cvc.delegate = self
            
            cvc.teacherLabel.text = self.theTeacher!
            cvc.myLabel.text = self.theClass!

            if self.revealViewController() != nil {
                menuButton.target = self.revealViewController()
                menuButton.action = "revealToggle:"
                self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
                
                // Uncomment to change the width of menu
                //   self.revealViewController().rearViewRevealWidth = 200
            }
        }else{
            // OtherChildViewController
            KLMpreQuery()
            previewOP()
            let cvc = childViewControllers.first as! ChildViewController
            cvc.delegate = self
            
            cvc.teacherLabel.text = self.theTeacher!
            cvc.myLabel.text = self.theClass!
            self.derp = "KLM"
        }
        
//        showActivityIndicatory(self.view)

        
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
        

        self.userInfoQuery()
        
        
        print(theClass)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.refreshControl = refreshControlelol
        self.refreshControlelol.addTarget(self, action: "DidRefreshStrings", forControlEvents: UIControlEvents.ValueChanged)
        
        
    }


    func DidRefreshStrings(){
        
        //this is me combining two different arrays, hitting two birds with one stone a me lad!!
        // this is vital to the follow function in DAC adding multiple arrays
        
        self.tableView.reloadData()
        
        // This ends the loading indicator
        self.refreshControlelol.endRefreshing()
        
        print("REFRESHED")
    }

    
    
    func GroupChatInfo(){
        print("GroupChatInfo")
        let jim = PFQuery(className: "Questions")
        jim.whereKey("School", equalTo: self.theSchool!)
        jim.whereKey("classname", equalTo: self.theClass!)
        jim.whereKey("teacherName", equalTo: self.theTeacher!)
        jim.whereKey("assignmentName", equalTo: "Group Chat")
        jim.whereKey("question", equalTo: "ChatHub")
        jim.findObjectsInBackgroundWithBlock { (results:[PFObject]?, error:NSError?) -> Void in
            if error == nil{
                if let results = results as [PFObject]?{
                    for result in results{
//                        let aChatHubID = result["QuestionID"] as? String // QuestionID
                        let aGroupChatId = result["assignmentId"] as? String // TopicID
                        
                        if aGroupChatId != nil{
                            self.GroupChatID = aGroupChatId
                            print("assignmentId : \(aGroupChatId!)")
                        }
//                        if aChatHubID != nil{
                            self.ChatID = result.objectId
                            print("GotCHat\(result.objectId)")
//                            print("chID : \(aChatHubID)")
                        
//                        }
                        let cvc = self.childViewControllers.first as! ChildViewController
                        let _ = cvc.allowSaySom()
                    }
                }
            }else{
                print(error.debugDescription)
            }
        }
    }

    
    
    @IBAction func unwindSegueASS(segue:UIStoryboardSegue){
        cachedPosts.removeAll()
        teacherArray.removeAll()
        classArray.removeAll()
        AssignmentsArray.removeAll()
        numQuArray.removeAll()
        createDateArray.removeAll()
        array.removeAll()
        ToppyPosts.removeAll()
        QuestionPosts.removeAll()
        cPost.removeAll()
        
        if self.derp == "KLM"{
            let cvc = self.childViewControllers.first as! ChildViewController
            cvc.delegate = self
            cvc.segmentControl.selectedSegmentIndex = 0
        }
        let _ = previewOP()
//        self.queryAssignments()
        let _ = self.userInfoQuery()
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
    
    func removeLoading30(){
        if let viewWithTag = self.view.viewWithTag(30) {
            print("Tag 100")
            viewWithTag.removeFromSuperview()
        }
        else {
            print("tag not found")
        }
    }

    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "newLesson"{
            let vc : NewLessonVC = segue.destinationViewController as! NewLessonVC
            
            vc.theSchool = self.theSchool
            vc.theClass = self.theClass
            vc.theTeacher = self.theTeacher
            
        }
        if segue.identifier == "classToAss"{
            let vc : FindClassViewController = segue.destinationViewController as! FindClassViewController
            
            
        }
        if segue.identifier == "myAss"{
            let vc : MyClassesTableViewController = segue.destinationViewController as! MyClassesTableViewController
        }
        if segue.identifier == "NewLessonVC"{
            let vc : NewLessonVC = segue.destinationViewController as! NewLessonVC
            
            vc.theSchool = self.theSchool
            vc.theClass = self.theClass
            vc.theTeacher = self.theTeacher
            if self.isFollowing == false{
                vc.diko = "NotFollowing"
            }
            
        }
        if segue.identifier == "classToASS"{
            let vc : QuestionsTableViewController = segue.destinationViewController as! QuestionsTableViewController
            if sgeControl == 1 || sgeControl == 2{
                let row = tableView.indexPathForSelectedRow!
                    .row - 1
                
                vc.assID = self.cPost[row].theAssignmentID
                vc.theTeachername = self.cPost[row].theTeacher!
                vc.theClassname = self.cPost[row].theClass
                vc.theAssignment = self.cPost[row].theLesson
                vc.theSchool = self.theSchool
                //            vc.derp = "not nil"
            }else{
                let row = tableView.indexPathForSelectedRow?.row
                
                vc.assID = self.cPost[row!].theAssignmentID
                vc.theTeachername = self.cPost[row!].theTeacher!
                vc.theClassname = self.cPost[row!].theClass
                vc.theAssignment = self.cPost[row!].theLesson
                vc.theSchool = self.theSchool
                //            vc.derp = "not nil"
            }
        }
        
        if segue.identifier == "classQtoPVA"{
            let vc : ViewPhotoAnswerTVC = segue.destinationViewController as! ViewPhotoAnswerTVC
            if sgeControl == 1 || sgeControl == 2{
                let row = tableView.indexPathForSelectedRow!.row - 1
                
                if theSchool != nil{
                    vc.School = self.theSchool
                }
                vc.theAnswerID = self.cPost[row].theAnswerID
                vc.derp = "not nil"
                vc.chit = "seggy"
                vc.theQ = self.cPost[row].theQuestion
                vc.QuestionID = self.cPost[row].theQuestionID
                if self.cPost[row].POSTERNAME != nil{
                    vc.AnswererUsername = self.cPost[row].POSTERNAME!
                }
                if self.cPost[row].proCachy != nil{
                    vc.userPic = self.cPost[row].proCachy
                }
            }else{
                let row = tableView.indexPathForSelectedRow?.row
                
                vc.theAnswerID = self.cPost[row!].theAnswerID
                vc.derp = "not nil"
                vc.chit = "seggy"
                vc.theQ = self.cPost[row!].theQuestion
                vc.QuestionID = self.cPost[row!].theQuestionID
                if self.cPost[row!].POSTERNAME != nil{
                    vc.AnswererUsername = self.cPost[row!].POSTERNAME!
                }
                if self.cPost[row!].proCachy != nil{
                    vc.userPic = self.cPost[row!].proCachy
                }
            }
        }
        
        if segue.identifier == "classQtoVA"{
            let vc : ViewAnswerTVC = segue.destinationViewController as! ViewAnswerTVC
            
            if theSchool != nil{
                vc.School = self.theSchool
            }
            if sgeControl == 1 || sgeControl == 2{
                let row = tableView.indexPathForSelectedRow!.row - 1
                
                if  self.cPost[row].theAnswer != nil{
                    vc.theAnswer = self.cPost[row].theAnswer!
                }
                vc.derp = "not nil"
                vc.theAnswerID = self.cPost[row].theAnswerID!
                vc.chit = "seggy"
                vc.theQ = self.cPost[row].theQuestion
                vc.QuestionID = self.cPost[row].theQuestionID
               if self.cPost[row].POSTERNAME != nil{
                    vc.AnswererUsername = self.cPost[row].POSTERNAME!
                }
                if self.cPost[row].proCachy != nil{
                    vc.userPic = self.cPost[row].proCachy
                }
            }else{
                let row = tableView.indexPathForSelectedRow?.row
                
                if  self.cPost[row!].theAnswer != nil{
                    vc.theAnswer = self.cPost[row!].theAnswer!
                }
                vc.derp = "not nil"
                vc.theAnswerID = self.cPost[row!].theAnswerID!
                vc.chit = "seggy"
                vc.theQ = self.cPost[row!].theQuestion
                vc.QuestionID = self.cPost[row!].theQuestionID
                if self.cPost[row!].POSTERNAME != nil{
                    vc.AnswererUsername = self.cPost[row!].POSTERNAME!
                }
                if self.cPost[row!].proCachy != nil{
                    vc.userPic = self.cPost[row!].proCachy
                }
            }

        }
        if segue.identifier == "sToAddQuestionVC"{
            let vc : AddQuestionVC = segue.destinationViewController as! AddQuestionVC
            
            vc.theTopic = "Group Chat"
            vc.theSchool = self.theSchool
            vc.theClass = self.theClass
            vc.theTeacher = self.theTeacher
            vc.assID = self.GroupChatID
            
            if self.isFollowing == false{
                vc.diko = "NotFollowing"
            }
        }
        if segue.identifier == "assTVcToAnswer"{
            let vc : AddHWViewController = segue.destinationViewController as! AddHWViewController
            
            vc.naviTITLE.setTitle("Say It", forState: .Normal)
            vc.theClass = self.theClass
            vc.theTeacher = self.theTeacher
            vc.theSchool = self.theSchool
            vc.theQuestion = "ChatHub"
            vc.seger = "assTVcToAnswer"
            vc.QuestionID = self.ChatID
            vc.QuestionerID = "Su9eRf8ID"
            if self.isFollowing == false{
                vc.diko = "NotFollowing"
            }

        }
        if segue.identifier == "classToAnswer"{
            // Send AnswerID Over
            // Send QuestionID
            let vc : AnswersTableViewController = segue.destinationViewController as! AnswersTableViewController
            
            vc.theSchool = self.theSchool
            
            if sgeControl == 1 || sgeControl == 2{
                let row = tableView.indexPathForSelectedRow!.row - 1
                
                if self.cPost[row].theClass != nil{
                    vc.theClass = self.cPost[row].theClass!
                }
                if self.proppie != nil{
                    vc.proppie = self.proppie!
                }
                if self.cPost[row].AskerID != nil{
                    vc.QuestionerID = self.cPost[row].AskerID
                }
                if self.cPost[row].theQuestionID != nil{
                    vc.QuestionID = self.cPost[row].theQuestionID
                }else{print("no QuestionID")}
                if self.cPost[row].theQuestion != nil{
                    vc.theQuestion = self.cPost[row].theQuestion
                }
            }else{
                let row = tableView.indexPathForSelectedRow?.row
                
                if self.cPost[row!].theClass != nil{
                    vc.theClass = self.cPost[row!].theClass!
                }
                if self.proppie != nil{
                    vc.proppie = self.proppie!
                }
                if self.cPost[row!].AskerID != nil{
                    vc.QuestionerID = self.cPost[row!].AskerID
                }
                if self.cPost[row!].theQuestionID != nil{
                    vc.QuestionID = self.cPost[row!].theQuestionID
                }else{print("no QuestionID")}
                if self.cPost[row!].theQuestion != nil{
                    vc.theQuestion = self.cPost[row!].theQuestion
                }
            }
        }

        else if segue.identifier == "iQ"{
            let vc: QuestionsTableViewController = segue.destinationViewController as! QuestionsTableViewController
            
            if sgeControl == 1 || sgeControl == 2{
                let ASSS = tableView.indexPathForSelectedRow!.row - 1
                if self.proppie != nil{
                    vc.proppie = self.proppie!
                }
                vc.theAssignment = "\(AssignmentsArray[ASSS])"
                vc.assID = "\(assys[ASSS])"
                vc.theClassname = theClass
                vc.theSchool = self.theSchool
                vc.theTeachername = theTeacher
            }else{
                let ASSS = tableView.indexPathForSelectedRow?.row
                if self.proppie != nil{
                    vc.proppie = self.proppie!
                }
                vc.theAssignment = "\(AssignmentsArray[ASSS!])"
                vc.assID = "\(assys[ASSS!])"
                vc.theClassname = theClass
                vc.theSchool = self.theSchool
                vc.theTeachername = theTeacher
            }
/* POTENTIAL SOLUTION TO ALL PROBLEMS
        if let fergy = tableView.indexPathForSelectedRow?.row{
            var had = classArray[fergy]
        }
*/
        print("<<<<<<<\(theTeacher)>>>>>>>>>")
        }

    }
    
    
    
    func userInfoQuery(){
        let qUser = PFQuery(className: "_User")
        qUser.whereKey("objectId", equalTo: (cUser?.objectId)!)
        qUser.findObjectsInBackgroundWithBlock { (results :[PFObject]?, error:NSError?) -> Void in
            if error == nil{
                if let results = results as [PFObject]?{
                    for result in results{
                        let thisSchool = result["School"] as? String
                        let theIDO = result.objectId
                        self.ido = theIDO!
                        if thisSchool != nil{
                            self.theSchool = thisSchool!
                            if self.derp != "KLM"{
                                self.queryAssignments()
                            }
                        }else{
                            print("No School Found")
                        }
                    }
                }
            }
        }
    }

    
    func saySomething(){
        performSegueWithIdentifier("assTVcToAnswer", sender: self)
    }

    
    
    
    func queryAssignments(){
        
//        let newQueue = dispatch_queue_create("com.happymappy.prodown", nil)
        //dispatch_async(newQueue) { () -> Void in
            
        let assignmentsQuery = PFQuery(className: "Assignments")
        
        assignmentsQuery.whereKey("classname", equalTo: self.theClass!)
        assignmentsQuery.whereKey("teacherName", equalTo: self.theTeacher!)
        if self.theSchool != nil{
            assignmentsQuery.whereKey("School", equalTo: self.theSchool!)
        }else{
            print("theSchool equals nil")
        }
        assignmentsQuery.orderByDescending("createdAt")
        assignmentsQuery.findObjectsInBackgroundWithBlock { (results: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil{
                
                
                if let results = results as [PFObject]?{
                    
                    for result in results{
                        
                        print("Undr")
                        
                        let aAssignment = result["assignmentName"] as! String
                        let aClass = result["classname"] as! String
                        let aTeacher = result["teacherName"] as! String
                        let aNumQ = result["numberOfQuestions"] as? String
                        
                        // Append
                        
                        self.AssignmentsArray.append(aAssignment)
                        self.classArray.append(aClass)
                        self.teacherArray.append(aTeacher)
                        if aNumQ != nil{
                            self.numQuArray.append(aNumQ!)
                        }
                        self.createDateArray.append(result.createdAt!)
                        self.assys.append(result.objectId!)
                        print(aAssignment)
                        print(aClass)
                        print(aTeacher)
                        print(aNumQ)
                        print(result.createdAt)
                        
//                        self.tableView.reloadData()
                        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 3/13 * Int64(NSEC_PER_SEC))
                        dispatch_after(time, dispatch_get_main_queue()) {
                            self.removeLoading()
                        }
                    }
                    let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 3/13 * Int64(NSEC_PER_SEC))
                    dispatch_after(time, dispatch_get_main_queue()) {
                        self.removeLoading()
                    }
                }
                let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 3/13 * Int64(NSEC_PER_SEC))
                dispatch_after(time, dispatch_get_main_queue()) {
                    self.removeLoading()
                }
                
                
            }else{
                print("Error \(error)  \(error?.userInfo)")
            }
            
        }
//        }//dis
    }
    
    
    
    
    func previewOP(){
        // Give cachedIDS SomeJuicy Data bytes
//        let ALLPosts = realm.objects(RealmHomePost).sorted("date")
        //        self.cachedPosts = ALLPosts as HomePost
//        //        for each in ALLPosts {
//            let PostsID = each.ObjectID
//            print("BOBOBO\(PostsID)")
//            self.cachedIDs.append(PostsID)
//            var cachO = HomePost()
//            if each.thePicNSData != nil{
//                print("ITS TRUE YA")
//                var koko = PFFile(data: each.thePicNSData!)
//                cachO.thePic = koko
//            } //Waste sense you give the image
//            if each.cachedIMGNSData != nil{
//                print("ITS TRUE YA")
//                //                var kokoi = PFFile(data: each.cachedIMGNSData!)
//                cachO.cachedIMGDATA = each.cachedIMGNSData!
//                print("CachyODataDataData")
//                //                cachO.cachedIMG = UIImage(data: each.cachedIMGNSData!)
//            //            }else{
//                //                cachO.hasIMG = false
//            }
//            if each.proPicData != nil{
//                //                var kokok = PFFile(data: each.proPicData!)
//                cachO.proCachy = UIImage(data: each.proPicData!)
//            }
//            cachO.hasIMG = each.hasIMG
//            cachO.ObjectID = each.ObjectID
//            cachO.theTeacher = each.theTeacher
//            cachO.theClass = each.theClass
//            cachO.theDap = each.theDap
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
//            cPost.append(cachO)
//        }
        
        //
        //        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 3/2 * Int64(NSEC_PER_SEC))
        //        dispatch_after(time, dispatch_get_main_queue()) {
        
//        self.LoadingDesign()
        if self.gogo == 0{
            self.KLMqueryAssignments()
            self.gogo += 1
            print(self.gogo)
            
            
        }else{
            print("ALREADY IN PROGRESS")
        }
        
        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 3/2 * Int64(NSEC_PER_SEC))
        dispatch_after(time, dispatch_get_main_queue()) {
            //put your code which should be executed with a delay here
            
            let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 3/13 * Int64(NSEC_PER_SEC))
            dispatch_after(time, dispatch_get_main_queue()) {
                self.removeLoading()
            }
        }
        //        }
    }
    

    
    
    
    
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if self.derp != "KLM"{
            return 2
        }else{
            return 1
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if self.derp != "KLM"{
            if sgeControl == 1 || sgeControl == 2{
                return cPost.count + 1
                
            }else{
                return cPost.count // hpost array.count
            }
//            switch (section){
//                
//            case 0:
//                return 1
//            case 1:
//                if AssignmentsArray.count != 0{
//                    return AssignmentsArray.count
//                }else{
//                    return 2
//                }
//            default:
//                return 0
//            }
//        
        }else{
            if sgeControl == 1 || sgeControl == 2{
                return cPost.count + 1

            }else{
                return cPost.count // hpost array.count
            }
        }

        
            
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        // Configure the cell...

        
        if self.derp != "KLM"{
            switch (indexPath.section){
            case 0:
                let cell : AssignmentHeaderViewCell = tableView.dequeueReusableCellWithIdentifier("assHeadercell", forIndexPath: indexPath) as! AssignmentHeaderViewCell
                func preQuery(){
                    // goes in viewwillappear
                    let Class = PFQuery(className: "ClassesFollowed")
                    Class.whereKey("classesFollowed", equalTo: self.theClass!)
                    Class.whereKey("teacherName", equalTo: self.theTeacher!)
                    if self.theSchool != nil{
                        Class.whereKey("School", equalTo: self.theSchool!)
                    }
                    Class.whereKey("Username", equalTo: "\((cUser?.username)!)")
                    Class.whereKey("UserID", equalTo: (cUser?.objectId)!)
                    Class.findObjectsInBackgroundWithBlock { (results:[PFObject]?, error:NSError?) -> Void in
                        if error == nil{
                            if let results = results as [PFObject]?{
                                for result in results{
                                    self.array.append(result.objectId!)
                                    if self.array.count > 0{
                                        let lBlue = UIColor(red: 134/255, green: 218/255, blue: 233/255, alpha: 1)
                                        cell.followButton.setTitle("Following", forState: UIControlState.Normal)
                                        cell.followButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
                                        cell.followButton.backgroundColor = lBlue
                                        cell.newLessonButton.alpha = 1
                                        self.isFollowing = true
                                        
                                        if self.derp == "KLM"{
                                            let cvc = self.childViewControllers.first as! ChildViewController
                                            cvc.delegate = self
                                            cvc.follow.setTitle("Following", forState: UIControlState.Normal)
                                            cvc.follow.backgroundColor = self.dRed
                                            cvc.follow.setTitleColor(UIColor.whiteColor(), forState: .Normal)
                                            
                                            print("ISS  KLM FOLLOWING")
                                            
                                        }
                                    }else{
                                        if self.derp == "KLM"{
                                            let cvc = self.childViewControllers.first as! ChildViewController
                                            cvc.delegate = self
                                            
                                            cvc.follow.setTitle("Follow", forState: UIControlState.Normal)
                                            cvc.follow.backgroundColor = UIColor.lightGrayColor()

                                        }
                                        self.isFollowing = false
                                        print("NOTTTKLM FOLLOWING")
                                    }
                                }
                            }
                        }
                    }
                }
                preQuery()
                cell.delegate = self
                cell.classnameLabel.text = theClass
                cell.teachernameLabel.text = theTeacher
                tableView.rowHeight = 162
                return cell
            case 1:
                let cell : AssignmentTableViewCell = tableView.dequeueReusableCellWithIdentifier("AssignmentsCell", forIndexPath: indexPath) as! AssignmentTableViewCell
                if AssignmentsArray.count != 0{
                    cell.assignmentName.text = "\(AssignmentsArray[indexPath.row])"
                    cell.date.text = "Created: \(dts(createDateArray[indexPath.row]))"//"\(createDateArray[indexPath.row])"
                    cell.date.alpha = 1
                    tableView.rowHeight = 101
                }else{
                    if indexPath.row == 0{
                        tableView.rowHeight = 101
                        cell.assignmentName.text = "Welcome to your New Class" //"This is where all Topics / Lessons are Posted"
                        cell.date.alpha = 0
                    }
                    if indexPath.row == 1{
                        tableView.rowHeight = UITableViewAutomaticDimension
                        tableView.estimatedRowHeight = 101
                        cell.date.alpha = 0
                        cell.assignmentName.text = "This is where all Topics / Lessons are Posted"
                    }
                }//
                return cell
            default:
                let cell : AssTopicCell = tableView.dequeueReusableCellWithIdentifier("AssTopicCell", forIndexPath: indexPath) as! AssTopicCell
                return cell
            }
            
        }else{
            
            let indexPathh = indexPath.row - 1
            
            if sgeControl == 1 || sgeControl == 2{
                if indexPath.row == 0 && sgeControl == 1{
                    let cell : AssQuestionAskCell = tableView.dequeueReusableCellWithIdentifier("AssQuestionAskCell", forIndexPath: indexPath) as! AssQuestionAskCell
                    tableView.rowHeight = 51
                    return cell
                }else if indexPath.row == 0 && sgeControl == 2{
                    let cell : AssAddTopicCell = tableView.dequeueReusableCellWithIdentifier("AssAddTopicCell", forIndexPath: indexPath) as! AssAddTopicCell
                    tableView.rowHeight = 51
                    return cell
                }else{
                    if cPost[indexPathh].Type == "Ass"{
                        
                        // New Assignments TableView
                        let cell : AssTopicCell = tableView.dequeueReusableCellWithIdentifier("AssTopicCell", forIndexPath: indexPath) as! AssTopicCell
                        if self.cPost[indexPathh].theLesson != nil{
                            cell.WHatLabel.text = " New Topic Added: \"\(self.cPost[indexPathh].theLesson!)\""
                            cell.topicLabel.text = "\(self.cPost[indexPathh].theLesson!)"
                        }else{
                        }
                        if self.cPost[indexPathh].date != nil{
                            cell.dateLabel.text = dts(self.cPost[indexPathh].date!)
                        }
                        
                        tableView.rowHeight = UITableViewAutomaticDimension
                        tableView.estimatedRowHeight = 106
                        //                tableview.rowHeight = 106
                        return cell
                    }else if cPost[indexPathh].Type == "Q"{
                        
                        tableView.rowHeight = UITableViewAutomaticDimension
                        tableView.estimatedRowHeight = 107
                        // New Assignments TableView
                        let cell : AssQuestionCell = tableView.dequeueReusableCellWithIdentifier("AssQuestionCell", forIndexPath: indexPath) as! AssQuestionCell
                        cell.WHatLabel.text = cPost[indexPathh].What!
                        if self.cPost[indexPathh].theLesson != nil{
                            cell.topicLabel.text = "\(self.cPost[indexPathh].theLesson!)"
                        }else{
                            cell.topicLabel.text = ""
                        }
                        //                cell.usernameLabel.text = cPost[indexPathh].POSTERNAME
                        cell.dateLabel.text = dts(cPost[indexPathh].date!)
                        //                cell.classnameLabel.text = cPost[indexPathh].theClass!
                        return cell
                    }
                    else{
                        var celli : UITableViewCell?
                        if cPost[indexPathh].hasIMG == false{
                            let cell : AssAnswerCell = tableView.dequeueReusableCellWithIdentifier("AssAnswerCell", forIndexPath: indexPath) as! AssAnswerCell
                            tableView.rowHeight = UITableViewAutomaticDimension
                            tableView.estimatedRowHeight = 145
                            cell.dateLabel.text = dts(cPost[indexPathh].date!)
                            //                    cell.whatLabel.text = hPosts[indexPathh].What!
                            if cPost[indexPathh].theQuestion != nil{
                                cell.QuestionLabel.text = cPost[indexPathh].theQuestion!
                            }
                            if cPost[indexPathh].theAnswer != nil{
                                cell.AnswerLabel.text = cPost[indexPathh].theAnswer!
                            }
                            if cPost[indexPathh].POSTERNAME != nil{
                                cell.usernameLabel.text = cPost[indexPathh].POSTERNAME!
                            }
                            if cPost[indexPathh].theLesson != nil{
                                cell.topicLabel.text = cPost[indexPathh].theLesson!
                            }else{
                                cell.topicLabel.text = ""
                            }
                            if cPost[indexPathh].proCachy != nil{
                                cell.proPicIMGView.image = cPost[indexPathh].proCachy
                                cell.proPicIMGView.layer.cornerRadius = 18
                                cell.proPicIMGView.layer.masksToBounds = true
                            }
                            celli = cell
                            //                    return cell
                        }else{
                            let cell : AssAnswerPicCell = tableView.dequeueReusableCellWithIdentifier("AssAnswerPicCell", forIndexPath: indexPath) as! AssAnswerPicCell
                            
                            tableView.rowHeight = UITableViewAutomaticDimension
                            tableView.estimatedRowHeight = 360 //260
                            
                            
                            cell.dateLabel.text = dts(cPost[indexPathh].date!)
                            cell.QuestionLabel.text = cPost[indexPathh].theQuestion!
                            cell.AnswerLabel.text = cPost[indexPathh].theAnswer!
                            
                            if cPost[indexPathh].cachedIMGDATA != nil{
                                cell.AnswerPicIMGView.image = UIImage(data: cPost[indexPathh].cachedIMGDATA!)
                                print("YUYUYUYUYUDODODODODODOl")
                            }else{
                                print("NONONOcachedIMGDATANpupupu")
                            }
                            if cPost[indexPathh].cachedIMG != nil{
                                cell.AnswerPicIMGView.image = cPost[indexPathh].cachedIMG!
                            }
                            //                    cell.whatLabel.text = hPosts[indexPathh].What!
                            cell.usernameLabel.text = cPost[indexPathh].POSTERNAME!
                            if cPost[indexPathh].theLesson != nil{
                                cell.topicLabel.text = cPost[indexPathh].theLesson!
                            }
                            if cPost[indexPathh].proCachy != nil{
                                cell.proPicIMGView.image = cPost[indexPathh].proCachy
                                cell.proPicIMGView.layer.cornerRadius = 18
                                cell.proPicIMGView.layer.masksToBounds = true
                            }
                            celli = cell
                            //                    return cell
                        }
                        
                        return celli!
                    }
                }
//                }else{
//                    let cell : AssAddTopicCell = tableView.dequeueReusableCellWithIdentifier("AssAddTopicCell", forIndexPath: indexPath) as! AssAddTopicCell
//                    return cell
//
//                    
//                }
            }else{
                if cPost[indexPath.row].Type == "Ass"{
                    
                    // New Assignments TableView
                    let cell : AssTopicCell = tableView.dequeueReusableCellWithIdentifier("AssTopicCell", forIndexPath: indexPath) as! AssTopicCell
                    if self.cPost[indexPath.row].theLesson != nil{
                        cell.WHatLabel.text = " New Topic Added: \"\(self.cPost[indexPath.row].theLesson!)\""
                        cell.topicLabel.text = "\(self.cPost[indexPath.row].theLesson!)"
                    }else{
                    }
                    if self.cPost[indexPath.row].date != nil{
                        cell.dateLabel.text = dts(self.cPost[indexPath.row].date!)
                    }
                    
                    tableView.rowHeight = UITableViewAutomaticDimension
                    tableView.estimatedRowHeight = 106
                    //                tableview.rowHeight = 106
                    return cell
                }else if cPost[indexPath.row].Type == "Q"{
                    
                    tableView.rowHeight = UITableViewAutomaticDimension
                    tableView.estimatedRowHeight = 107
                    // New Assignments TableView
                    let cell : AssQuestionCell = tableView.dequeueReusableCellWithIdentifier("AssQuestionCell", forIndexPath: indexPath) as! AssQuestionCell
                    cell.WHatLabel.text = cPost[indexPath.row].What!
                    if self.cPost[indexPath.row].theLesson != nil{
                        cell.topicLabel.text = "\(self.cPost[indexPath.row].theLesson!)"
                    }else{
                        cell.topicLabel.text = ""
                    }
                    //                cell.usernameLabel.text = cPost[indexPath.row].POSTERNAME
                    cell.dateLabel.text = dts(cPost[indexPath.row].date!)
                    //                cell.classnameLabel.text = cPost[indexPath.row].theClass!
                    return cell
                }
                else{
                    var celli : UITableViewCell?
                    if cPost[indexPath.row].hasIMG == false{
                        let cell : AssAnswerCell = tableView.dequeueReusableCellWithIdentifier("AssAnswerCell", forIndexPath: indexPath) as! AssAnswerCell
                        tableView.rowHeight = UITableViewAutomaticDimension
                        tableView.estimatedRowHeight = 145
                        cell.dateLabel.text = dts(cPost[indexPath.row].date!)
                        //                    cell.whatLabel.text = hPosts[indexPath.row].What!
                        if cPost[indexPath.row].theQuestion != nil{
                            cell.QuestionLabel.text = cPost[indexPath.row].theQuestion!
                        }
                        if cPost[indexPath.row].theAnswer != nil{
                            cell.AnswerLabel.text = cPost[indexPath.row].theAnswer!
                        }
                        if cPost[indexPath.row].POSTERNAME != nil{
                            cell.usernameLabel.text = cPost[indexPath.row].POSTERNAME!
                        }
                        if cPost[indexPath.row].theLesson != nil{
                            cell.topicLabel.text = cPost[indexPath.row].theLesson!
                        }else{
                            cell.topicLabel.text = ""
                        }
                        if cPost[indexPath.row].proCachy != nil{
                            cell.proPicIMGView.image = cPost[indexPath.row].proCachy
                            cell.proPicIMGView.layer.cornerRadius = 18
                            cell.proPicIMGView.layer.masksToBounds = true
                        }
                        celli = cell
                        //                    return cell
                    }else{
                        let cell : AssAnswerPicCell = tableView.dequeueReusableCellWithIdentifier("AssAnswerPicCell", forIndexPath: indexPath) as! AssAnswerPicCell
                        
                        tableView.rowHeight = UITableViewAutomaticDimension
                        tableView.estimatedRowHeight = 360 //260
                        
                        
                        cell.dateLabel.text = dts(cPost[indexPath.row].date!)
                        cell.QuestionLabel.text = cPost[indexPath.row].theQuestion!
                        cell.AnswerLabel.text = cPost[indexPath.row].theAnswer!
                        
                        if cPost[indexPath.row].cachedIMGDATA != nil{
                            cell.AnswerPicIMGView.image = UIImage(data: cPost[indexPath.row].cachedIMGDATA!)
                            print("YUYUYUYUYUDODODODODODOl")
                        }else{
                            print("NONONOcachedIMGDATANpupupu")
                        }
                        if cPost[indexPath.row].cachedIMG != nil{
                            cell.AnswerPicIMGView.image = cPost[indexPath.row].cachedIMG!
                        }
                        //                    cell.whatLabel.text = hPosts[indexPath.row].What!
                        cell.usernameLabel.text = cPost[indexPath.row].POSTERNAME!
                        if cPost[indexPath.row].theLesson != nil{
                            cell.topicLabel.text = cPost[indexPath.row].theLesson!
                        }
                        if cPost[indexPath.row].proCachy != nil{
                            cell.proPicIMGView.image = cPost[indexPath.row].proCachy
                            cell.proPicIMGView.layer.cornerRadius = 18
                            cell.proPicIMGView.layer.masksToBounds = true
                        }
                        celli = cell
                        //                    return cell
                    }
                    
                    return celli!
                }

            }
            
        }
    
    }
    
    
    
    
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if self.derp != "KLM"{
            if AssignmentsArray.count != 0{
                if self.isFollowing == true{
                    performSegueWithIdentifier("iQ", sender: self)
                }
            }

        }else{
            // New Assignments TableView

        }
    }
    
    
/*
    func preQuery(){
        // goes in viewwillappear
        let Class = PFQuery(className: "ClassesFollowed")
        Class.whereKey("classesFollowed", equalTo: self.theClass!)
        Class.whereKey("teacherName", equalTo: self.theTeacher!)
        if self.theSchool != nil{
            Class.whereKey("School", equalTo: self.theSchool!)
        }
        Class.whereKey("Username", equalTo: "\((cUser?.username)!)")
        Class.findObjectsInBackgroundWithBlock { (results:[PFObject]?, error:NSError?) -> Void in
            if error == nil{
                if let results = results as [PFObject]?{
                    for result in results{
                        self.array.append(result.objectId!)
                        if self.array.count > 0{
                            followButton.setTitle("Following", forState: UIControlState.Normal)
                        }
                    }
                }
            }
        }
    }
    */

    
    
    
    
    
    func SeggyIndexZero(){
        self.cPost = self.cachedPosts
        sgeControl = 0
        tableView.reloadData()
    }
    
    func SeggyIndexOne(){
        self.cPost = self.QuestionPosts
        sgeControl = 1
        tableView.reloadData()
    }
    
    func SeggyIndexTwo(){
        self.cPost = self.ToppyPosts
        sgeControl = 2
        tableView.reloadData()

    }
    
    
    
    func followClass(){
//        print("Followed Class")
        
        let Class = PFObject(className: "ClassesFollowed")
        Class["classesFollowed"] = self.theClass
        Class["teacherName"] = self.theTeacher
        Class["UserID"] = (cUser?.objectId)! // here
        if self.theSchool != nil{
            Class["School"] = self.theSchool
            //self.addOne()
        }
        isFollowing = true
        Class["Username"] = "\((cUser?.username)!)"
        self.addOne()
        Class.saveInBackgroundWithBlock { (success:Bool, error:NSError?) -> Void in
            if (success == true){
                print("Followed Class")
            }else{
                print(error?.description)
            }
        }
        
    }
    
    func unfollowClass(){
//        print("Class Unfollowed")
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.LoadingDesign()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        }
        isFollowing = false
        let Class = PFQuery(className: "ClassesFollowed")
        Class.whereKey("classesFollowed", equalTo: self.theClass!)
        Class.whereKey("teacherName", equalTo: self.theTeacher!)
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
                            self.ido = theIdo!
                            self.deleteThatClass(theIdo!)
                            //self.minusOne()
                            self.BACK()
                            UIApplication.sharedApplication().endIgnoringInteractionEvents()
                        }
                    }
                }
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
            }
            UIApplication.sharedApplication().endIgnoringInteractionEvents()
        }
    }
    
    
    func deleteThatClass(id: String){
        let Class = PFQuery(className: "ClassesFollowed")
        Class.getObjectInBackgroundWithId(id) { (result:PFObject?, error:NSError?) -> Void in
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), { () -> Void in
                result!.deleteInBackground()
            })
//            result!.deleteInBackground()
            print("Class Unfollowed")
        }
    }
    
    func addOne(){
        let id = self.cUser?.objectId!
        let thisUser = PFQuery(className: "_User")
        thisUser.whereKey("Username", equalTo: (cUser?.username)!)
        thisUser.getObjectInBackgroundWithId(id!) { (results:PFObject?, error :NSError?) -> Void in
            if error != nil{
            }else if let results = results  {
                var tiki : Int?
                var cNum = results["numOfClasses"] as? Int
                if cNum == nil{
                    cNum = 0
                    tiki = cNum
                    print(cNum)
                    tiki! += 1
                    results["numOfClasses"] = tiki!
                }else{
                    print(cNum)
                    tiki = cNum
                    tiki! += 1
                    results["numOfClasses"] = tiki!
                }
//                print(cNum)
//
//                tiki! += 1
//                results["numOfClasses"] = tiki
                
                results.saveInBackground()
                }
            }
    }
    
    
    
    func minusOne(){
        showActivityIndicatory(self.view)
        let id = self.cUser?.objectId!
        let thisUser = PFQuery(className: "_User")
        thisUser.whereKey("Username", equalTo: (cUser?.username)!)
        thisUser.getObjectInBackgroundWithId(id!) { (results:PFObject?, error :NSError?) -> Void in
            if error != nil{
                let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 3/13 * Int64(NSEC_PER_SEC))
                dispatch_after(time, dispatch_get_main_queue()) {
                    self.removeLoading30()
                }
                print(error?.description)
            }else if let results = results  {
                UIApplication.sharedApplication().beginIgnoringInteractionEvents()

                var tiki : Int?
                var cNum = results["numOfClasses"] as? Int
                if cNum == nil{
                    cNum = 0
                    tiki = cNum
                    print(cNum)
                    tiki! -= 1
                    results["numOfClasses"] = tiki!
                    
                }else{
                    print(cNum)
                    tiki = cNum
                    tiki! -= 1
                    results["numOfClasses"] = tiki!
                }

//                print(cNum)
//                
//                cNum -= 1
//                results["numOfClasses"] = cNum
                
                results.saveInBackground()
                let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 3/13 * Int64(NSEC_PER_SEC))
                dispatch_after(time, dispatch_get_main_queue()) {
                    self.removeLoading30()
                }
                let itime = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 3/13 * Int64(NSEC_PER_SEC))
                dispatch_after(time, dispatch_get_main_queue()) {
                    self.removeLoading()
                }
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                
            }
        }
    }
    
    
    
    func showActivityIndicatory(uiView: UIView) {
        let container: UIView = UIView()
        container.frame = uiView.frame
        container.center = uiView.center
        container.tag = 30
        
        let loadingView: UIView = UIView()
        loadingView.frame = CGRectMake(0, 0, 80, 80)
        loadingView.center = uiView.center
        loadingView.backgroundColor = UIColor(red: 68/255, green: 68/255, blue: 68/255, alpha: 0.7)//UIColorFromHex(0x444444, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        actInd.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
        actInd.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.WhiteLarge
        actInd.center = CGPointMake(loadingView.frame.size.width / 2,
            loadingView.frame.size.height / 2);
        loadingView.addSubview(actInd)
        container.addSubview(loadingView)
        uiView.addSubview(container)
        actInd.startAnimating()
    }

    
    
    func BACK(){
        if self.derp == "MCL"{
            self.MCL.sendActionsForControlEvents(.TouchUpInside)
        }else if self.derp == "FINDER"{
            self.FINDER.sendActionsForControlEvents(.TouchUpInside)
        }else{
            let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 3/13 * Int64(NSEC_PER_SEC))
            dispatch_after(time, dispatch_get_main_queue()) {
                self.removeLoading()
            }
            print("Working here")
        }
    }
    
    
    func LoadingDesign(){
        
        let testFrame : CGRect = CGRectMake(0,0,self.view.frame.width,self.view.frame.height - 60)
        let testView : UIView = UIView(frame: testFrame)
        testView.backgroundColor = UIColor.clearColor()
        testView.alpha = 1
        testView.tag = 90
        self.view.addSubview(testView)
        
        let aFrame = CGRectMake((testView.frame.size.height / 4), 96, 80, 80)
        
        let loadingView: UIView = UIView()
        loadingView.frame = aFrame //CGRectMake(0, 0, 80, 80)
        loadingView.backgroundColor = UIColor(red: 52/255, green: 185/255, blue: 208/255, alpha: 1)
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
    

    
    func quickICcheck(){
            print("No Connetion")
            var alert = SCLAlertView()
            alert.addButton("Okay", action: { () -> Void in
            })
            alert.showCloseButton = false
            alert.showWarning("Bad Connection", subTitle: "You have a bad Internet Connection")
    }
    

    
    
    
    
    
    func KLMpreQuery(){
        //NEEDED
        let Class = PFQuery(className: "ClassesFollowed")
        Class.whereKey("classesFollowed", equalTo: self.theClass!)
        Class.whereKey("teacherName", equalTo: self.theTeacher!)
        if self.theSchool != nil{
            Class.whereKey("School", equalTo: self.theSchool!)
        }
        Class.whereKey("Username", equalTo: "\((cUser?.username)!)")
        Class.whereKey("UserID", equalTo: (cUser?.objectId)!)
        Class.findObjectsInBackgroundWithBlock { (results:[PFObject]?, error:NSError?) -> Void in
            if error == nil{
                if let results = results as [PFObject]?{
                    for result in results{
                        self.array.append(result.objectId!)
                        if self.array.count > 0{
                            self.isFollowing = true
                            
                            if self.derp == "KLM"{
                                let cvc = self.childViewControllers.first as! ChildViewController
                                cvc.delegate = self
                                cvc.follow.setTitle("Following", forState: UIControlState.Normal)
                                cvc.follow.backgroundColor = self.dRed
                                cvc.follow.setTitleColor(UIColor.whiteColor(), forState: .Normal)
                                
                                print("ISS  KLM FOLLOWING")
                                
                            }
                        }else{
                            if self.derp == "KLM"{
                                let cvc = self.childViewControllers.first as! ChildViewController
                                cvc.delegate = self
                                cvc.follow.backgroundColor = UIColor.lightGrayColor()   
                                cvc.follow.setTitle("Follow", forState: UIControlState.Normal)
                            }
                            self.isFollowing = false
                            print("NOTTTKLM FOLLOWING")
                        }
                    }
                }
            }
        }
    }

    
    
    
    
    
    func KLMqueryAssignments(){
        
        //        dispatch_async(dispatch_queue_create("underground", nil)) {
        
        let Ass = PFQuery(className: "Assignments")
        //
        //        let wAgo = NSDate().minusDays(6)
        //        Ass.whereKey("createdAt", greaterThanOrEqualTo: wAgo)
        //        print("This is wago \(wAgo)")
        //        Ass.whereKey("updatedAt", greaterThan: wAgo)
        //        Ass.whereKey("createdAt", greaterThan: wAgo)
        Ass.whereKey("classname", equalTo: self.theClass!)
        Ass.whereKey("teacherName", equalTo: self.theTeacher!)
        Ass.whereKey("School", equalTo: self.theSchool!)
        //        Ass.whereKey("objectId", notContainedIn: self.cachedIDs)
        
        Ass.findObjectsInBackgroundWithBlock { (results:[PFObject]?, error:NSError?) -> Void in
            if error == nil{
                if let results = results as [PFObject]?{
                    for result in results{
                        
                        var aO = FullClassPost() //AssignmentObject()
//                        var reaO = RealmHomePost()
                        
                        let aAss = result["assignmentName"] as? String
                        let myClass = result["classname"] as? String
                        let myTeacher = result["teacherName"] as? String
                        let ASSid = result.objectId!
                        
                        aO.Type = "Ass"
//                        reaO.Type = "Ass"
                        aO.date = result.createdAt!
//                        reaO.date = result.createdAt!
                        aO.theAssignmentID = ASSid
//                        reaO.theAssignmentID = ASSid
//                        self.assID.append(ASSid)
                        aO.IDCheck = result.objectId
//                        reaO.IDCheck = result.objectId!
                        aO.ObjectID = result.objectId!
                        
                        if myTeacher != nil{
                            aO.theTeacher = myTeacher!
//                            reaO.theTeacher = myTeacher!
                        }
                        if myClass != nil{
                            aO.theClass = myClass
//                            reaO.theClass = myClass!
                        }
                        if aAss != nil{
                            aO.theLesson = aAss!
//                            reaO.theLesson = aAss!
                            
                            aO.What = "New Topic Added to \(myClass!): \(aAss!)"
//                            reaO.What = "New Topic Added to \(myClass!): \(aAss!)"
                            print("Assignment/Topic : \(aAss!)")
                            aO.highWhat = "New Topic"
//                            reaO.highWhat = "New Topic"
                        }
                        
                        
                        
//                        try! self.realm.write {
//                            self.realm.add(reaO)
//                        }
                        self.assID.append(ASSid)
                        self.cPost.append(aO)
                        self.cachedPosts.append(aO)
                        self.ToppyPosts.append(aO)
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
            }
        }
        //        }
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
                        
                        
                        
                        var quba = FullClassPost()//QuestionObject()
//                        var rquba = RealmHomePost()
                        
                        quba.Type = "Q"
//                        rquba.Type = "Q"
                        let aQuestion = result["question"] as! String
                        
                        
                        let Asker = result["usernameID"] as? String
                        let AskerName = result["username"] as? String
                        let aClass = result["classname"] as? String
                        
                        quba.theClass = aClass!
//                        rquba.theClass = aClass!
                        quba.date = result.createdAt!
//                        rquba.date = result.createdAt!
                        
                        quba.highWhat = "New Question"
//                        rquba.highWhat = "New Question"
                        
                        
                        //Append
                        if Asker != nil{
                            quba.AskerID = Asker!
//                            rquba.AskerID = Asker!
                            quba.POSTERNAME = AskerName!
//                            rquba.POSTERNAME = AskerName!
                            //                            self.askers.append(Asker!)
                        }else{print("no asker")}
                        
                        quba.theQuestion = aQuestion
//                        rquba.theQuestion = aQuestion
                        quba.What = "\(aQuestion)"
//                        rquba.What = "\(aQuestion)"
                        //                        self.questionArray.append(aQuestion)
                        //                        print(aQuestion)
                        print("Question : \(aQuestion)")
                        
                        //                        self.qIDS.append(result.objectId!)
                        quba.theQuestionID = result.objectId!
//                        rquba.theQuestionID = result.objectId!
                        quba.IDCheck = result.objectId
//                        rquba.IDCheck = result.objectId!
//                        rquba.ObjectID = result.objectId!
                        
                        self.qIDs.append(result.objectId!)
                        self.cPost.append(quba)
                        self.cachedPosts.append(quba)
                        self.QuestionPosts.append(quba)

//                        try! self.realm.write {
//                            self.realm.add(rquba)
//                        }
                        self.queryAnswers()
                        //                        self.tableView.reloadData()
                    }
                    sleep(1/2)
                    //                    self.removeLoading()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        //                        self.tableView.reloadData()
                        self.sortIt()
                    })
                    
                }
            }else{
                print("Error \(error)  \(error?.userInfo)")
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
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
//        anS.whereKey("objectId", notContainedIn: self.cachedIDs)
        
        anS.limit = 1000
        //        anS.limit = 2
        anS.findObjectsInBackgroundWithBlock { (results:[PFObject]?, error:NSError?) -> Void in
            if error == nil{
                if let results = results as [PFObject]?{
                    for result in results{
                        
                        var aO = FullClassPost()//AnswerObject()
//                        var raO = RealmHomePost()
                        
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
//                            raO.hasIMG = hasIMG!
//                            print("HASSYIMG\(raO.hasIMG)")
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
//                                        raO.thePicNSData = theData!
//                                        raO.cachedIMGNSData = theData!
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
//                                        raO.proPicData = theData
                                        
                                    }
                                })
                                
                            })
                        }
                        
                        aO.IDCheck = result.objectId
//                        raO.IDCheck = result.objectId!
//                        raO.ObjectID = result.objectId!
                        aO.theClass = aClass!
//                        raO.theClass = aClass!
                        aO.highWhat = "Answer to"
//                        raO.highWhat = "Answer to"
                        aO.Type = "A"
//                        raO.Type = "A"
                        aO.date = result.createdAt!
//                        raO.date = result.createdAt!
                        aO.theAnswerID = result.objectId!
//                        raO.theAnswerID = result.objectId!
                        if qID != nil{
                            aO.theQuestionID = qID
//                            raO.theQuestionID = qID!
                        }
                        if a != nil{
                            aO.theAnswer = a!
//                            raO.theAnswer = a!
                            aO.What = "\(q!)"
//                            raO.What = "\(q!)"
                            aO.lowWhat = "Answered By"
//                            raO.lowWhat = "Answered By"
                            aO.POSTERNAME = poster!
//                            raO.POSTERNAME = poster!
                            print("Answer : \(a!)")
                        }
                        if q != nil{
                            aO.theQuestion = q!
//                            raO.theQuestion = q!
                        }
                        //                        let rero = RLMObject()
                        //                        self.answers.append(aO)
//                        try! self.realm.write {
//                            print("WRITING IT DONE")
//                            self.realm.add(raO)
//                            //                            dispatch_async(self.queue, { () -> Void in
//                            ////                                self.getIMG(aO.thePic!, objy: result.objectId!)
//                            //                            })
//                        }
//                        var finder = self.realm.objects(RealmHomePost).filter("ObjectID = '\(result.objectId)'")
//                        for each in finder{
//                            try! self.realm.write{ () -> Void in
//                                //                                each.setValue(raO.cachedIMGNSData!, forKeyPath: "cachedIMGNSData")
//                                //                                each.setValue(raO.cachedIMGNSData!, forKeyPath: "thePicNSData")
//                                //                                print("Updating cachyNSDATA")
//                                //                finder.first?.setValue(theData!, forKeyPath: "cachedIMGNSData")
//                                //                finder.first?.setValue(theData!, forKeyPath: "thePicNSData")
//                                
//                            }
//                        }
                        
                        
                        self.cPost.append(aO)
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
            }
        }
    }
    
    
    func sortIt(){
        
        //        cPost.removeAll()
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
        
        //        if self.cachedPosts.count > 1{
        if self.cPost.count > 1{
            print("rerere")
            //            print(self.cPost[0].date)
            self.cachedPosts.sortInPlace{ $0.date!.compare($1.date!) == .OrderedDescending}
            self.cPost.sortInPlace{ $0.date!.compare($1.date!) == .OrderedDescending}
            //            print(self.cPost[0].date)
            print(cPost.count)
            var checker = [String]()
            
            for each in cachedPosts{
                //            for each in cPost{
                if checker.contains(each.IDCheck!) == false {//&& each.date!.isGreaterThan(self.wAgo) == true{// && each.date! >= self.wAgo {
                    checker.append(each.IDCheck!)
                    uniq.append(each)
                    print(cPost.count)
                    print(uniq.count)
                }else{
                    print("WE GOTONE")
                }
                //                }
            }
            self.cPost = uniq
            self.cachedPosts = uniq
//            self.allPosts.addObjectsFromArray(uniq)
            //            displayedPosts.addObjectsFromArray(allPosts.subarrayWithRange(NSMakeRange(0, 6)))
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
                let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 3/13 * Int64(NSEC_PER_SEC))
                dispatch_after(time, dispatch_get_main_queue()) {
                    self.removeLoading()
                }
            })
//            removeLoading()
            uniq.removeAll()
            //            cachedPosts.removeAll
            print("reloaded")
        }
    }
    
    
    
    func getIMG(pif : PFFile, objy : String){
        var imageData : NSData?
        pif.getDataInBackgroundWithBlock { (theData:NSData?, error:NSError?) -> Void in
            
//            if theData != nil{
//                imageData = theData!
//                
//                var finder = self.realm.objects(RealmHomePost).filter("ObjectID = '\(objy)'")
//                for each in finder{
//                    //            try! self.realm.write{ () -> Void in
//                    //                each.setValue(theData!, forKeyPath: "cachedIMGNSData")
//                    //                each.setValue(theData!, forKeyPath: "thePicNSData")
//                    //                finder.first?.setValue(theData!, forKeyPath: "cachedIMGNSData")
//                    //                finder.first?.setValue(theData!, forKeyPath: "thePicNSData")
//                    
//                    //            }
//                }
//            }
        }
        // update object and save where id eqals objectId
    }
    
    func getProIMG(pif : PFFile, objy : String){
        var imageData : NSData?
        pif.getDataInBackgroundWithBlock { (theData:NSData?, error:NSError?) -> Void in
            
//            if theData != nil{
//                imageData = theData!
//                
//                var finder = self.realm.objects(RealmHomePost).filter("ObjectID = '\(objy)'")
//                for each in finder{
//                    try! self.realm.write{ () -> Void in
//                        //                    finder.first?.setValue(theData!, forKeyPath: "proPicData")
//                        each.setValue(theData!, forKeyPath: "proPicData")
//                    }
//                }
//            }
        }
        // update object and save where id eqals objectId
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
//                            self.UpdateProPIC()
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
