//
//  ViewPhotoAnswerTVC.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 12/29/15.
//  Copyright © 2015 Lyndon Samual McKay. All rights reserved.
//

import UIKit
import Parse

class ViewPhotoAnswerTVC: UITableViewController, CommentCellDelegate {

    @IBOutlet var tableview: UITableView!
    @IBOutlet var UNWans : UIButton!

    
    
    var qS : [Int] = [0,1,2,3,4,4,55,5,5,5,5,5,554,4,55,5,5,5,5,5,55,4,4,55,5,5,5,5,5,554,4,55,5,5,5,5,5,554,4,55,5,5,5,5,5,554,4,55,5,5,5,5,5,554,4,55,5,5,5,5,5,554,4,55,5,5,5,5,5,554,4,55,5,5,5,5,5,55,4,4,55,5,5,5,5,5,55]
    var theDappers = [String]()
    var chit : String?
    var theQ : String?
    var thePic : UIImage?
    var theAnswer : String?
    var theExplaination : String?
    let lBlue = UIColor(red: 134/255, green: 218/255, blue: 233/255, alpha: 1)
    var AnswerProviderID : String?
    var derp : String?
    var theDate : NSDate?
    var QuestionID : String?
    var dapNUMs = [Int]()
    var theNotifyUser : String?
    var Commenters = [String]()
    var theAnswerID : String?
    var commentsArray = [String]()
    var commyDATES = [NSDate]()
    var proppie : PFFile?
    var commys = [CommyObject]()
    var cUser = PFUser.currentUser()    
    var commentersNames = [String]()
    var commentersPics = [PFFile]()
//    var theClassname : String?
//    var theTeachername: String?
//    var theSchool : String?
//    var theAssignment : String?

    
//    @IBOutlet var photoView: UIImageView!
//    @IBOutlet var answerLabel: UILabel!
//    @IBOutlet var dapsButton: UIButton!
//    @IBOutlet var CommentButton: UIButton!
//    @IBOutlet var moreOptionsButton: UIButton!
//    @IBOutlet var dateLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if derp != nil{
            self.answerQuery()
//            wacthIT()
            print("derp")
        }else{
            self.answerQuery()

//            wacthIT()
            tableView.reloadData()
            tableView.estimatedRowHeight = 146.0
            tableView.rowHeight = UITableViewAutomaticDimension
        }
