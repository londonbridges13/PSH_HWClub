//
//  AnswersTableViewController.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 9/29/15.
//  Copyright © 2015 Lyndon Samual McKay. All rights reserved.
//

import UIKit
import Parse

class AnswersTableViewController: UITableViewController,CustomCellDelegate,IMGCustomCellDelegate {

    @IBOutlet var naviItem: UINavigationItem!
    @IBOutlet var pullToReloadButton: UIButton!

    //let lBlue = UIColor(red: 134/255, green: 218/255, blue: 233/255, alpha: 1)
    let teal : UIColor = UIColor(red: 52, green: 185, blue: 208, alpha: 1)
    let lBlue  = UIColor(red: 52/255, green: 185/255, blue: 208/255, alpha: 1)
    let whitty = UIColor.whiteColor()
    var theAnswerIDs = [String]()
    var tS : String?
    var aI : String?
    var apI : String?
    var SeeAnswer : String?
    var qI = 0
    var proppie : PFFile?
    var uniq = [AnswerObject]()
    let cUser = PFUser.currentUser()

    //AnswerObject
//    let aObject = AnswerObject()
    var Answers : [AnswerObject] = []

    //MARK:- IMG Arrays
    var answerArray : [String] = ["[String]()"]
    var userArray : [String] = ["[String]()"]
    var answerIMGArray : [UIImage] = [UIImage]()
    var hasIMGarray = [false]
    var filesArray : [PFFile] = [PFFile]()
    var theSchool : String?
    var user = PFUser.currentUser()
    var hasAnswered : Bool?
    var vArray: [String] = [String]()

    var Answerss : NSArray = []
//    var transAarray = [AnswerObject] as NSArray
    
//    var bothArray : NSMutableArray = ["Look Down"]
    
    
    //MARK:- without IMG Arrays
    var NanswerArray : [String] = ["[String]()"]
    var NuserArray : [String] = ["[String]()"]
    
    
    // IBE
    let myNSArray : NSMutableArray = []
    var refreshControlelol = UIRefreshControl()
    
    var QuestionID : String?
    var QuestionerID : String?
    var theQuestion : String?
    var theAssignment : String?
    var theClass : String?
    var theTeacher : String?
    var theImage: UIImage?
    
    let ququq = dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0)

    
    
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet var jojjQQQ: UIButton!
    var ti = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(SeeAnswer)
        if SeeAnswer != nil{
//            self.theQuestion = SeeAnswer!
        }
        naviItem.backBarButtonItem?.tintColor = UIColor.whiteColor()
        

        let testFrame : CGRect = CGRectMake(0,0,self.view.frame.width,self.view.frame.height - 60)
        let testView : UIView = UIView(frame: testFrame)
        testView.backgroundColor = whitty
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
        

        refreshControlelol.backgroundColor = UIColor(red: 233/255, green: 242/255, blue: 240/255, alpha: 0.69)
        if self.proppie == nil{
            print("getting proppie")
            quickQuery()
            
        }else{print("gotproppie")}
        
        let fName = UIImage(named: "menu")
    let iData = UIImagePNGRepresentation(fName!)
    let fakeIMG : PFFile = PFFile(data: iData!)
        tableview.rowHeight = 209

        filesArray.append(fakeIMG)
        
        piko()

//        queryAnswers()
        self.ststst()
        
        //tableView.reloadData()
        tableView.allowsMultipleSelection = true
        
        UIApplication.sharedApplication().endIgnoringInteractionEvents()

    }
    

    @IBAction func unwindSeggyANS(segue: UIStoryboardSegue){
        
//        self.myTeacherArray.removeAll()
//        self.myClassArray.removeAll()    
        self.Answers.removeAll()
        theAnswerIDs.removeAll()
//        bothArray.removeAllObjects()
        hasIMGarray.removeAll()
        filesArray.removeAll()
        vArray.removeAll()
        
        LoadingDesign()
        
        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 1 * Int64(NSEC_PER_SEC))
        dispatch_after(time, dispatch_get_main_queue()) {
            self.ststst()
        }
        //        self.tableView.reloadData()
        
    }

