//
//  NotiTVC.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 12/26/15.
//  Copyright © 2015 Lyndon Samual McKay. All rights reserved.
//

import UIKit
import Parse




class NotiTVC: UITableViewController {
    
    let cUser = PFUser.currentUser()
    @IBOutlet var menuButton : UIBarButtonItem!
    
    var proppie : UIImage?
    var School : String?
    
    let queue = dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)
    var nT : String?
    var Sc : String?
    var Tn : String?
    var Cn : String?
    var tQ : String?
    var tA : String?
    var tC : String?
    var LA : String?
    var gv : String?
    var dC : String?
    var pP : PFFile?
    var tP : PFFile?
    var aID : String?
    var recieved :Bool?
    var thepic : UIImage?
    
    var pNumber : String?
    
    var notis = [NotiPost]()
    //new
    var uniq = [NotiPost]()
    var phoneNotis = [NotiPost]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LoadingDesign()

        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        
        queryNotiis()

        tableView.reloadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func unwindToNOTI(){
        self.notis.removeAll()
        
        self.queryNotiis()
    }
    
    
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if notis.count == 0{
            return 1
        }else{
            return notis.count
        }
    }

    
    func recievedN(oID:String){
        
        let rt = PFQuery(className: "Notifications")
        rt.getObjectInBackgroundWithId(oID) { (result:PFObject?, error:NSError?) -> Void in
            if error == nil{
                if let result = result{
                    result["recieved"] = true
                    
                    result.saveInBackground()
                }
            }
        }
    }
    
    
    
    func BoldenTandT(boldenString:String, normalString:String)-> String{
        
        let fonty : UIFont = UIFont(name: "HelveticaNeue-UltraLight", size: 17)!
//        var normalText = "Hi am normal"
//        var boldText  = "And I am BOLD!"
//        let attributedString = NSMutableAttributedString(string:normalString)
        let attributedString = NSMutableAttributedString()
        let attrs = [NSFontAttributeName : UIFont.boldSystemFontOfSize(15)]
        let boldString = NSMutableAttributedString(string:boldenString, attributes:attrs)
        attributedString.appendAttributedString(boldString)
        let normy = [NSFontAttributeName : fonty]
        let norms = NSMutableAttributedString(string: normalString, attributes: normy)
        attributedString.appendAttributedString(norms)
        return "\(attributedString)"
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell : NotiCell1 = tableView.cellForRowAtIndexPath(indexPath) as! NotiCell1

        cell.backgroundColor = UIColor(red: 242/255, green:  244/255, blue:  250/255, alpha: 1)
        
        cell.changeColor()
        
        if self.notis[indexPath.row].NotiID != nil{
            self.recievedN(self.notis[indexPath.row].NotiID!)
        }
        
        if notis[indexPath.row].theType == "Invite"{
            
            performSegueWithIdentifier("Invite", sender: self)
            //                }
        }
            if notis[indexPath.row].theType == "DapAnswer"{
                if notis[indexPath.row].theDType == "PAnswer"{
                    
                    self.thepic = notis[indexPath.row].cachedIMGp
                    if self.thepic != nil{
                        performSegueWithIdentifier("PAnswered", sender: self)
                    }
                }
                if notis[indexPath.row].theDType == "Answer"{
                    performSegueWithIdentifier("Answered", sender: self)
                }
            }
            if notis[indexPath.row].theType == "DapComment"{
                if notis[indexPath.row].theDType == "PAnswer"{
                    self.thepic = notis[indexPath.row].cachedIMGp
                    if self.thepic != nil{
                        performSegueWithIdentifier("PAnswered", sender: self)
                    }
                }
                if notis[indexPath.row].theDType == "Answer"{
                    performSegueWithIdentifier("Answered", sender: self)
                }
            }
            if notis[indexPath.row].theType == "PAnswer"{
                self.thepic = notis[indexPath.row].cachedIMGp
//                if self.thepic != nil{
                    performSegueWithIdentifier("SeeAnswer", sender: self)
//                }
            }
            if notis[indexPath.row].theType == "PAnswerComment"{
                self.thepic = notis[indexPath.row].cachedIMGp
                if self.thepic != nil{
                    performSegueWithIdentifier("PAnswered", sender: self)
                }
            }
            if notis[indexPath.row].theType == "Answer"{
                performSegueWithIdentifier("SeeAnswer", sender: self)

            }
            if notis[indexPath.row].theType == "AnswerComment"{
                performSegueWithIdentifier("Answered", sender: self)

            }
            if notis[indexPath.row].theType == "NewLesson"{
//                dispatch_async(queue, { () -> Void in
//                    self.ReadIT(self.notis[indexPath.row].NotiID!)
//                })
                performSegueWithIdentifier("NewLesson", sender: self)

            }
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if notis.count == 0{
            let cell = tableView.dequeueReusableCellWithIdentifier("noNOTIS", forIndexPath: indexPath)
            tableView.rowHeight = 430
            return cell
        }else{
        
        let cell : NotiCell1 = tableView.dequeueReusableCellWithIdentifier("notiPostCell", forIndexPath: indexPath) as! NotiCell1
            
        if notis[indexPath.row].theType == "Invite"{
            cell.whatLabel.text = "\(notis[indexPath.row].theGiver!) invited you to \(notis[indexPath.row].theClass!)"
            cell.dateLabel.text = dts(notis[indexPath.row].theDate!)
            if notis[indexPath.row].Recieved! == false{
                cell.backgroundColor = UIColor.whiteColor()
                print("not checked yet")
            }else{
                cell.backgroundColor = UIColor(red: 242/255, green:  244/255, blue:  250/255, alpha: 1)
                print("checked it")
            }
            print(dts(notis[indexPath.row].theDate!))
            // get pics
            if notis[indexPath.row].profilePic != nil{
                let theAnswer = notis[indexPath.row]
                cell.userPic.layer.borderColor = UIColor.whiteColor().CGColor
                cell.userPic.layer.cornerRadius = 23
                cell.userPic.layer.masksToBounds = true
                if theAnswer.cachedIMG != nil{
                    cell.userPic.image = theAnswer.cachedIMG
                    print("got cach")
                }else{
                    let nono = NSOperationQueue()
                    let onon : NSBlockOperation = NSBlockOperation(block: {
                        cell.proPic = self.notis[indexPath.row].profilePic!
                        print(self.notis[indexPath.row].profilePic!)
                        cell.proPic!.getDataInBackgroundWithBlock({ (theData: NSData?, error: NSError?) -> Void in
                            // he said IN not VIOD IN
                            if let image : UIImage = UIImage(data: theData!){
                                print("starting img")
                                //                            self.answerIMGArray.append(image)
                                theAnswer.cachedIMG = image
                                print("cached it")
                                cell.userPic.image = image
                                //cell.AnswerIMGView.image = self.answerIMGArray[indexPath.row]
                                dispatch_async(dispatch_get_main_queue()) { // 2
                                    cell.userPic.image = image
                                }
                            }else{
                                print(error?.description)
                            }
                        }) //END
                        dispatch_async(dispatch_get_main_queue()) { // 2
                            //                        cell.spinning.stopAnimating()
                        }
                    })//BLOCK-END
                    nono.addOperation(onon)
                }
            }

        }

        if notis[indexPath.row].theType == "DapAnswer"{
            cell.whatLabel.text = "\(notis[indexPath.row].theGiver!) Dapped your Answer"
            cell.dateLabel.text = dts(notis[indexPath.row].theDate!)
            if notis[indexPath.row].Recieved! == false{
                cell.backgroundColor = UIColor.whiteColor()
                print("not checked yet")
            }else{
                cell.backgroundColor = UIColor(red: 242/255, green:  244/255, blue:  250/255, alpha: 1)
                print("checked it")
            }
            print(dts(notis[indexPath.row].theDate!))
            // get pics
            if notis[indexPath.row].profilePic != nil{
                let theAnswer = notis[indexPath.row]
                cell.userPic.layer.borderColor = UIColor.whiteColor().CGColor
                cell.userPic.layer.cornerRadius = 23
                cell.userPic.layer.masksToBounds = true
                if theAnswer.cachedIMG != nil{
                    cell.userPic.image = theAnswer.cachedIMG
                    print("got cach")
                }else{
                    let nono = NSOperationQueue()
                    let onon : NSBlockOperation = NSBlockOperation(block: {
                        cell.proPic = self.notis[indexPath.row].profilePic!
                        print(self.notis[indexPath.row].profilePic!)
                        cell.proPic!.getDataInBackgroundWithBlock({ (theData: NSData?, error: NSError?) -> Void in
                            // he said IN not VIOD IN
                            if let image : UIImage = UIImage(data: theData!){
                                print("starting img")
                                //                            self.answerIMGArray.append(image)
                                theAnswer.cachedIMG = image
                                print("cached it")
                                cell.userPic.image = image
                                //cell.AnswerIMGView.image = self.answerIMGArray[indexPath.row]
                                dispatch_async(dispatch_get_main_queue()) { // 2
                                    cell.userPic.image = image
                                }
                            }else{
                                print(error?.description)
                            }
                        }) //END
                        dispatch_async(dispatch_get_main_queue()) { // 2
                            //                        cell.spinning.stopAnimating()
                        }
                    })//BLOCK-END
                    nono.addOperation(onon)
                }
            }

        }
        if notis[indexPath.row].theType == "DapComment"{
            cell.whatLabel.text = "\(notis[indexPath.row].theGiver!) Dapped your Comment"
            cell.dateLabel.text = dts(notis[indexPath.row].theDate!)
            cell.userPic.layer.borderColor = UIColor.whiteColor().CGColor
            cell.userPic.layer.cornerRadius = 23
            cell.userPic.layer.masksToBounds = true
            if notis[indexPath.row].Recieved! == false{
                cell.backgroundColor = UIColor.whiteColor()
                print("not checked yet")
            }else{
                cell.backgroundColor = UIColor(red: 242/255, green:  244/255, blue:  250/255, alpha: 1)
                print("checked it")
            }
            print(dts(notis[indexPath.row].theDate!))
            // get pics
            if notis[indexPath.row].profilePic != nil{
                let theAnswer = notis[indexPath.row]
                if theAnswer.cachedIMG != nil{
                    cell.userPic.image = theAnswer.cachedIMG
                    print("got cach")
                }else{
                    let nono = NSOperationQueue()
                    let onon : NSBlockOperation = NSBlockOperation(block: {
                        cell.proPic = self.notis[indexPath.row].profilePic!
                        print(self.notis[indexPath.row].profilePic!)
                        cell.proPic!.getDataInBackgroundWithBlock({ (theData: NSData?, error: NSError?) -> Void in
                            // he said IN not VIOD IN
                            if let image : UIImage = UIImage(data: theData!){
                                print("starting img")
                                //                            self.answerIMGArray.append(image)
                                theAnswer.cachedIMG = image
                                print("cached it")
                                cell.userPic.image = image
                                //cell.AnswerIMGView.image = self.answerIMGArray[indexPath.row]
                                dispatch_async(dispatch_get_main_queue()) { // 2
                                    cell.userPic.image = image
                                }
                            }else{
                                print(error?.description)
                            }
                        }) //END
                        dispatch_async(dispatch_get_main_queue()) { // 2
                            //                        cell.spinning.stopAnimating()
                        }
                    })//BLOCK-END
                    nono.addOperation(onon)
                }
            }

        }
        
        if notis[indexPath.row].theType == "PAnswer"{
            cell.whatLabel.text = "\(notis[indexPath.row].theGiver!) answered your Question"
            cell.dateLabel.text = dts(notis[indexPath.row].theDate!)
            cell.userPic.layer.borderColor = UIColor.whiteColor().CGColor
            cell.userPic.layer.cornerRadius = 23
            cell.userPic.layer.masksToBounds = true
            if notis[indexPath.row].Recieved! == false{
                cell.backgroundColor = UIColor.whiteColor()
                print("not checked yet")
            }else{
                cell.backgroundColor = UIColor(red: 242/255, green:  244/255, blue:  250/255, alpha: 1)
                print("checked it")
            }
            print(dts(notis[indexPath.row].theDate!))
            
            // get pics
            if notis[indexPath.row].profilePic != nil{
                let theAnswer = notis[indexPath.row]
                if theAnswer.cachedIMG != nil{
                    cell.userPic.image = theAnswer.cachedIMG
                    print("got cach")
                }else{
                    let nono = NSOperationQueue()
                    let onon : NSBlockOperation = NSBlockOperation(block: {
                        cell.proPic = self.notis[indexPath.row].profilePic!
                        print(self.notis[indexPath.row].profilePic!)
                        cell.proPic!.getDataInBackgroundWithBlock({ (theData: NSData?, error: NSError?) -> Void in
                            // he said IN not VIOD IN
                            if let image : UIImage = UIImage(data: theData!){
                                print("starting img")
                                //                            self.answerIMGArray.append(image)
                                theAnswer.cachedIMG = image
                                print("cached it")
                                cell.userPic.image = image
                                //cell.AnswerIMGView.image = self.answerIMGArray[indexPath.row]
                                dispatch_async(dispatch_get_main_queue()) { // 2
                                    cell.userPic.image = image
                                }
                            }else{
                                print(error?.description)
                            }
                        }) //END
                        dispatch_async(dispatch_get_main_queue()) { // 2
                            //                        cell.spinning.stopAnimating()
                        }
                    })//BLOCK-END
                    nono.addOperation(onon)
                }
            }
            
            
        } 
        if notis[indexPath.row].theType == "PAnswerComment"{
            cell.whatLabel.text = "\(notis[indexPath.row].theGiver!) commented on your Answer"
//            cell.whatLabel.text = BoldenTandT(notis[indexPath.row].theGiver!, normalString: "commented on your Answer")
            cell.dateLabel.text = dts(notis[indexPath.row].theDate!)
            print(dts(notis[indexPath.row].theDate!))
            cell.userPic.layer.borderColor = UIColor.whiteColor().CGColor
            cell.userPic.layer.cornerRadius = 23
            cell.userPic.layer.masksToBounds = true
            if notis[indexPath.row].Recieved! == false{
                cell.backgroundColor = UIColor.whiteColor()
                print("not checked yet")
            }else{
                cell.backgroundColor = UIColor(red: 242/255, green:  244/255, blue:  250/255, alpha: 1)
                print("checked it")
            }
           // cell.thePic = notis[indexPath.row].thePic!
            cell.proPic = notis[indexPath.row].profilePic!
            
            // get pics
            if notis[indexPath.row].profilePic != nil{

            let theAnswer = notis[indexPath.row]
            if theAnswer.cachedIMG != nil{
                cell.userPic.image = theAnswer.cachedIMG
                print("got cach")
            }else{
                
                let nono = NSOperationQueue()
                let onon : NSBlockOperation = NSBlockOperation(block: {
                    cell.proPic = self.notis[indexPath.row].profilePic!
                    print(self.notis[indexPath.row].profilePic!)
                    cell.proPic!.getDataInBackgroundWithBlock({ (theData: NSData?, error: NSError?) -> Void in
                        // he said IN not VIOD IN
                        if let image : UIImage = UIImage(data: theData!){
                            print("starting img")
//                            self.answerIMGArray.append(image)
                            theAnswer.cachedIMG = image
                            print("cached it")
                            
                            cell.userPic.image = image

                            //cell.AnswerIMGView.image = self.answerIMGArray[indexPath.row]
                            dispatch_async(dispatch_get_main_queue()) { // 2
                                cell.userPic.image = image
                            }
                        }else{
                            print(error?.description)
                        }
                    }) //END
                    
                    
                    dispatch_async(dispatch_get_main_queue()) { // 2
//                        cell.spinning.stopAnimating()
                        
                    }
                    
                    
                })//BLOCK-END
                nono.addOperation(onon)
            }
        }
        
            
            
            if notis[indexPath.row].thePic != nil{
// round 2
            
            let theAnswertp = notis[indexPath.row]
            if theAnswertp.cachedIMGp != nil{
                cell.pictureselect = theAnswertp.cachedIMGp
                
                print("got cach")
            }else{
                
                let nono = NSOperationQueue()
                let onon : NSBlockOperation = NSBlockOperation(block: {
                    cell.thePic = self.notis[indexPath.row].thePic!
                    
                    cell.thePic!.getDataInBackgroundWithBlock({ (theData: NSData?, error: NSError?) -> Void in
                        // he said IN not VIOD IN
                        if let image : UIImage = UIImage(data: theData!){
                            //                            self.answerIMGArray.append(image)
                            theAnswertp.cachedIMGp = image
                            print("cached it")
                            
                            //cell.AnswerIMGView.image = self.answerIMGArray[indexPath.row]
                            dispatch_async(dispatch_get_main_queue()) { // 2
                                cell.pictureselect = image
                            }
                        }
                    }) //END
                    
                    
                    dispatch_async(dispatch_get_main_queue()) { // 2
                        //                        cell.spinning.stopAnimating()
                        
                    }
                    
                    
                })//BLOCK-END
                nono.addOperation(onon)
            }
            }
            
            
        }
        if notis[indexPath.row].theType == "Answer"{
            cell.whatLabel.text = "\(notis[indexPath.row].theGiver!) answered \(notis[indexPath.row].theQuestion!)"//your Question"
            cell.dateLabel.text = dts(notis[indexPath.row].theDate!)
            cell.userPic.layer.borderColor = UIColor.whiteColor().CGColor
            cell.userPic.layer.cornerRadius = 23
            cell.userPic.layer.masksToBounds = true
            if notis[indexPath.row].Recieved! == false{
                cell.backgroundColor = UIColor.whiteColor()
                print("not checked yet")
            }else{
                cell.backgroundColor = UIColor(red: 242/255, green:  244/255, blue:  250/255, alpha: 1)
                print("checked it")
            }
            print(dts(notis[indexPath.row].theDate!))
            // get pics
            if notis[indexPath.row].profilePic != nil{
                let theAnswer = notis[indexPath.row]
                if theAnswer.cachedIMG != nil{
                    cell.userPic.image = theAnswer.cachedIMG
                    print("got cach")
                }else{
                    let nono = NSOperationQueue()
                    let onon : NSBlockOperation = NSBlockOperation(block: {
                        cell.proPic = self.notis[indexPath.row].profilePic!
                        print(self.notis[indexPath.row].profilePic!)
                        cell.proPic!.getDataInBackgroundWithBlock({ (theData: NSData?, error: NSError?) -> Void in
                            // he said IN not VIOD IN
                            if let image : UIImage = UIImage(data: theData!){
                                print("starting img")
                                //                            self.answerIMGArray.append(image)
                                theAnswer.cachedIMG = image
                                print("cached it")
                                cell.userPic.image = image
                                //cell.AnswerIMGView.image = self.answerIMGArray[indexPath.row]
                                dispatch_async(dispatch_get_main_queue()) { // 2
                                    cell.userPic.image = image
                                }
                            }else{
                                print(error?.description)
                            }
                        }) //END
                        dispatch_async(dispatch_get_main_queue()) { // 2
                            //                        cell.spinning.stopAnimating()
                        }
                    })//BLOCK-END
                    nono.addOperation(onon)
                }
            }

        }
        if notis[indexPath.row].theType == "AnswerComment"{
            cell.whatLabel.text = "\(notis[indexPath.row].theGiver!) commented on your Answer"
            cell.dateLabel.text = dts(notis[indexPath.row].theDate!)
            cell.userPic.layer.borderColor = UIColor.whiteColor().CGColor
            cell.userPic.layer.cornerRadius = 23
            cell.userPic.layer.masksToBounds = true
            if notis[indexPath.row].Recieved! == false{
                cell.backgroundColor = UIColor.whiteColor()
                print("not checked yet")
            }else{
                cell.backgroundColor = UIColor(red: 242/255, green:  244/255, blue:  250/255, alpha: 1)
                print("checked it")
            }
            print(dts(notis[indexPath.row].theDate!))
            // get pics
            if notis[indexPath.row].profilePic != nil{
                let theAnswer = notis[indexPath.row]
                if theAnswer.cachedIMG != nil{
                    cell.userPic.image = theAnswer.cachedIMG
                    print("got cach")
                }else{
                    let nono = NSOperationQueue()
                    let onon : NSBlockOperation = NSBlockOperation(block: {
                        cell.proPic = self.notis[indexPath.row].profilePic!
                        print(self.notis[indexPath.row].profilePic!)
                        cell.proPic!.getDataInBackgroundWithBlock({ (theData: NSData?, error: NSError?) -> Void in
                            // he said IN not VIOD IN
                            if let image : UIImage = UIImage(data: theData!){
                                print("starting img")
                                //                            self.answerIMGArray.append(image)
                                theAnswer.cachedIMG = image
                                print("cached it")
                                cell.userPic.image = image
                                //cell.AnswerIMGView.image = self.answerIMGArray[indexPath.row]
                                dispatch_async(dispatch_get_main_queue()) { // 2
                                    cell.userPic.image = image
                                }
                            }else{
                                print(error?.description)
                            }
                        }) //END
                        dispatch_async(dispatch_get_main_queue()) { // 2
                            //                        cell.spinning.stopAnimating()
                        }
                    })//BLOCK-END
                    nono.addOperation(onon)
                }
            }

            
        }

        if notis[indexPath.row].theType == "NewLesson"{
            cell.whatLabel.text = "\(notis[indexPath.row].theGiver!) Added a New Lesson/Assignment to \(notis[indexPath.row].theClass!) "
            cell.userPic.layer.borderColor = UIColor.whiteColor().CGColor
            cell.userPic.layer.cornerRadius = 23
            cell.userPic.layer.masksToBounds = true
            if notis[indexPath.row].Recieved! == false{
                cell.backgroundColor = UIColor.whiteColor()
                print("not checked yet")
            }else{
                cell.backgroundColor = UIColor(red: 242/255, green:  244/255, blue:  250/255, alpha: 1)
                print("checked it")
            }
            cell.dateLabel.text = dts(notis[indexPath.row].theDate!)
            print(dts(notis[indexPath.row].theDate!))
            // get pics
            if notis[indexPath.row].profilePic != nil{
                let theAnswer = notis[indexPath.row]
                if theAnswer.cachedIMG != nil{
                    cell.userPic.image = theAnswer.cachedIMG
                    print("got cach")
                }else{
                    let nono = NSOperationQueue()
                    let onon : NSBlockOperation = NSBlockOperation(block: {
                        cell.proPic = self.notis[indexPath.row].profilePic!
                        print(self.notis[indexPath.row].profilePic!)
                        cell.proPic!.getDataInBackgroundWithBlock({ (theData: NSData?, error: NSError?) -> Void in
                            // he said IN not VIOD IN
                            if let image : UIImage = UIImage(data: theData!){
                                print("starting img")
                                //                            self.answerIMGArray.append(image)
                                theAnswer.cachedIMG = image
                                print("cached it")
                                cell.userPic.image = image
                                //cell.AnswerIMGView.image = self.answerIMGArray[indexPath.row]
                                dispatch_async(dispatch_get_main_queue()) { // 2
                                    cell.userPic.image = image
                                }
                            }else{
                                print(error?.description)
                            }
                        }) //END
                        dispatch_async(dispatch_get_main_queue()) { // 2
                            //                        cell.spinning.stopAnimating()
                        }
                    })//BLOCK-END
                    nono.addOperation(onon)
                }
            }


        }else{
            print("What the Fuck is this?")
        }
        tableView.rowHeight = 88
        // Configure the cell...

        return cell
        }
    }
    
    
    func queryNotiis(){
        let qN = PFQuery(className: "Notifications")
        qN.whereKey("getterID", equalTo: (cUser?.objectId)!)
        qN.orderByDescending("createdAt")
        qN.findObjectsInBackgroundWithBlock { (results: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil{
                
                if let results = results as [PFObject]?{
                    
                    for result in results{
                        let nicki = NotiPost()
                        
                        let type = result["notiType"] as? String
                        let giver = result["giverUserName"] as? String
                        let school = result["School"] as? String
                        let myTeacher = result["teacherName"] as? String
                        let myClass = result["classname"] as? String
                        let lessonAss = result["LessonAss"] as? String
                        let answer = result["Answer"] as? String
                        let question = result["Question"] as? String
                        let comment = result["Comment"] as? String
                        let dapCount = result["DapCount"] as? String
                        let proPic = result["profilePic"] as? PFFile
                        let thePic = result["thePic"] as? PFFile
                        let recieved = result["recieved"] as? Bool
                        let aID = result["AnswerID"] as? String
                        let dType = result["DType"] as? String
                        let qID = result["QuestionID"] as? String
                        
                        
                        
                        nicki.theDate = result.createdAt
                        nicki.NotiID = result.objectId!
                        
                        if qID != nil{
                            nicki.QuestionID = qID!
                        }
                        if dType != nil{
                            nicki.theDType = dType!
                        }
                        if aID != nil{
                            self.aID = aID!
                            nicki.theAnswerID = aID!
                        }
                        if type != nil{
                            self.nT = type!
                            nicki.theType = type!
                        }
                        if giver != nil{
                            self.gv = giver!
                            nicki.theGiver = giver!
                        }
                        if school != nil{
                            self.Sc = school!
                            nicki.theSchool = school!
                            print(nicki.theSchool)
                        }
                        if myTeacher != nil{
                            self.Tn = myTeacher!
                            nicki.theTeacher = myTeacher!
                        }
                        if myClass != nil{
                            self.Cn = myClass!
                            nicki.theClass = myClass!
                        }
                        if lessonAss != nil{
                            self.LA = lessonAss!
                            nicki.theLesson = lessonAss!
                        }
                        if answer != nil{
                            self.tA = answer!
                            nicki.theAnswer = answer!
                        }
                        if question != nil{
                            nicki.theQuestion = question!
                            self.tQ = question!
//                            nicki.theQuestion = question!
                        }else{print("no QQQQQ")}
                        if comment != nil{
                            self.tC = comment!
                            nicki.theQComment = comment!
                            nicki.theAComment = comment!
                        }
                        if dapCount != nil{
                            self.dC = dapCount!
                            nicki.theDap = dapCount!
                        }
                        if proPic != nil{
                            self.pP = proPic!
                            nicki.profilePic = proPic!
                            print(proPic)
                        }
                        if thePic != nil{
                            self.tP = thePic!
                            nicki.thePic = thePic!
                        }
                        if recieved != nil{
                            self.recieved = recieved!
                            nicki.Recieved = recieved!
                        }
                        self.notis.append(nicki)
                        self.tableView.reloadData()
//                        self.removeLoading()
                    }
//                    self.removeLoading()

                }
//                self.removeLoading()

            }else{
                print("\(error) ..... \(error!.userInfo)")
                if self.pNumber != nil{
                    self.queryPhoneNotis()
                }else{
                    self.removeLoading()
                }
            }
//            self.removeLoading()
            if self.pNumber != nil{
                self.queryPhoneNotis()
            }else{
                self.removeLoading()
            }
        }
        

        
    }
    
    
    
    
    // Phone Notifications Query
    
    func queryPhoneNotis(){
        let qN = PFQuery(className: "Notifications")
        qN.whereKey("PhoneNumbers", equalTo: (self.pNumber!))
//        qN.whereKey("PhoneNumber", containsString: "13147089391")//self.pNumber)
        qN.orderByDescending("createdAt")
        qN.findObjectsInBackgroundWithBlock { (results: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil{
                
                if let results = results as [PFObject]?{
                    
                    for result in results{
                        let nicki = NotiPost()
                        
                        
                        let type = result["notiType"] as? String
                        let phoneNumber = result["PhoneNumbers"] as? Int
                        let giver = result["giverUserName"] as? String
                        let school = result["School"] as? String
                        let myTeacher = result["teacherName"] as? String
                        let myClass = result["classname"] as? String
                        let lessonAss = result["LessonAss"] as? String
                        let answer = result["Answer"] as? String
                        let question = result["Question"] as? String
                        let comment = result["Comment"] as? String
                        let dapCount = result["DapCount"] as? String
                        let proPic = result["profilePic"] as? PFFile
                        let thePic = result["thePic"] as? PFFile
                        let recieved = result["recieved"] as? Bool
                        let aID = result["AnswerID"] as? String
                        let dType = result["DType"] as? String
                        let qID = result["QuestionID"] as? String
                        
                        
                        
                        nicki.theDate = result.createdAt
                        nicki.NotiID = result.objectId!
                        
                        if qID != nil{
                            nicki.QuestionID = qID!
                        }
                        if dType != nil{
                            nicki.theDType = dType!
                        }
                        if aID != nil{
                            self.aID = aID!
                            nicki.theAnswerID = aID!
                        }
                        if type != nil{
                            self.nT = type!
                            nicki.theType = type!
                        }
                        if giver != nil{
                            self.gv = giver!
                            nicki.theGiver = giver!
                        }
                        if school != nil{
                            self.Sc = school!
                            nicki.theSchool = school!
                            print(nicki.theSchool)
                        }
                        if myTeacher != nil{
                            self.Tn = myTeacher!
                            nicki.theTeacher = myTeacher!
                        }
                        if myClass != nil{
                            self.Cn = myClass!
                            nicki.theClass = myClass!
                        }
                        if lessonAss != nil{
                            self.LA = lessonAss!
                            nicki.theLesson = lessonAss!
                        }
                        if answer != nil{
                            self.tA = answer!
                            nicki.theAnswer = answer!
                        }
                        if question != nil{
                            nicki.theQuestion = question!
                            self.tQ = question!
                            //                            nicki.theQuestion = question!
                        }else{print("no QQQQQ")}
                        if comment != nil{
                            self.tC = comment!
                            nicki.theQComment = comment!
                            nicki.theAComment = comment!
                        }
                        if dapCount != nil{
                            self.dC = dapCount!
                            nicki.theDap = dapCount!
                        }
                        if proPic != nil{
                            self.pP = proPic!
                            nicki.profilePic = proPic!
                            print(proPic)
                        }
                        if thePic != nil{
                            self.tP = thePic!
                            nicki.thePic = thePic!
                        }
                        if recieved != nil{
                            self.recieved = recieved!
                            nicki.Recieved = recieved!
                        }
                        self.phoneNotis.append(nicki)
                        self.tableView.reloadData()
                        //                        self.removeLoading()
                    }
//                    self.removeLoading()
                    
                }
//                self.removeLoading()
                
            }else{
                print("\(error) ..... \(error!.userInfo)")
                if self.notis.count == 0 && self.phoneNotis.count == 0{
                    self.removeLoading()
                }else{
                    print("Notis.count = \(self.notis.count)")
                    print("PhoneNotis.count = \(self.phoneNotis.count)")

                    print("running GroupNotis")
                    //                self.sortIt()
                    self.queryGroupNotis()
                }

                //                self.sortIt()

            }
//            self.removeLoading()
            if self.notis.count == 0 && self.phoneNotis.count == 0{
                self.removeLoading()
            }else{
                print("Notis.count = \(self.notis.count)")
                print("PhoneNotis.count = \(self.phoneNotis.count)")

                print("running GroupNotis")
//                self.sortIt()
                self.queryGroupNotis()
            }
            
        }
        
        
        
    }
    

    
    func queryGroupNotis(){
        print("Starting GroupNotis")
        var userId = self.cUser!.objectId!
        let qN = PFQuery(className: "Notifications")
        qN.whereKey("gettersIDs", equalTo: (userId))
        //        qN.whereKey("PhoneNumber", containsString: "13147089391")//self.pNumber)
        qN.orderByDescending("createdAt")
        qN.findObjectsInBackgroundWithBlock { (results: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil{
                
                if let results = results as [PFObject]?{
                    
                    for result in results{
                        let nicki = NotiPost()
                        
                        
                        let type = result["notiType"] as? String
                        let phoneNumber = result["PhoneNumbers"] as? Int
                        let getters = result["gettersID"] as? String
                        let giver = result["giverUserName"] as? String
                        let school = result["School"] as? String
                        let myTeacher = result["teacherName"] as? String
                        let myClass = result["classname"] as? String
                        let lessonAss = result["LessonAss"] as? String
                        let answer = result["Answer"] as? String
                        let question = result["Question"] as? String
                        let comment = result["Comment"] as? String
                        let dapCount = result["DapCount"] as? String
                        let proPic = result["profilePic"] as? PFFile
                        let thePic = result["thePic"] as? PFFile
                        let recieved = result["recieved"] as? Bool
                        let aID = result["AnswerID"] as? String
                        let dType = result["DType"] as? String
                        let qID = result["QuestionID"] as? String
                        
                        
                        
                        nicki.theDate = result.createdAt
                        nicki.NotiID = result.objectId!
                        
                        if qID != nil{
                            nicki.QuestionID = qID!
                        }
                        if dType != nil{
                            nicki.theDType = dType!
                        }
                        if aID != nil{
                            self.aID = aID!
                            nicki.theAnswerID = aID!
                        }
                        if type != nil{
                            self.nT = type!
                            nicki.theType = type!
                        }
                        if giver != nil{
                            self.gv = giver!
                            nicki.theGiver = giver!
                        }
                        if school != nil{
                            self.Sc = school!
                            nicki.theSchool = school!
                            print(nicki.theSchool)
                        }
                        if myTeacher != nil{
                            self.Tn = myTeacher!
                            nicki.theTeacher = myTeacher!
                        }
                        if myClass != nil{
                            self.Cn = myClass!
                            nicki.theClass = myClass!
                        }
                        if lessonAss != nil{
                            self.LA = lessonAss!
                            nicki.theLesson = lessonAss!
                        }
                        if answer != nil{
                            self.tA = answer!
                            nicki.theAnswer = answer!
                        }
                        if question != nil{
                            nicki.theQuestion = question!
                            self.tQ = question!
                            //                            nicki.theQuestion = question!
                        }else{print("no QQQQQ")}
                        if comment != nil{
                            self.tC = comment!
                            nicki.theQComment = comment!
                            nicki.theAComment = comment!
                        }
                        if dapCount != nil{
                            self.dC = dapCount!
                            nicki.theDap = dapCount!
                        }
                        if proPic != nil{
                            self.pP = proPic!
                            nicki.profilePic = proPic!
                            print(proPic)
                        }
                        if thePic != nil{
                            self.tP = thePic!
                            nicki.thePic = thePic!
                        }
                        if recieved != nil{
                            self.recieved = recieved!
                            nicki.Recieved = recieved!
                        }
                        self.phoneNotis.append(nicki)
                        self.tableView.reloadData()
                        
                        
                        //                        self.removeLoading()
                    }
                    //                    self.removeLoading()
                    
                }
                //                self.removeLoading()
                
            }else{
                print("\(error) ..... \(error!.userInfo)")
                if self.notis.count == 0 && self.phoneNotis.count == 0{
                    self.removeLoading()
                }else{
                    print("Notis.count = \(self.notis.count)")
                    print("PhoneNotis.count = \(self.phoneNotis.count)")
                    
                    print("running sort it")
                    self.sortIt()
                }
                
                //                self.sortIt()
                
            }
            //            self.removeLoading()
            if self.notis.count == 0 && self.phoneNotis.count == 0{
                self.removeLoading()
            }else{
                print("Notis.count = \(self.notis.count)")
                print("PhoneNotis.count = \(self.phoneNotis.count)")
                
                print("running sort it")
                self.sortIt()
            }
            
        }
    }
    
    
    
    
    // Sorting Function
    
    func sortIt(){
        
//        
//        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 3/2 * Int64(NSEC_PER_SEC))
//        dispatch_after(time, dispatch_get_main_queue()) {
//            self.view.userInteractionEnabled = true
//        }
        
        print("Starting SortIt")

        if self.notis.count + self.phoneNotis.count >= 1{
            print("counting...")
            //            print(self.notis[0].date)
            self.phoneNotis.sortInPlace{ $0.theDate!.compare($1.theDate!) == .OrderedDescending}
            self.notis.sortInPlace{ $0.theDate!.compare($1.theDate!) == .OrderedDescending}
            //            print(self.notis[0].date)
            print(notis.count)
            var checker = [String]()
            
            var combinedNotis = self.phoneNotis + self.notis
            
            for each in combinedNotis{
                //            for each in notis{
                if checker.contains(each.NotiID!) == false {//&& each.date!.isGreaterThan(self.wAgo) == true{// && each.date! >= self.wAgo {
                    checker.append(each.NotiID!)
                    uniq.append(each)
                    print(notis.count)
                    print(uniq.count)
                }else{
                    print("WE Already have it")
                }
                //                }
            }
            self.notis = uniq
            print("WE GOTONE")
            print(notis)

//            self.allPosts.addObjectsFromArray(uniq)
            //            displayedPosts.addObjectsFromArray(allPosts.subarrayWithRange(NSMakeRange(0, 6)))
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
                self.removeLoading()
            })
            
            uniq.removeAll()
            //            phoneNotis.removeAll
            print("reloaded")
            self.removeLoading()

        }
    }
    

    
    
    
    
    func ReadIT(objectID : String){
        let rI = PFQuery(className: "Notifications")
        rI.getObjectInBackgroundWithId(objectID) { (result:PFObject?, error:NSError?) -> Void in
            if error == nil{
                if let result = result{
                    result["recieved"] = true
                    result.saveInBackground()
                }

            }
        }
    }
    
    
    
    
    // change to segue.id
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let row = tableView.indexPathForSelectedRow?.row

//        if self.nT == "AnswerDap"{
//            // same place as Aswered or PAnswered + theSpecial REQuer of info
//        }
//        if self.nT == "ACommentDap"{
//            // same as Answered or PAnswered + theSpecial REQuer of info
//        }
        
//        if self.nT == "QCommentDap"{
//            //new world extra work
//        }
//        if self.nT == "QComment"{
//            //new world extra work
//        }
        //Update
//        if self.nT == "AComment"{
//            // same as Answered or PAnswered + theSpecial REQuer of info
//        }

        if segue.identifier == "Answered"{
            let vc : ViewAnswerTVC = segue.destinationViewController as! ViewAnswerTVC
            // plus SpecialQuery
            if proppie != nil{
                vc.userPic = proppie!
            }
            if School != nil{
                vc.School = School
            }
            vc.derp = "not nil"
            if self.notis[row!].theAnswer != nil{
                vc.theAnswer = self.notis[row!].theAnswer!
            }
            vc.theAnswerID = self.notis[row!].theAnswerID!
            
            vc.AnswererUsername = cUser?.username!
            
//            self.queryNotiis()

//            if self.notis[row!].
        }
        
        if segue.identifier == "PAnswered"{
            let vc : ViewPhotoAnswerTVC = segue.destinationViewController as! ViewPhotoAnswerTVC
            // plus SpecialQuery
            //just trying something
//            vc.thePic = self.thepic! // convert to uiimage
//            vc.theAnswer = self.notis[row!].theAnswer!
            if proppie != nil{
                vc.userPic = proppie!
            }
            if School != nil{
                vc.School = School
            }
            vc.derp = "not nil"
            vc.theQ = self.notis[row!].theQuestion
            vc.chit = "seggy"
            vc.theAnswerID = self.notis[row!].theAnswerID!
//            self.queryNotiis()


        }
        if segue.identifier == "NewLesson"{
            let vc : QuestionsTableViewController = segue.destinationViewController as! QuestionsTableViewController
            vc.theSchool = self.notis[row!].theSchool!
            vc.theTeachername = self.notis[row!].theTeacher!
            vc.theClassname = self.notis[row!].theClass!
            vc.theAssignment = self.notis[row!].theLesson!
//            self.queryNotiis()

        }
        if segue.identifier == "SeeAnswer"{
            print("SeeAnswer")
            let vc : AnswersTableViewController = segue.destinationViewController as! AnswersTableViewController
            
            vc.SeeAnswer = self.notis[row!].QuestionID
//            self.queryNotiis()
        }
        if segue.identifier == "InviteOAss"{
            let vc : OtherAssignmentsTableViewController = segue.destinationViewController as! OtherAssignmentsTableViewController
            
            let row = tableView.indexPathForSelectedRow?.row
            
            // testPhoneSegue
            //            vc.assID = self.hPosts[row!].theAssignmentID
            vc.theTeacher = self.notis[row!].theTeacher!
            vc.theClass = self.notis[row!].theClass
            //            vc.theAssignment = self.hPosts[row!].theLesson
            vc.theSchool = self.notis[row!].theSchool
            //            vc.derp = "not nil"
            
            //  IF THE INVATATION IS FROM ANOTHER SCHOOL, ALERT USER BEFORE PROCEEDING OR AFTER

        }
        if segue.identifier == "Invite"{
            let vc : OtherAssignmentsTableViewController = segue.destinationViewController as! OtherAssignmentsTableViewController
            
            let row = tableView.indexPathForSelectedRow?.row
            if self.notis[row!].theTeacher != nil{
                vc.theTeacher = self.notis[row!].theTeacher!
            }
            if self.notis[row!].theClass != nil{
                vc.theClass = self.notis[row!].theClass!
            }
            if self.notis[row!].theSchool != nil{
                vc.theSchool = self.notis[row!].theSchool!
            }
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

    
    func removeLoading(){
        if let viewWithTag = self.view.viewWithTag(90) {
            print("Tag 100")
            viewWithTag.removeFromSuperview()
        }
        else {
            print("tag not found")
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