//        photoView.image = thePic!
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func unwindCommentSegueVPATVC(segue: UIStoryboardSegue){
        answerQuery()   
    }
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print( commentsArray.count)
        return 4 + commentsArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        // Configure the cell...

        switch indexPath.row{
        case 0:
            let cell : QLabelCell = tableView.dequeueReusableCellWithIdentifier("qLabel", forIndexPath: indexPath) as! QLabelCell
            tableview.rowHeight = 95
            if self.theQ != nil{
                cell.qLabel.text = self.theQ
            }
            return cell
        case 1:

            let cell : ViewPhotoAnswerPhotoCell = tableView.dequeueReusableCellWithIdentifier("photodisplay", forIndexPath: indexPath) as! ViewPhotoAnswerPhotoCell
            tableview.rowHeight = 407
            if self.thePic != nil{
                cell.photoView.image = self.thePic!
            }
            return cell

        case 2:
            let cell : ViewPhotoAnswerCell = tableView.dequeueReusableCellWithIdentifier("answerDisplayCell", forIndexPath: indexPath) as! ViewPhotoAnswerCell
            tableview.rowHeight = UITableViewAutomaticDimension
            tableview.estimatedRowHeight = 103
            if self.theAnswer != nil{
                cell.answerLabel.text = self.theAnswer!
            }
            if self.theDate != nil{
                cell.dateLabel.text = dts(self.theDate!)
            }

            return cell
        case 3:
        
            let cell : ViewPhotoAnswerMoreOptions = tableView.dequeueReusableCellWithIdentifier("buttonscell", forIndexPath: indexPath) as! ViewPhotoAnswerMoreOptions
            tableview.rowHeight = 80

            cell.dapButton.layer.borderColor = self.lBlue.CGColor
            if self.theDappers.count != 1{
                cell.dapButton.setTitle("| \(theDappers.count) Daps", forState: .Normal)
            }else{
                cell.dapButton.setTitle("| \(theDappers.count) Dap", forState: .Normal)
            }
            cell.AnswerProviderID = self.AnswerProviderID
            cell.AnswerID = self.theAnswerID
            cell.dappers = self.theDappers
            if self.proppie != nil{
                cell.proppie = proppie
            }else{
                quickQuery()
            }
            return cell

//
        default:
            let cell : CommentCell = tableView.dequeueReusableCellWithIdentifier("commentCell", forIndexPath: indexPath) as! CommentCell
            let rico = indexPath.row - 4
            tableview.rowHeight = 138
            cell.delegate = self

            cell.dapButton.layer.borderWidth = 1
            cell.dapButton.layer.borderColor = UIColor.whiteColor().CGColor
            cell.commentLabel.text = self.commentsArray[rico]
            if self.commys[rico].numOfDaps == 1{
                cell.dapButton.setTitle(" | \(self.commys[rico].numOfDaps!) Dap", forState: .Normal)
            }else{
                cell.dapButton.setTitle(" | \(self.commys[rico].numOfDaps!) Daps", forState: .Normal)
            }
            cell.userPicView.layer.cornerRadius = 23
            cell.userPicView.layer.masksToBounds = true
            //if self.commyDATES[rico] != nil{
            cell.dateLabel.text = dts(self.commyDATES[rico])
           // }
            cell.obID = self.commys[rico].objectID!
            cell.dappers = self.commys[rico].Dappers
            print(self.commentersNames.count)
            if self.commentersNames.count != 0{
//                print(self.commentersNames.count)
                //print(self.commentersNames[rico])
//                cell.UserNameLabel.text = self.commentersNames[rico]
//                cell.picFile = self.commentersPics[rico]
                cell.UserNameLabel.text = self.commys[rico].theCommenter
                cell.picFile = self.commys[rico].theProfilePic

            }else{print("No FUCKING COMMENTS")}
            cell.picFile?.getDataInBackgroundWithBlock({ (theData:NSData?, error:NSError?) -> Void in
                if let img =  UIImage(data: theData!){
                    cell.userPicView.image = img
                }else{print("COMMENT PIC ISSUE")}
            })
            return cell
        }

    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