//    override func canPerformUnwindSegueAction(action: Selector, fromViewController: UIViewController, withSender sender: AnyObject) -> Bool {
//        if (self.respondsToSelector(action)){
//            return true
//        }
//        return false
//    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        theAnswerIDs.removeAll()
//        bothArray.removeAllObjects()
        hasIMGarray.removeAll()
        filesArray.removeAll()
        vArray.removeAll()
        self.Answers.removeAll()
        //queryAnswers()
        ststst()
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
    
    
    func ststst(){
//        self.quickQuery()
//        self.qI = 0


//        while qI < 8{
//            var t = self.qI + 1
//            self.qI = t
            print(self.qI)
            queryAnswers()
        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 3/2 * Int64(NSEC_PER_SEC))
        dispatch_after(time, dispatch_get_main_queue()) {
            self.removeLoading()
            UIApplication.sharedApplication().endIgnoringInteractionEvents()

        }
//        }
    }
    
    func sortIt(){
        
        if self.Answers.count > 1{
            print("rerere")
            print(self.Answers[0].date)
            //            self.hPosts.sortInPlace({$0.date! > $1.date!})
            
            self.Answers.sortInPlace{ $0.date!.compare($1.date!) == .OrderedDescending}
            print(self.Answers[0].date)
            print(Answers.count)
            //            var uniq = [HomePost]()
            var checker = [String]()
            for each in Answers{
                if checker.contains(each.AnswerID!) != true{
                    checker.append(each.AnswerID!)
                    uniq.append(each)
                    print(Answers.count)
                    print(uniq.count)
                }else{
                    print("WE GOTONE")
                }
            }
            self.Answers = uniq
//            self.allPosts.addObjectsFromArray(uniq)
            UIApplication.sharedApplication().endIgnoringInteractionEvents()

            self.tableView.reloadData()
            uniq.removeAll()
            print("reloaded")
        }
    }

    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("trying")
//        self.tableview.reloadData()
        print("viewwillappear")
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
//        tableview.reloadData()
        //verificationQuery()
        print("vdA")
    }
    
    func piko(){
        
//        bothArray.removeAllObjects()
        hasIMGarray.removeAll()
        filesArray.removeAll()
        vArray.removeAll()
        Answers.removeAll()
        //queryAnswers()
//        ststst()
        
        self.refreshControl = refreshControlelol
        self.refreshControlelol.addTarget(self, action: "DidRefreshStrings", forControlEvents: UIControlEvents.ValueChanged)
        }

    func DidRefreshStrings(){

//        self.Answers.removeAll()

        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.LoadingDesign()
//            self.Answers.removeAll()

        }
        //this is me combining two different arrays, hitting two birds with one stone a me lad!!
        // this is vital to the follow function in DAC adding multiple arrays
//        self.Answers.removeAll()
//        self.queryAnswers()
        self.ststst()
        
//        dispatch_async(dispatch_get_main_queue()) { () -> Void in
//            self.removeLoading()
//        }
        // This ends the loading indicator
        self.refreshControlelol.endRefreshing()
//        self.refreshControl?.endRefreshing()
        print("REFRESHED")
    }

    
    
    
    
    
    
