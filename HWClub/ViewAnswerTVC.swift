//
//  ViewAnswerTVC.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 12/30/15.
//  Copyright © 2015 Lyndon Samual McKay. All rights reserved.
//

import UIKit
import Parse

class ViewAnswerTVC: UITableViewController,aCommentCellDelegate {

    var theDappers = [String]()
    var theAnswer : String?
    var theAnswerID : String?
    let lBlue = UIColor(red: 134/255, green: 218/255, blue: 233/255, alpha: 1)
    var theDate : NSDate?
    var AnswerProviderID : String?

    var dapNUMs = [Int]()
    var theNotifyUser : String?
    var Commenters = [String]()
    var commentsArray = [String]()
    var commyDATES = [NSDate]()
    var derp : String?
    var commys = [CommyObject]()
    let cUser = PFUser.currentUser()
    var commentersNames = [String]()
    var proppie : PFFile?

    
    
    @IBOutlet var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(AnswerProviderID)
        
        if derp != nil{
            self.answerQuery()
//            wacthIT()
            print("derp")
        }else{
            self.answerQuery()
//            wacthIT()
            commentsQuery()
            tableView.reloadData()
            tableView.estimatedRowHeight = 146.0
            tableView.rowHeight = UITableViewAutomaticDimension
        }
//        tableView.estimatedRowHeight = 146.0
//        tableView.rowHeight = UITableViewAutomaticDimension
//        
//        tableview.reloadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2 + commentsArray.count
    }

    //325
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        switch indexPath.row{

        case 0:
            let cell : ViewAnswerCell = tableView.dequeueReusableCellWithIdentifier("answerContentCell", forIndexPath: indexPath) as! ViewAnswerCell
            tableview.rowHeight = UITableViewAutomaticDimension
            tableview.estimatedRowHeight = 325
            if self.theAnswer != nil{
                cell.answerLabel.text = self.theAnswer!
            }
            if self.theDate != nil{
                cell.dateLabel.text = dts(self.theDate!)
            }
            
            
            return cell
        case 1:
            
            let cell : ViewAnswerAllOptionsCell = tableView.dequeueReusableCellWithIdentifier("aBcell", forIndexPath: indexPath) as! ViewAnswerAllOptionsCell
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
            
            
        default:
            let cell : aCommentCell = tableView.dequeueReusableCellWithIdentifier("acommentCell", forIndexPath: indexPath) as! aCommentCell
            let rico = indexPath.row - 2
            tableview.rowHeight = 138
            cell.delegate = self

            cell.dapButton.layer.borderWidth = 1
            cell.dapButton.layer.borderColor = UIColor.whiteColor().CGColor
            cell.commentLabel.text = self.commentsArray[rico]
//            cell.dapButton.setTitle(" | \(self.commys[rico].numOfDaps!) Dap", forState: .Normal)
            if self.commys[rico].numOfDaps == 1{
                cell.dapButton.setTitle(" | \(self.commys[rico].numOfDaps!) Dap", forState: .Normal)
            }else{
                cell.dapButton.setTitle(" | \(self.commys[rico].numOfDaps!) Daps", forState: .Normal)
            }
            cell.userPicView.layer.cornerRadius = 23
            cell.userPicView.layer.masksToBounds = true
            cell.dateLabel.text = dts(self.commyDATES[rico])
            cell.obID = self.commys[rico].objectID!
            cell.dappers = self.commys[rico].Dappers
            print(self.commentersNames.count)
//            if self.commentersNames.count != 0{

                cell.UserNameLabel.text = self.commys[rico].theCommenter
                cell.picFile = self.commys[rico].theProfilePic
                
//            }else{print("No FUCKING COMMENTS")}
            cell.picFile?.getDataInBackgroundWithBlock({ (theData:NSData?, error:NSError?) -> Void in
                if let img =  UIImage(data: theData!){
                    cell.userPicView.image = img
                }else{print("COMMENT PIC ISSUE")}
            })
            return cell
        }
        

//            let cell : ViewPhotoAnswerMoreOptions = tableView.dequeueReusableCellWithIdentifier("aBcell", forIndexPath: indexPath) as! ViewPhotoAnswerMoreOptions
//            tableview.rowHeight = 80
//            cell.dapButton.layer.borderColor = self.lBlue.CGColor
//
//            return cell
//        }

        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc : AddCommentVC = segue.destinationViewController as! AddCommentVC
        
        vc.AnswerProviderID = self.AnswerProviderID!
        vc.AnswerID = self.theAnswerID!
        vc.theSay = "AnswerComment"
        vc.seggyCheck = "VATVC"

    }

    
    
    
    
    
    func dapComment(objy:String){
        
        DapComment(objy)
        
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

    
    
    @IBAction func unwindCommentSeggyVATVC(segue: UIStoryboardSegue){
        answerQuery()
    }
    
    
    func wacthIT(){
        _ = NSTimer.scheduledTimerWithTimeInterval(60.0, target: self, selector: Selector("sayHello"), userInfo: nil, repeats: true)

        
    }
    
    func sayHello(){
        answerQuery()
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
                        let PostedUser = comment["usernameID"] as? String
                        let Dappers = comment["Dappers"] as? [String]
                        
                        if Dappers != nil{
                            self.theDappers = Dappers!
                            print("Dappers\(Dappers)")
                        }else{
                            self.theDappers = []
                        }

                        self.theAnswerID = comment.objectId!
                        self.theDate = comment.createdAt!
                        
                        
                        if A != nil{
                            print(A!)
                            self.theAnswer = A!
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
                            print(chi!)
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
                        
                        self.commyDATES.append(comment.createdAt!)
                        
                        
                        
                    }
                    self.tableView.reloadData()
                    if self.commentsArray.count != 0{
                                                
                        print("LETS FUCKING GOOOO!!")
                    }else{
                        print("THE SHIT'S EQUAL TO 0!!")
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