//        var ti = tableView.indexPathForSelectedRow?.row
        
        if qS[indexPath.row] == 0{
            
        if self.chit == "seggy"{
            // Segue OVER
//            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.performSegueWithIdentifier("QLabelToA", sender: self)
//            })
        }else{
            // Unwind Segue
            print("UNWINDING")
            self.UNWans.sendActionsForControlEvents(.TouchUpInside)
//            performSegueWithIdentifier("photoTVC", sender: self) //photoTVC
        }
    }
    }
    
    
    
    


    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "VPTVCcomments"{
            let vc : AddCommentVC = segue.destinationViewController as! AddCommentVC
            vc.AnswerProviderID = self.AnswerProviderID
            vc.AnswerID = self.theAnswerID!
            vc.theSay = "PAnswerComment"
            vc.seggyCheck = "PATVC"
        }else if segue.identifier == "fifer"{
            let vc : AnswersTableViewController = segue.destinationViewController as! AnswersTableViewController
            
//            vc.QuestionerID = self.askers[row!]
            vc.QuestionID = self.QuestionID
//            vc.theClass = self.theClassname
//            vc.theAssignment = self.theAssignment
//            vc.theTeacher = self.theTeachername
            vc.theQuestion = self.theQ

            
        }else if segue.identifier == "photoTVC"{
            let vc : AnswersTableViewController = segue.destinationViewController as! AnswersTableViewController
            
            //            vc.QuestionerID = self.askers[row!]
            vc.QuestionID = self.QuestionID
            //            vc.theClass = self.theClassname
            //            vc.theAssignment = self.theAssignment
            //            vc.theTeacher = self.theTeachername
            vc.theQuestion = self.theQ
            
            
        }else if segue.identifier == "QLabelToA"{
            let vc : AnswersTableViewController = segue.destinationViewController as! AnswersTableViewController
            
            //            vc.QuestionerID = self.askers[row!]
            vc.QuestionID = self.QuestionID
            //            vc.theClass = self.theClassname
            //            vc.theAssignment = self.theAssignment
            //            vc.theTeacher = self.theTeachername
            vc.theQuestion = self.theQ

        }else if segue.identifier == "VPTVCcomments"{
            let vc : AddCommentVC = segue.destinationViewController as! AddCommentVC
            vc.AnswerProviderID = self.AnswerProviderID
            vc.AnswerID = self.theAnswerID!
            vc.theSay = "PAnswerComment"
            
        }else{
            let vc : imageViewViewController = segue.destinationViewController as! imageViewViewController
        if self.thePic != nil{
            vc.theImage = self.thePic!
        }
        vc.theImage = self.thePic!


        }        
    }
    
    
    
    func dapComment(objy:String){
        
        DapComment(objy)
    }
    
    func RemovedapComment(objy:String){
        
        
    }
    
    
    
    func wacthIT(){
        _ = NSTimer.scheduledTimerWithTimeInterval(60.0, target: self, selector: Selector("sayHello"), userInfo: nil, repeats: true)
        
        
    }
    
    func sayHello(){
        answerQuery()
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
    

    
    
    func answerQuery(){
        
        commys.removeAll()
        theDappers.removeAll()
        commentsArray.removeAll()
        commyDATES.removeAll()
        
        
        let cQ = PFQuery(className: "Answers")
        cQ.whereKey("objectId", equalTo: self.theAnswerID!)
        cQ.findObjectsInBackgroundWithBlock { (comments:[PFObject]?, error:NSError?) -> Void in
            if error == nil{
                if let comments = comments as [PFObject]?{
                    for comment in comments{
                        //                        let commentID = comment["CommentID"] as? String
                        let A = comment["Answer"] as? String
                        let AI = comment["AnswerImage"] as? PFFile
                        let PostedUser = comment["usernameID"] as? String
                        let theQuestion = comment["Question"] as? String
                        let aQuestionID = comment["QuestionID"] as? String
                        self.theAnswerID = comment.objectId!
                        self.theDate = comment.createdAt!
                        let Dappers = comment["Dappers"] as? [String]

                        if Dappers != nil{
                            self.theDappers = Dappers!
                            print("Dappers\(Dappers)")
                        }else{
                            self.theDappers = []
                        }
                        if aQuestionID != nil{
                            if self.QuestionID == nil{
                                print("QuestionID OMAMI")
                                self.QuestionID = aQuestionID!
                            }
                        }
                        
                        if theQuestion != nil{
                            if self.theQ == nil{
                                print("OMAMI")
                                self.theQ = theQuestion!
                            }
                        }
                        if A != nil{
                            print(A!)
                            self.theAnswer = A!
                        }
                        if AI != nil{
                            print(AI!)
                            
//                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.pfileToImg(AI!)
//                            })
                            
                        }
                        if PostedUser != nil{
                            print(PostedUser!)
                            self.AnswerProviderID = PostedUser!
                            // nothing yet
                        }
                        
                    }
                    self.tableView.reloadData()
                    self.commentsQuery()
                    
                }
            }

        }
    }
    
    
    
    
    
    
    
    
    func commentsQuery(){
        let cQ = PFQuery(className: "Comment")
        cQ.whereKey("AnswerID", equalTo: self.theAnswerID!)
        cQ.findObjectsInBackgroundWithBlock { (comments:[PFObject]?, error:NSError?) -> Void in
            if error == nil{
                if let comments = comments as [PFObject]?{
                    for comment in comments{
                        
                        var tComm = CommyObject()
//                        let commentID = comment["CommentID"] as? String
                        let AnswerID = comment["AnswerID"] as? String
                        let Comment = comment["Comment"] as? String
                        let numOfDaps = comment["numOfDaps"] as? Int
                        let CommentUser = comment["CommentUserID"] as? String
                        let NotifyUser = comment["NotifyUserID"] as? String
                        let CUN = comment["CommenterUserName"] as? String
                        let pP = comment["profilePic"] as? PFFile
                        let chi = comment["Dappers"] as? [String]//NSMutableArray

                        if chi != nil{
                            tComm.Dappers = chi!
                            print(chi)
                        }
                        if AnswerID != nil{
                            print(AnswerID!)
                        }
//                        if commentID != nil{
//                            print(commentID!)
//                        }
                        if Comment != nil{
                            print(Comment!)
                            tComm.Comment = Comment!
                            self.commentsArray.append(Comment!)
                        }
                        if numOfDaps != nil{
                            print(numOfDaps!)
                            tComm.numOfDaps = numOfDaps!
                            self.dapNUMs.append(numOfDaps!)
                        }
                        if CommentUser != nil{
                            print(CommentUser!)
                            tComm.theCommenterID = CommentUser!
                            self.Commenters.append(CommentUser!)
                            
                        }
                        if CUN != nil{
                            print(CUN!)
                            tComm.theCommenter = CUN!
                        }
                        if pP != nil{
                            print(pP!)
                            tComm.theProfilePic = pP!
                        }
                        if NotifyUser != nil{
                            print(NotifyUser!)
                            self.theNotifyUser = NotifyUser! // The One Who provided an answer
                        }
                        tComm.objectID = comment.objectId
                        self.commys.append(tComm)
                        
                        if comment.createdAt != nil{
                            self.commyDATES.append(comment.createdAt!)
                        }else{print("no creation date")}
                        
                        
                    }
                    self.tableView.reloadData()
                    if self.commentsArray.count != 0{
                        self.findingCommenters()
                        
                        
                        print("LETS FUCKING GOOOO!!")
                    }else{
                        print("THE SHIT'S EQUAL TO 0!!")
                    }
                }
            }
        }
        
    }
    
    func findingCommenters(){
//        print(user)
//        var i = 0
        print("\(self.Commenters) IS YOUR NUMBER")
//        for each in self.Commenters{
        
//            while i < self.Commenters.count{
//                print(self.Commenters[i])
        let mike = PFQuery(className: "_User")
        //print(self.Commenters)
        //for each in self.Commenters{
        mike.whereKey("objectId", containedIn: self.Commenters)
        mike.findObjectsInBackgroundWithBlock({ (Users:[PFObject]?, error:NSError?) -> Void in
//        mike.getObjectInBackgroundWithId(self.Commenters[i]) { (Users :PFObject?, error:NSError?) -> Void in
        
                if error == nil{
                    if let Users = Users as [PFObject]?{
//                    if let Users = Users{
                        for aUser in Users{
                            let username = aUser["username"] as? String
                            let userPhoto = aUser["profilePic"] as? PFFile
//                        let username = Users["username"] as? String
//                        let userPhoto = Users["profilePic"] as? PFFile
                        
                            if username != nil{
                                print(username!)
                                self.commentersNames.append(username!)
                            }else{print("SHit theres a PROB!!!")}
                            if userPhoto != nil{
                                print(userPhoto!)
                                self.commentersPics.append(userPhoto!)
                            }
                    }
                        }
                        self.tableView.reloadData()
                    
                }
            })


    }
    
    func findUsers(){
        let mike = PFQuery(className: "_User")
        //print(self.Commenters)
        //for each in self.Commenters{
        mike.whereKey("AnswerID", equalTo: self.theAnswerID!)
        mike.findObjectsInBackgroundWithBlock({ (Users:[PFObject]?, error:NSError?) -> Void in
            if error == nil{
                if let Users = Users as [PFObject]?{
                    for aUser in Users{
                        let username = aUser["username"] as? String
                        let userPhoto = aUser["profilePic"] as? PFFile
                        
                        if username != nil{
                            print(username!)
                            self.commentersNames.append(username!)
                        }else{print("SHit theres a PROB!!!")}
                        if userPhoto != nil{
                            print(userPhoto!)
                            self.commentersPics.append(userPhoto!)
                        }
                    }
                    self.tableView.reloadData()
                }
                
            }
        })
        //}
    }

    
    
    
    func pfileToImg(pif : PFFile){
        print("go get em")
        pif.getDataInBackgroundWithBlock { (theData:NSData?, error: NSError?) -> Void in
            print("go get em")
            let image = UIImage(data: theData!)
            self.thePic = image!
            print("time")
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.thePic = image!
                self.tableView.reloadData()

            })
            
            
        }
        
        
    }
    
    
    
    func dapComment(){
        
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