/*
    @IBAction func unwindSegue(segue: UIStoryboardSegue){
        
//        bothArray.removeAllObjects()
//        hasIMGarray.removeAll()
//        filesArray.removeAll()
//        
        self.queryAnswers()

        
        //viewDidAppear(true)
        
    }
    
*/
    
    
    
    @IBAction func jojji(sender: AnyObject) {
    }
    
    @IBAction func ptR(sender: AnyObject) {
        piko()
    }

  
    func flagPost(objyID:String){
        let optionMenu = UIAlertController(title: nil, message: "More Options", preferredStyle: .ActionSheet)
        
        let TPAction = UIAlertAction(title: "Flag Content", style: .Destructive, handler: {
            (alert: UIAlertAction!) -> Void in
            print("FLAGGED")
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        optionMenu.addAction(TPAction)
        optionMenu.addAction(cancelAction)
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }
    
    
    func dappedIt(objyID:String){
        print("Dapped It")
        
        DapAnswer(objyID)
//        dapNotifyUser(<#T##notiUserid: String##String#>, cDapORaDap: <#T##String#>, giverUserName: <#T##String#>, pAoRvA: <#T##String#>, answerID: <#T##String#>, proppie: <#T##PFFile#>, theMessage: <#T##String#>)
        let path = tableView.indexPathForSelectedRow
        if path?.row != nil{
            if Answers[path!.row].hasIMG == false{
                // let aCell : AnswersTableViewCell = tableview.cellForRowAtIndexPath(path!)
                //aCell.backgroundColor = UIColor.whiteColor()
            }
        }
    }
    
    func Comment(say:String, aID:String, aPID:String){
        print("Commenting...")
        print(say)
        print(aID)
        print(aPID)
        
        self.tS = say
        self.aI = aID
        self.apI = aPID
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.performSegueWithIdentifier("APVComment", sender: self)
        }
    }
    
    func vAlert(){
        
        print(hasAnswered)
//        if hasAnswered == false{
        
        
            let alert = SCLAlertView()
            alert.showCloseButton = false
            alert.addButton("Answer This Question") { () -> Void in
            // segue to the addAnswerVC
                self.performSegueWithIdentifier("QQQ", sender: self)
            }
            alert.addButton("Cancel") { () -> Void in
                // unwindsegue to questionVC, create one
//                self.tableView.reloadData()
                self.jojjQQQ.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
            
            }
            alert.showInfo("You Must Contribute!", subTitle: "We can only do this if EVERYONE helps. Please provide answer to the assignment before viewing other answers.")
            
//        }
        
    }
    
    
    
    
    
     func queryAnswers(){
        
 //k               dispatch_async(dispatch_get_main_queue(), {

        //self.tableView.reloadData()
//        self.Answers.removeAll()
//        self.bothArray.removeAllObjects()
        self.hasIMGarray.removeAll()
        self.filesArray.removeAll()
        
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()


        let answerQuery = PFQuery(className: "Answers")
        print("SeeAnswerHERE")
        print(self.SeeAnswer)
        print(qI)
        if SeeAnswer != nil{// && self.qI == 0{
            answerQuery.whereKey("QuestionID", equalTo: SeeAnswer!)
            //self.qI = 1
        }else{
            answerQuery.whereKey("QuestionID", equalTo: self.QuestionID!)
//        answerQuery.whereKey("classname", equalTo: theClass!)
 //       answerQuery.whereKey("teacherName", equalTo: theTeacher!)
 //       answerQuery.whereKey("assignmentName", equalTo: theAssignment!)
//        answerQuery.whereKey("question", equalTo: theQuestion!)
        if self.theSchool != nil{
//            answerQuery.whereKey("School", equalTo: self.theSchool!)
        }else{
            print("theSchool equals nil")
        }
        }
//        answerQuery.orderByDescending("createdAt")
//        answerQuery.limit = 6

        
//        if self.qI == 2{
//            answerQuery.skip = 6
//            
//            print("skipped")
//        }
//        if self.qI == 3{
//            answerQuery.skip = 12
////            sleep(1)
//            print("skipped")
//        }
//        if self.qI == 4{
//            answerQuery.skip = 18
//            print("skipped")
//        }
//        if self.qI == 5{
//            answerQuery.skip = 24
//            print("skipped")
//        }
//        if self.qI == 6{
//            answerQuery.skip = 30
//            print("skipped")
//        }
//        if self.qI == 7{
//            answerQuery.skip = 36
//            print("skipped")
//        }
//        if self.qI == 8{
//            answerQuery.skip = 42
//            print("skipped")
//        }
//        
        
//        answerQuery.limit = 100
        answerQuery.orderByDescending("createdAt")
        answerQuery.findObjectsInBackgroundWithBlock { (results: [PFObject]?, error: NSError?) -> Void in

            if error == nil{
                
                if let results = results as [PFObject]?{
                    
                    for result in results{
                        let aObject = AnswerObject()

                        
                         let peter = result.objectForKey("hasAnImage") as? Bool
                         let answerID = result.objectId!
                        self.theAnswerIDs.append(answerID)
                        print(peter)
                        //self.hasIMGarray.append(peter!)
                        if peter! == true{
                        
                        let aAnswer = result["Answer"] as? String
                        let aName = result["username"] as? String
                        let aTorF = result["hasAnImage"] as? Bool
                        let anImage = result["AnswerImage"] as? PFFile
                        let aAProvider = result["usernameID"] as? String
                        let aDapCount = result["numOfDaps"] as? Int
                        let chi = result["Dappers"] as? [String]//NSMutableArray
                        let shorty = result["shortAnswer"] as? String
                        let proPic = result["profilePic"] as? PFFile
                        let username = result["username"] as? String
                        let aClass = result["classname"] as? String
                        let q = result["Question"] as? String
                            
                            if q != nil{
                                self.theQuestion = q!
                            }
                            if aClass != nil{
                                self.theClass = aClass
                                aObject.classname = aClass!
                            }
                            if username != nil{
                                aObject.username = username!
                            }
                            if proPic != nil{
                                aObject.proPicFile = proPic!
                                
                                let nninn = dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)
                                dispatch_async(nninn, { () -> Void in
                                    

                                proPic?.getDataInBackgroundWithBlock({ (theData :NSData?, error:NSError?) -> Void in
                                    if theData != nil{
                                        let ppImg = UIImage(data: theData!)
                                        dispatch_async(dispatch_get_main_queue(), { () -> Void in

                                            aObject.ppPic = ppImg
                                            self.tableView.reloadData()
                                        })

                                    }
                                })
                                })

                            }
                            if shorty != nil{
                                aObject.sAnswer = shorty!
                                print(shorty)
                            }
                            
                            if chi != nil{
                                aObject.Dappers = chi!
                                print(chi)
                            }
                            
                            if aDapCount != nil{
                                aObject.numOfDaps = aDapCount
                            }
                            if aAProvider != nil{
                                aObject.AnswerProviderID = aAProvider!
                            }
                            if aAnswer != nil{
                                aObject.lAnswer = aAnswer!
                            }
                            if aName != nil{
                                aObject.username = aName!
                            }
                            if aTorF != nil{
                                aObject.hasIMG = true
                            }
                            if anImage != nil{
                                aObject.imgFile = anImage
                                
                                
                                let nninn = dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)
                                dispatch_async(nninn, { () -> Void in
                                    
                                anImage?.getDataInBackgroundWithBlock({ (theData :NSData?, error:NSError?) -> Void in
                                    if theData != nil{
                                        let aImg = UIImage(data: theData!)
                                        
                                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                            aObject.cachedIMG = aImg
                                            self.tableView.reloadData()
                                        })

                                    }
                                })
                                })


                            }
                            aObject.date = result.createdAt!
                            aObject.AnswerID = result.objectId
                            aObject.theSay = "PAnswerComment"
                            
                            self.Answers.append(aObject)

                            
                        self.filesArray.append(anImage!)
                        self.hasIMGarray.append(aTorF!)
                    //|    self.answerArray.append(aAnswer!)
                        self.userArray.append(aName!)
//                        self.bothArray.addObject(aAnswer!)
                            print(self.filesArray.count)
                            print("")
                            print(anImage!)
                        }
                        if peter == false{
                            
                          let aAnswer = result["Answer"] as? String
                            let aName = result["username"] as? String
                            let aTorF = result["hasAnImage"] as? Bool
                            let fakeIMG = result["AnswerImage"] as? PFFile
                            let aAProvider = result["usernameID"] as? String
                            let aDapCount = result["numOfDaps"] as? Int
                            let chi = result["Dappers"] as? [String]//NSMutableArray
                            let shorty = result["shortAnswer"] as? String
                            let proPic = result["profilePic"] as? PFFile
                            let username = result["username"] as? String
                            let q = result["Question"] as? String
                            
                            if q != nil{
                                self.theQuestion = q!
                            }
                            if username != nil{
                                aObject.username = username!
                            }
                            if proPic != nil{
                                aObject.proPicFile = proPic!
                                
                                proPic?.getDataInBackgroundWithBlock({ (theData :NSData?, error:NSError?) -> Void in
                                    if error == nil{
                                        let ppImg = UIImage(data: theData!)
                                        aObject.ppPic = ppImg
                                    }
                                })
                            }
                            if shorty != nil{
                                aObject.sAnswer = shorty
                                print(shorty)
                            }
                            if chi != nil{
                                aObject.Dappers = chi!
                                print(chi)
                            }
                            /*   let fName = UIImage(named: "menu")
                                let iData = UIImagePNGRepresentation(fName!)
                            let fakeIMG : PFFile = PFFile(data: iData!)
                            */
                            if aDapCount != nil{
                                aObject.numOfDaps = aDapCount
                            }
                            if aAProvider != nil{
                                aObject.AnswerProviderID = aAProvider!
                            }
                            if aAnswer != nil{
                                aObject.lAnswer = aAnswer!
                            }
                            if aName != nil{
                                aObject.username = aName!
                            }
                            if aTorF != nil{
                                aObject.hasIMG = false
                            }
                            if fakeIMG != nil{
                                aObject.imgFile = fakeIMG
                            }
                            aObject.date = result.createdAt!
                            aObject.AnswerID = result.objectId
                            aObject.theSay = "AnswerComment"
                            
                            self.Answers.append(aObject)
                            self.filesArray.append(fakeIMG!)
                            self.hasIMGarray.append(aTorF!)
                            print("No IMG")
                            print(aAnswer)
                            print(aName)
                            print("END...")
                            
                            //changing that
//                            self.bothArray.addObject(aAnswer!)
                          //|  self.NanswerArray.append(aAnswer!)
                            self.NuserArray.append(aName!)
                            print(self.NanswerArray)
                            print("")
                            print(fakeIMG)
                            //self.tableview.reloadData()
                        }
                        
                        
                    }
                    self.sortIt()
//                    self.tableview.reloadData()
                    if self.Answers.count > 0 {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        
//                        self.tableview.reloadData()
//                        self.removeLoading()
//                        self.removeLoading()
                        UIApplication.sharedApplication().endIgnoringInteractionEvents()

                        sleep(1/2)
                        
                    })
                    }
