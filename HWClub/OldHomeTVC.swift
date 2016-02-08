//
//  HomeTVC.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 12/26/15.
//  Copyright © 2015 Lyndon Samual McKay. All rights reserved.
//

import UIKit
import Parse
import Foundation

class OldHomeTVC: UITableViewController {
    
    var wAgo : NSDate = NSDate().minusDays(6)
    @IBOutlet var menuButton: UIBarButtonItem!
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
    var displayedPosts : NSMutableArray = []
    var allPosts : NSMutableArray = []
    var currentPage = 0
    var nextpage = 0
    var proppie : PFFile?
    
    var gogo = 0
    
    var queue = dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        dispatch_async(queue) { () -> Void in
        //            self.UpdateProPIC()
        //        }
        
        LoadingDesign()
        let cUser = PFUser.currentUser()
        print(cUser?.objectId!)
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        quickQuery()
        //        preQuery()
        previewOP()
        
        
        
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
        
        
        LoadingDesign()
        
        if self.gogo == 0{
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
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
    
    
    
    
    
    func previewOP(){
        
        
        self.LoadingDesign()
        if self.gogo == 0{
            self.preQuery()
            self.gogo += 1
            print(gogo)
            
            
        }else{
            print("ALREADY IN PROGRESS")
        }
        
        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 3/2 * Int64(NSEC_PER_SEC))
        dispatch_after(time, dispatch_get_main_queue()) {
            //put your code which should be executed with a delay here
            
            self.removeLoading()
            
        }
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
                    let cell : HomeCell1 = tableView.dequeueReusableCellWithIdentifier("HomeCell1", forIndexPath: indexPath) as! HomeCell1
                    
                    tableView.rowHeight = UITableViewAutomaticDimension
                    tableView.estimatedRowHeight = 200
                    
                    cell.whatLabel.text = hPosts[indexPath.row].What!
                    cell.usernameLabel.text = hPosts[indexPath.row].theClass!
                    cell.dateLabel.text = dts(hPosts[indexPath.row].date!)
                    cell.classnameLabel.text = hPosts[indexPath.row].theClass!
                    cell.highStatusLabel.text = ""//"New Lesson:"
                    cell.byLabel.text = ""//           For"
                    
                    return cell
                    
                }
                
                
                if hPosts[indexPath.row].Type == "Q"{
                    let cell : HomeCell1 = tableView.dequeueReusableCellWithIdentifier("HomeCell1", forIndexPath: indexPath) as! HomeCell1
                    
                    tableView.rowHeight = UITableViewAutomaticDimension
                    tableView.estimatedRowHeight = 200
                    cell.whatLabel.text = hPosts[indexPath.row].What!
                    cell.usernameLabel.text = hPosts[indexPath.row].POSTERNAME
                    cell.dateLabel.text = dts(hPosts[indexPath.row].date!)
                    cell.classnameLabel.text = hPosts[indexPath.row].theClass!
                    cell.highStatusLabel.text = "New Question:"
                    cell.byLabel.text = "Posted by"
                    
                    return cell
                    
                }
                    
                else {//if hPosts[indexPath.row].Type == "A"{
                    //homeCellA
                    
                    var celli : UITableViewCell?
                    
                    if hPosts[indexPath.row].hasIMG == false{
                        let cell : HomeCellAnswer = tableView.dequeueReusableCellWithIdentifier("homeCellA", forIndexPath: indexPath) as! HomeCellAnswer
                        
                        tableView.rowHeight = UITableViewAutomaticDimension
                        tableView.estimatedRowHeight = 200
                        cell.dateLabel.text = dts(hPosts[indexPath.row].date!)
                        //                    cell.whatLabel.text = hPosts[indexPath.row].What!
                        cell.QuestionLabel.text = hPosts[indexPath.row].theQuestion!
                        cell.AnswerLabel.text = hPosts[indexPath.row].theAnswer!
                        cell.usernameLabel.text = hPosts[indexPath.row].POSTERNAME!
                        cell.classLabel.text = hPosts[indexPath.row].theClass!
                        if hPosts[indexPath.row].proCachy != nil{
                            cell.userPic.image = hPosts[indexPath.row].proCachy
                            cell.userPic.layer.cornerRadius = 31
                            cell.userPic.layer.masksToBounds = true
                            
                            
                        }
                        //                    cell.userPic.layer.cornerRadius = 31
                        //                    cell.highStatusLabel.text = "Answer For:"
                        //                    cell.byLabel.text = "Answered by"
                        celli = cell
                        //                    return cell
                        
                    } else{
                        
                        let cell : HomeCellPic = tableView.dequeueReusableCellWithIdentifier("homePicPost", forIndexPath: indexPath) as! HomeCellPic
                        
                        tableView.rowHeight = UITableViewAutomaticDimension
                        tableView.estimatedRowHeight = 350
                        let okit = allPosts[indexPath.row] as! HomePost
                        print("QUQUQUQUQUQu\(okit.date)")
                        print(hPosts[indexPath.row].date!)
                        cell.dateLabel.text = dts(hPosts[indexPath.row].date!)
                        cell.QuestionLabel.text = hPosts[indexPath.row].theQuestion!
                        cell.AnswerLabel.text = hPosts[indexPath.row].theAnswer!
                        if hPosts[indexPath.row].cachedIMG != nil{
                            cell.PictureView.image = hPosts[indexPath.row].cachedIMG!
                        }
                        //                    cell.whatLabel.text = hPosts[indexPath.row].What!
                        cell.usernameLabel.text = hPosts[indexPath.row].POSTERNAME!
                        cell.classLabel.text = hPosts[indexPath.row].theClass!
                        if hPosts[indexPath.row].proCachy != nil{
                            cell.userPic.image = hPosts[indexPath.row].proCachy
                            cell.userPic.layer.cornerRadius = 31
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
                tableView.rowHeight = UITableViewAutomaticDimension
                tableView.estimatedRowHeight = 209
                
                // Configure the cell...
                
                return cell
            }
        }else{ // This Can Be Your Error Cell
            let cell : NoClassHomeCell = tableView.dequeueReusableCellWithIdentifier("noClass", forIndexPath: indexPath) as! NoClassHomeCell
            
            cell.findClassButton.layer.borderColor = teal.CGColor
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = 209
            
            // Configure the cell...
            
            return cell
        }
        //        return cell
        
        
        
    }
    
    
    
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
                    //                    tableView.reloadData()
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
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Going somewhere")
        if hPosts[indexPath.row].AskerID != nil{
            print("viewAs")
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.performSegueWithIdentifier("homeToAnswer", sender: self)
            })
        }
        if hPosts[indexPath.row].theAssignmentID != nil{
            print("viewQs")
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.performSegueWithIdentifier("homeToASS", sender: self)
            })
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
            }
        }
    }
    
    
    
    //classesFollowed
    func preQuery(){
        // goes in viewwillappear
        
        
        
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
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
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    //                    self.tableView.reloadData()
                    
                }
            }else{
                print(error.debugDescription)
            }
        }
        
        if self.MyClasses.count == 0{
            //            sleep(1)
            self.removeLoading()
        }
        
    }
    
    
    
    func queryAssignments(){
        
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
        //        Ass.whereKey("createdAt", greaterThanOrEqualTo: wAgo)
        
        Ass.findObjectsInBackgroundWithBlock { (results:[PFObject]?, error:NSError?) -> Void in
            if error == nil{
                if let results = results as [PFObject]?{
                    for result in results{
                        
                        var aO = HomePost() //AssignmentObject()
                        
                        let aAss = result["assignmentName"] as? String
                        let myClass = result["classname"] as? String
                        let myTeacher = result["teacherName"] as? String
                        let ASSid = result.objectId!
                        
                        aO.Type = "Ass"
                        aO.date = result.createdAt!
                        aO.theAssignmentID = ASSid
                        self.assID.append(ASSid)
                        aO.IDCheck = result.objectId
                        
                        if myTeacher != nil{
                            aO.theTeacher = myTeacher!
                        }
                        if myClass != nil{
                            aO.theClass = myClass
                        }
                        if aAss != nil{
                            aO.theLesson = aAss!
                            
                            aO.What = "New Topic Added to \(myClass!): \(aAss!)"
                            print("Assignment/Topic : \(aAss!)")
                            aO.highWhat = "New Topic"
                        }
                        
                        
                        
                        //                        self.assArray.append(aO)
                        self.hPosts.append(aO)
                    }
                    self.queryQuestions()
                    
                    let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 3 * Int64(NSEC_PER_SEC))
                    dispatch_after(time, dispatch_get_main_queue()) {
                        //put your code which should be executed with a delay here
                        self.gogo = 0
                    }
                    //                    self.tableView.reloadData()
                    
                }
            }
        }
    }
    
    
    
    func queryQuestions(){
        //        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        //        LoadingDesign()
        
        let questionQuery = PFQuery(className: "Questions")
        
        questionQuery.whereKey("assignmentId", containedIn: self.assID)  // contained in
        //        questionQuery.whereKey("createdAt", lessThanOrEqualTo: NSDate())
        questionQuery.whereKey("createdAt", greaterThan: wAgo)
        
        //        questionQuery.whereKey("createdAt", greaterThanOrEqualTo: self.wAgo)
        
        //        questionQuery.orderByDescending("createdAt")
        questionQuery.limit = 1000
        questionQuery.findObjectsInBackgroundWithBlock { (results: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil{
                
                if let results = results as [PFObject]?{
                    
                    for result in results{
                        
                        
                        
                        var quba = HomePost()//QuestionObject()
                        quba.Type = "Q"
                        let aQuestion = result["question"] as! String
                        
                        
                        let Asker = result["usernameID"] as? String
                        let AskerName = result["username"] as? String
                        let aClass = result["classname"] as? String
                        
                        quba.theClass = aClass!
                        quba.date = result.createdAt!
                        
                        quba.highWhat = "New Question"
                        
                        
                        //Append
                        if Asker != nil{
                            quba.AskerID = Asker!
                            quba.POSTERNAME = AskerName!
                            //                            self.askers.append(Asker!)
                        }else{print("no asker")}
                        
                        quba.theQuestion = aQuestion
                        quba.What = "\(aQuestion)"
                        //                        self.questionArray.append(aQuestion)
                        //                        print(aQuestion)
                        print("Question : \(aQuestion)")
                        
                        //                        self.qIDS.append(result.objectId!)
                        quba.theQuestionID = result.objectId!
                        quba.IDCheck = result.objectId
                        self.qIDs.append(result.objectId!)
                        self.hPosts.append(quba)
                        self.queryAnswers()
                        //                        self.tableView.reloadData()
                    }
                    sleep(1/2)
                    //                    self.removeLoading()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.tableView.reloadData()
                    })
                    
                }
            }else{
                print("Error \(error)  \(error?.userInfo)")
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                
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
        anS.limit = 1000
        //        anS.orderByDescending("createdAt")
        anS.findObjectsInBackgroundWithBlock { (results:[PFObject]?, error:NSError?) -> Void in
            if error == nil{
                if let results = results as [PFObject]?{
                    for result in results{
                        
                        var aO = HomePost()//AnswerObject()
                        
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
                        }
                        if thePic != nil{
                            aO.thePic = thePic!
                            var nninn = dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)
                            dispatch_async(nninn, { () -> Void in
                                
                                aO.thePic?.getDataInBackgroundWithBlock({ (theData:NSData?, error:NSError?) -> Void in
                                    
                                    if theData != nil{
                                        let img = UIImage(data: theData!)!
                                        
                                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                            aO.cachedIMG = img
                                            print("YEYEYEYEYEYEYEY")
                                            //                                    self.tableView.reloadData()
                                        })
                                    }
                                })
                                
                            })
                            
                        }
                        
                        if aPic != nil{
                            aO.proPic = aPic!
                            let nninn = dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)
                            dispatch_async(nninn, { () -> Void in
                                
                                aO.proPic?.getDataInBackgroundWithBlock({ (theData:NSData?, error:NSError?) -> Void in
                                    
                                    if theData != nil{
                                        let img = UIImage(data: theData!)!
                                        
                                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                            
                                            aO.proCachy = img
                                            print("YEYEYEYEYEYEYEY")
                                            //                                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                            
                                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                                self.tableView.reloadData()
                                            })
                                            //                                            self.removeLoading()
                                            
                                        })
                                    }
                                })
                                
                            })
                        }
                        
                        aO.IDCheck = result.objectId
                        aO.theClass = aClass!
                        aO.highWhat = "Answer to"
                        aO.Type = "A"
                        aO.date = result.createdAt!
                        aO.theAnswerID = result.objectId!
                        if qID != nil{
                            aO.theQuestionID = qID
                        }
                        if a != nil{
                            aO.theAnswer = a!
                            aO.What = "\(q!)"
                            aO.lowWhat = "Answered By"
                            aO.POSTERNAME = poster!
                            print("Answer : \(a!)")
                        }
                        if q != nil{
                            aO.theQuestion = q!
                        }
                        //                        self.answers.append(aO)
                        self.hPosts.append(aO)
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
        
        if self.hPosts.count > 1{
            print("rerere")
            print(self.hPosts[0].date)
            //            self.hPosts.sortInPlace({$0.date! > $1.date!})
            self.hPosts.sortInPlace{ $0.date!.compare($1.date!) == .OrderedDescending}
            print(self.hPosts[0].date)
            print(hPosts.count)
            //            var uniq = [HomePost]()
            var checker = [String]()
            
            for each in hPosts{
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
            displayedPosts.addObjectsFromArray(allPosts.subarrayWithRange(NSMakeRange(0, 6)))
            //            sleep(1)
            //                    hPosts = sorted(hPosts)
            //            self.tableView.reloadData()
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
            })
            
            uniq.removeAll()
            
            print("reloaded")
        }
    }
    
    
    
    func getIMG(pif : PFFile)-> UIImage{
        var image : UIImage?
        pif.getDataInBackgroundWithBlock { (theData:NSData?, error:NSError?) -> Void in
            
            if theData != nil{
                let img = UIImage(data: theData!)!
                image = img
                
            }
        }
        
        if image != nil{
            //            self.tableView.reloadData()
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
            })
            print("YEYEYEYEYYE")
            return image!
        }else{
            print("NONONONONONONONNON")
            return UIImage(named: "menu")!
        }
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
                            result["profilePic"] = self.proppie!
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
    
    
    
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        //homeQtoPVA
        //homeToASS
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
            
            vc.theAnswerID = self.hPosts[row!].theAnswerID
            vc.derp = "not nil"
            vc.chit = "seggy"
            vc.theQ = self.hPosts[row!].theQuestion
            vc.QuestionID = self.hPosts[row!].theQuestionID
        }
        
        if segue.identifier == "homeQtoVA"{
            let vc : ViewAnswerTVC = segue.destinationViewController as! ViewAnswerTVC
            
            let row = tableView.indexPathForSelectedRow?.row
            
            if  self.hPosts[row!].theAnswer != nil{
                vc.theAnswer = self.hPosts[row!].theAnswer!
            }
            vc.derp = "not nil"
            vc.theAnswerID = self.hPosts[row!].theAnswerID!
        }
        if segue.identifier == "homeToAnswer"{
            // Send AnswerID Over
            // Send QuestionID
            let vc : AnswersTableViewController = segue.destinationViewController as! AnswersTableViewController
            
            
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

//
//extension Array where Element: Hashable {
//    var setValue: Set<Element> {
//        return Set<Element>(self)
//    }
//}
//
//
//extension Array where Element : Hashable {
//    var unique: [Element] {
//        return Array(Set(self))
//    }
//}