//                    self.removeLoading()

                }
            }

//            self.removeLoading()

        }
    //    self.tableView.reloadData()
        print("self.tableView.reloadData()")
//k                });
//    })
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
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1//2 //1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return Answers.count + 1
//      
//        switch (section){
//        
//        case 0:
//            return 1
//            
//        case 1:
//
//            
//            print("CHECKPOINT")
//            print(bothArray.count)
//            print(hasIMGarray.count)
//            print(filesArray.count)
//            
//            return Answers.count
//
//
//        default:
//            return 0
//        }
//        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if Answers.count >= indexPath.row{
        let indexPathO = indexPath.row - 1

        print(indexPath.section)
        
        var celli : UITableViewCell?
        
//        if indexPath.section == 0{
        if indexPath.row == 0{

            let cell : AnswerQHeaderCell = tableView.dequeueReusableCellWithIdentifier("answerHeaderCell", forIndexPath: indexPath) as! AnswerQHeaderCell
            tableview.rowHeight = 209

            if self.theQuestion != nil{
                cell.QLabel.text = "\(self.theQuestion!)"
            }
            
            //tableView.rowHeight = 209
            //tableview.rowHeight = 209
            return cell

//            celli = cell
//            return celli!
        }else{
//            switch (self.Answers[indexPath.row].hasIMG){
            switch (self.Answers[indexPathO].hasIMG){
        case true:
            
            let cell : AnswerIMGCell = tableView.dequeueReusableCellWithIdentifier("a2Cell", forIndexPath: indexPath) as! AnswerIMGCell
            cell.delegate = self

            let theAnswer = self.Answers[indexPathO]
            print(self.Answers[indexPathO].lAnswer)
            print("happyhappyhappy")
            cell.dappers = self.Answers[indexPathO].Dappers
            cell.dapsButton.layer.borderColor = lBlue.CGColor
            print(self.Answers[indexPathO].date!)
            cell.dateLabel.text = "\(dts(self.Answers[indexPathO].date!))"
            if self.theClass != nil{
                cell.classLabel.text = self.theClass!
                
//                cell.classLabel.text = self.Answers[indexPath.row].classname
            }
            if self.Answers[indexPathO].sAnswer != nil{
                cell.shortAnswerLabel.text = self.Answers[indexPathO].sAnswer!
            }else{cell.shortAnswerLabel.text = ""}
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                if self.Answers[indexPathO].numOfDaps! == 0{
                    cell.dapsButton.setTitle(" | Dap", forState: .Normal)
                    
                }else if self.Answers[indexPathO].numOfDaps! == 1{
                    cell.dapsButton.setTitle(" | \(self.Answers[indexPathO].numOfDaps!) Dap", forState: .Normal)
                    
                }else{
                    cell.dapsButton.setTitle(" | \(self.Answers[indexPathO].numOfDaps!) Daps", forState: .Normal)
                }
//                cell.dapsButton.titleLabel?.text =
            })
            
            if self.Answers[indexPathO].ppPic != nil{
                cell.circle.image = self.Answers[indexPathO].ppPic
                cell.circle.layer.cornerRadius = 31
                cell.circle.layer.masksToBounds = true
            }else{print("no ppPic   ")}
            
            cell.usernameLabel.text = self.Answers[indexPathO].username
            cell.numDaps = self.Answers[indexPathO].numOfDaps!
            cell.AnswerID = self.Answers[indexPathO].AnswerID
            cell.AnswerProviderID = self.Answers[indexPathO].AnswerProviderID
            cell.theSay = self.Answers[indexPathO].theSay
            self.tableview.estimatedRowHeight = 465.0
            self.tableview.rowHeight = UITableViewAutomaticDimension
            

            
            cell.AnswerIMGView.image = UIImage(named: "menu")
            cell.answerLabel.text = theAnswer.lAnswer


        if theAnswer.cachedIMG != nil{
            cell.AnswerIMGView.image = theAnswer.cachedIMG
            print("got cach")
        }else{
            
            let nono = NSOperationQueue()
            let onon : NSBlockOperation = NSBlockOperation(block: {
//                cell.cellfile = self.filesArray[indexPath.row]
//                cell.cellfile!.getDataInBackgroundWithBlock({ (theData: NSData?, error: NSError?) -> Void in
//                    // he said IN not VIOD IN
//                    if let image : UIImage = UIImage(data: theData!){
//                        self.answerIMGArray.append(image)
//                        theAnswer.cachedIMG = image
//                        print("cached it")
//                        
//                        dispatch_async(dispatch_get_main_queue()) { // 2
//                            cell.AnswerIMGView.image = image
//                        }
//                    }
//                }) //END

                
            })//BLOCK-END
           
            nono.addOperation(onon)
            
        }
            return cell

//            celli = cell
//            return celli!
//            
            
            
            
            
        case false:
            let cell : AnswersTableViewCell = tableView.dequeueReusableCellWithIdentifier("aCell", forIndexPath: indexPath) as! AnswersTableViewCell
            
            cell.delegate = self

            
            let theAnswer = self.Answers[indexPathO]
            
            var cd = NSDate()
            theAnswer.main(cd)
            cell.dappers = self.Answers[indexPathO].Dappers
            cell.dateLabel.text = dts(self.Answers[indexPathO].date!)
            if self.proppie != nil{
                cell.proppie = self.proppie!
            }else{
                print("getting proppie")
                quickQuery()
            }
            cell.usernameLabel.text = self.Answers[indexPathO].username

            //let bbArray = self.bothArray as NSArray
            //cell.answerLabel?.text = "\(bbArray[indexPath.row])"
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                if self.Answers[indexPathO].numOfDaps! == 0{
                    cell.dapButton.setTitle(" | Dap", forState: .Normal)
                    
                }else if self.Answers[indexPathO].numOfDaps! == 1{
                    cell.dapButton.setTitle(" | \(self.Answers[indexPathO].numOfDaps!) Dap", forState: .Normal)

                }else{
                    cell.dapButton.setTitle(" | \(self.Answers[indexPathO].numOfDaps!) Daps", forState: .Normal)
                }
            })
            
            
            if self.Answers[indexPathO].sAnswer != nil{
                cell.answerLabel.text = self.Answers[indexPathO].sAnswer!
            }else{cell.answerLabel.text = ""}
            
            cell.circle.layer.cornerRadius = 31
            cell.circle.layer.masksToBounds = true
            cell.fullAnswerLabel.text = theAnswer.lAnswer
            if self.Answers[indexPathO].ppPic != nil{
                cell.circle.image = self.Answers[indexPathO].ppPic
                cell.circle.layer.cornerRadius = 31
                cell.circle.layer.masksToBounds = true

            }else{print("no ppPic   ")}
            
            
            
            
            cell.numDaps = self.Answers[indexPathO].numOfDaps!
//            cell.answerLabel.text = theAnswer.lAnswer
            cell.AnswerID = self.Answers[indexPathO].AnswerID
            cell.AnswerProviderID = self.Answers[indexPathO].AnswerProviderID
            cell.theSay = self.Answers[indexPathO].theSay
            if self.theClass != nil{
                cell.classLabel.text = self.theClass!
//                cell.classLabel.text = self.Answers[indexPath.row].classname
            }
            cell.circle.layer.cornerRadius = 31
            cell.dapButton.layer.borderColor = lBlue.CGColor
            //            });
            tableview.rowHeight = UITableViewAutomaticDimension
            tableview.estimatedRowHeight = 281.0
            
//            tableview.rowHeight = 300.0
            
            
            return cell

//            celli = cell
//            return celli!
//            
        }
        
      /*
    switch (indexPath.section){
        case 1:
            
        let cell : AnswerIMGCell = tableView.dequeueReusableCellWithIdentifier("a2Cell", forIndexPath: indexPath) as! AnswerIMGCell
 
        tableView.rowHeight = 362
        // Configure the cell...
        
        
        cell.answerLabel.text = "\(answerArray[indexPath.row])"
        
        
        //MARK:- Image Configuration
        cell.AnswerIMGView.image = UIImage(named: "menu")
 
       
        cell.cellfile = filesArray[indexPath.row]
        
        
        
        cell.cellfile?.getDataInBackgroundWithBlock({ (theData: NSData?, error: NSError?) -> Void in
            
            let image : UIImage = UIImage(data: theData!)!
            
            self.answerIMGArray.append(image)
            
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                // do some task
                print("thread 2")
                
                // WORKS HERE , IS JUST SLOW
                
                dispatch_async(dispatch_get_main_queue(), {
                    // update some UI
                    cell.AnswerIMGView.image = self.answerIMGArray[indexPath.row]
                    cell.spinning.stopAnimating()
                });
            });
            
            // End aImage.getdata...
        
        })
    
    
    
        return cell

    

        
        
    case 2:
        let cell : AnswersTableViewCell = tableView.dequeueReusableCellWithIdentifier("aCell", forIndexPath: indexPath) as! AnswersTableViewCell
        
        tableView.rowHeight = 135
        dispatch_async(dispatch_get_main_queue(), {
        cell.answerLabel.text = "\(self.NanswerArray[indexPath.row])"
        
        });
    
    
    
        return cell
    
    
    default:

        let cell : AnswersTableViewCell = tableView.dequeueReusableCellWithIdentifier("aCell", forIndexPath: indexPath) as! AnswersTableViewCell
        
        return cell
    
        }
        */
        
        }
//        return celli!
        } else{
            let cell = tableView.dequeueReusableCellWithIdentifier("cgg")
            
            return cell!
        }

    }
    
    
    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        if let cell : AnswerIMGCell = tableview.cellForRowAtIndexPath(indexPath) as? AnswerIMGCell{
//            
//            performSegueWithIdentifier("photoTVC", sender: cell)
//        }
//        
//    }
//    
    
    
    func verificationQuery(){
        let vQuery = PFQuery(className: "Answers")
        vQuery.whereKey("username", equalTo: "\(user!.username!)")
      //  vQuery.whereKey("Assignments", equalTo: theAssignment!)
        print("")
        print(user!.username!)
        print(theAssignment)
        
        vQuery.findObjectsInBackgroundWithBlock { (results: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil{
                if let results = results as [PFObject]?{
                    for result in results{
//                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            var answer = result["Answer"] as? String
                            print(answer)
                        if answer != nil{
                            self.vArray.append(answer!)
                        }
                            print(self.vArray.count)
                            //                        })
                        

                    }
                            if self.vArray.count < 1 {
                                self.hasAnswered = false
                                self.vAlert()
                            }else{
                                self.hasAnswered = true
                            }

                }
            }
        }
        
       /* var f = self.vArray.count
        if f == 0 {
            hasAnswered = false
        }else{
            hasAnswered = true
        }*/
        
        
    }
    
    

    
    
    
 
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // set identifier for segue 
        //photoTVC
        
        if segue.identifier == "questionToAnswer"{
            let vc: AddHWViewController = segue.destinationViewController as! AddHWViewController
            
            vc.seger = "questionToAnswer"
            vc.theQuestion = self.theQuestion!
            vc.QuestionID = self.QuestionID
            if self.QuestionerID != nil{
            vc.QuestionerID = self.QuestionerID
            }else{
                vc.QuestionerID = PFUser.currentUser()?.objectId!
            }
            vc.theClass = self.theClass

        }

        if segue.identifier == "photoTVC"{
            let vc: ViewPhotoAnswerTVC = segue.destinationViewController as! ViewPhotoAnswerTVC
            
            let roww = tableView.indexPathForSelectedRow?.row //{
                let row = roww! - 1

                let index = tableView.indexPathForSelectedRow


//                 let cell = self.tableView.cellForRowAtIndexPath(index) as! AnswerIMGCell
//                    if cell.AnswerIMGView.image != nil{
//                        vc.thePic = cell.AnswerIMGView.image!
//                    }else{
//                        if self.Answers[row].cachedIMG != nil{
//                            vc.thePic = self.Answers[row].cachedIMG
//                        }
//                    }
                
                
                if self.Answers[row].cachedIMG != nil{
                    vc.thePic = self.Answers[row].cachedIMG
                }
                vc.theQ = self.theQuestion! //self.Answers[row].Question
                vc.AnswerProviderID = self.Answers[row].AnswerProviderID
                vc.theAnswerID = self.theAnswerIDs[row]
                vc.theAnswer = self.Answers[row].lAnswer
                vc.theDate = self.Answers[row].date!
                print("This is the AnswerID: \(self.theAnswerIDs[row])")
                vc.AnswererUsername = self.Answers[row].username
                if self.Answers[row].ppPic != nil{
                    vc.userPic = self.Answers[row].ppPic
                }
                
            tableView.deselectRowAtIndexPath(index!, animated: true)

            
//            }
        }

        if segue.identifier == "APVComment"{
            
            let vc: AddCommentVC = segue.destinationViewController as! AddCommentVC
            
            vc.theSay = self.tS
            vc.AnswerProviderID = self.apI
            vc.AnswerID = self.aI
        }
        else if segue.identifier == "TextView"{
         
            let vc: ViewAnswerTVC = segue.destinationViewController as! ViewAnswerTVC
            
            let roww = tableView.indexPathForSelectedRow?.row //{
                
                let row = roww! - 1
                
                let index = tableView.indexPathForSelectedRow
                
//                let cell = self.tableView.cellForRowAtIndexPath(index!) as! AnswersTableViewCell
                
                vc.theQ = self.theQuestion! //self.Answers[row].Question
                vc.AnswerProviderID = self.Answers[row].AnswerProviderID
                vc.theAnswerID = self.Answers[row].AnswerID
//                vc.theAnswer = cell.fullAnswerLabel.text
                vc.theAnswer = Answers[row].lAnswer
                vc.theDate = self.Answers[row].date!
                //                if self.Answers[row].username ""{
                vc.AnswererUsername = self.Answers[row].username
                //                }
                if self.Answers[row].ppPic != nil{
                    vc.userPic = self.Answers[row].ppPic
                }
                tableView.deselectRowAtIndexPath(index!, animated: true)
//            }
        
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

    
    
    
    

            //MARK:- Lame Image Query
 /*
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
        
        let imageQuery = PFQuery(className: "Answers")
        imageQuery.orderByDescending("createdAt")
        imageQuery.limit = 2
        imageQuery.findObjectsInBackgroundWithBlock { (results: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil{
                
                if let results = results as [PFObject]?{
                    
                    for result in results{
                        
                     let aImage = result.objectForKey("AnswerImage") as? PFFile
                        

                        aImage!.getDataInBackgroundWithBlock({ (theData: NSData?, error: NSError?) in
                   
                            let image : UIImage = UIImage(data: theData!)!
                            
                            self.answerIMGArray.append(image)
                            
 //                           let getit = NSTimer.scheduledTimerWithTimeInterval(0.13, target: self, selector: "update", userInfo: nil, repeats: false)
                            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                                // do some task
                                print("thread 2")
                               
                                // WORKS HERE , IS JUST SLOW
                                
                                dispatch_async(dispatch_get_main_queue(), {
                                    // update some UI  
                                    cell.AnswerIMGView.image = self.answerIMGArray[indexPath.row]
                                    cell.spinning.stopAnimating()

                                });
                            });

                            // End aImage.getdata...
                        })
                        dispatch_async(dispatch_get_main_queue(), {
                          
   
                        
                        });

                        
                        
                    }
                }
            }
            
        }
        
                            });


     */
        //DISPATCH IS PROBABLY NEEDED
    
    
    
    
    
    
    
    
    
    
    //                                  OTHER
    
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
