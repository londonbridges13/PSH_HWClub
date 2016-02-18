//
//  ProfileTVC.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 12/25/15.
//  Copyright © 2015 Lyndon Samual McKay. All rights reserved.
//

import UIKit
import Parse

class ProfileTVC: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate  {

    @IBOutlet var SchoolLabel: UILabel!
    @IBOutlet var profilePictureButton: UIButton!
    @IBOutlet var menuButton: UIBarButtonItem!
    @IBOutlet var redCircle: UIImageView!
    @IBOutlet var blueCircle: UIImageView!
    @IBOutlet var yellowCircle: UIImageView!
    @IBOutlet var usernameLabel: UILabel!
    
    var theSchool : String?

    var imagePicker: UIImagePickerController!

    var oldPic : PFFile?
    var ido : String?
    var newPic : UIImage?
    
    
    var txt : String?
    var sentIMG : UIImage?
    var sendingIMG : Bool?
    
    var user : String?
    
    let cUser = PFUser.currentUser()

    @IBOutlet var Qnum : UILabel!
    @IBOutlet var Anum : UILabel!
    @IBOutlet var Cnum : UILabel!
    
    let dRed = UIColor(red: 234/255, green: 141/255, blue: 158/255, alpha: 1)

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(false)
        userInfoQuery()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        redCircle.layer.cornerRadius = 27
        blueCircle.layer.cornerRadius = 27
        yellowCircle.layer.cornerRadius = 27

        profilePictureButton.layer.cornerRadius = 33
        profilePictureButton.layer.masksToBounds = true
        self.profilePictureButton.imageView?.contentMode = .ScaleAspectFill
        profilePictureButton.layer.borderWidth = 2
        profilePictureButton.layer.borderColor = UIColor.whiteColor().CGColor
        
//        imagePicker.navigationBar.translucent = false
//        imagePicker.navigationBar.backgroundColor = dRed
        
        if cUser != nil{
            user = "@\((cUser?.username)!)"
            usernameLabel.text = user
        }else{
            print("shit no user")
            usernameLabel.text = ""
        }

        queryNotiis()
        queryAnswers()
        queryQuestions()
        //userInfoQuery()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            // Uncomment to change the width of menu
            //   self.revealViewController().rearViewRevealWidth = 200
        }

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
        return 5
    }
    
    
//    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool)
//    {
//        imagePicker.navigationBar.tintColor = .whiteColor()
//        imagePicker.navigationBar.titleTextAttributes = [
//            NSForegroundColorAttributeName : UIColor.whiteColor()
//        ]
//        
//    }
    
    
    
    func userInfoQuery(){
        let qUser = PFQuery(className: "_User")
        qUser.whereKey("username", equalTo: (cUser?.username)!)
        qUser.findObjectsInBackgroundWithBlock { (results :[PFObject]?, error:NSError?) -> Void in
            if error == nil{
                if let results = results as [PFObject]?{
                    for result in results{
                        let thePic = result["profilePic"] as? PFFile
                        let theQnum = result["numOfQAsked"] as? String
                        let School = result["School"] as? String
                        let theAnum = result["numOfAGiven"] as? String
                        let theCnum = result["numOfClasses"] as? Int
                        let theIDO = result.objectId
                        self.ido = theIDO!
                        if School != nil{
                            self.SchoolLabel.text = School!
                            self.theSchool = School!
                        }else{
                            self.SchoolLabel.text = "No School"
                            print("User Has No School")
                        }

                        if theQnum != nil{
                            self.Qnum.text = theQnum!
                        }else{
//                            self.Qnum.text = "0"
                        }
                        if theAnum != nil{
                            self.Anum.text = theAnum!
                        }else{
//                            self.Anum.text = "0"
                        }
                        if theCnum != nil{
//                            self.Cnum.text = "\(theCnum!)"
                        }else{
                            self.Cnum.text = "0"
                        }
                        if thePic != nil{
                            self.oldPic = thePic!
                            self.displayUserPic(self.oldPic!)
                        }else{
                            print("NO USER PIC")
                        }
                    }
                }
            }
        }
    }
    
    func displayUserPic(pfdata:PFFile){
        pfdata.getDataInBackgroundWithBlock { (theData: NSData?, error: NSError?) -> Void in
            let image = UIImage(data: theData!)
            self.profilePictureButton.setImage(image, forState: .Normal)
        }
    }
    
    func queryNotiis(){
        let qN = PFQuery(className: "ClassesFollowed")
        qN.whereKey("UserID", equalTo: (cUser?.objectId)!)
        qN.findObjectsInBackgroundWithBlock { (results: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil{
                
                if let results = results as [PFObject]?{
                    self.Cnum.text = "\(results.count)"
                    
                }
            }
        }
    }
    
    func queryAnswers(){
        let qN = PFQuery(className: "Answers")
        qN.whereKey("usernameID", equalTo: (cUser?.objectId)!)
        qN.findObjectsInBackgroundWithBlock { (results: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil{
                
                if let results = results as [PFObject]?{
                    self.Anum.text = "\(results.count)"
                    
                }
            }
        }
    }
    
    func queryQuestions(){
        let qN = PFQuery(className: "Questions")
        qN.whereKey("usernameID", equalTo: (cUser?.objectId)!)
        qN.findObjectsInBackgroundWithBlock { (results: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil{
                
                if let results = results as [PFObject]?{
                    self.Qnum.text = "\(results.count)"
                    
                }
            }
        }
    }
    
    
    
    func picToParse(img : UIImage){
        
        let User = PFQuery(className: "_User")
        //User.whereKey("username", equalTo: (cUser?.username)!)
        User.getObjectInBackgroundWithId(self.ido!) { (result :PFObject?, error: NSError?) -> Void in
            if error != nil{
                print(error?.description)
                
            }else if let result = result{
                let give = UIImageJPEGRepresentation(img, 1)//UIImagePNGRepresentation(img)
                let give1 = PFFile(data: give!)
                result["profilePic"] = give1
                print("Updated Profile Picture")
                

                result.saveInBackground()
            }
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func ChangePicture(sender: AnyObject) {
        let optionMenu = UIAlertController(title: nil, message: "Change Profile Picture", preferredStyle: .ActionSheet)
        
        //DBSWORD OPtion
        let beASwordOption = UIAlertAction(title: "Be a Sword", style: .Destructive) { (alert: UIAlertAction) -> Void in
            let dbSWORD = UIImage(named: "dbSWORD")
            let _ = self.picToParse(dbSWORD!)
            self.profilePictureButton.setImage(dbSWORD, forState: .Normal)
            self.profilePictureButton.imageView?.image = dbSWORD
            self.profilePictureButton.imageView?.contentMode = .ScaleAspectFit
            self.profilePictureButton.layer.cornerRadius = 33
            self.profilePictureButton.layer.masksToBounds = true
            self.profilePictureButton.layer.borderWidth = 2
            self.profilePictureButton.layer.borderColor = UIColor.whiteColor().CGColor
            
            self.seggy()

        }
        // 2
        let TPAction = UIAlertAction(title: "Take Photo", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.takePic()
            print("From Camera")
        })
        let PLAction = UIAlertAction(title: "Photo Library", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                //self.openPhotoLibrary()
                let image = UIImagePickerController()
                image.delegate = self
                image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                // if error change this back to uiimage... sourcetype.photolibrary
                self.presentViewController(image, animated: true, completion: nil)
                
                print("From Photo Library")
                
            })
        })
        
        //
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        
        // 4
        optionMenu.addAction(TPAction)
        optionMenu.addAction(PLAction)
        optionMenu.addAction(beASwordOption)
        optionMenu.addAction(cancelAction)
        
        // 5
        self.presentViewController(optionMenu, animated: true, completion: nil)

    }
    
    func takePic(){
        
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func openPhotoLibrary(){
        
        
        let image = UIImagePickerController()
        
        image.navigationBar.translucent = false
        image.navigationBar.barStyle = .BlackTranslucent
        image.navigationBar.barTintColor = dRed
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        // if error change this back to uiimage... sourcetype.photolibrary
        image.navigationBar.barStyle = .BlackTranslucent
        image.navigationBar.barTintColor = dRed

        self.presentViewController(image, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        sentIMG = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        let imga = sentIMG!
        
        //let img = sentIMG!.resize(0.1)
        let iimg = UIImageJPEGRepresentation(sentIMG!, 0.1)
        let img = UIImage(data: iimg!)!
        //newcode
        
        self.newPic = img
        picToParse(img)
        let maniiy = dispatch_get_main_queue()
        dispatch_async(maniiy) { () -> Void in
        self.profilePictureButton.setImage(imga, forState: .Normal)
        self.profilePictureButton.imageView?.image = imga
        self.profilePictureButton.imageView?.contentMode = .ScaleAspectFill
        self.profilePictureButton.layer.cornerRadius = 33
        self.profilePictureButton.layer.masksToBounds = true
        self.profilePictureButton.layer.borderWidth = 2
        self.profilePictureButton.layer.borderColor = UIColor.whiteColor().CGColor
        
            self.seggy()

            
           // self.userInfoQuery()
        }
//        userInfoQuery()

        picker.dismissViewControllerAnimated(true, completion: nil)


//        profilePictureButton.setImage(img, forState: .Normal)
//        profilePictureButton.layer.cornerRadius = 31
//        profilePictureButton.layer.masksToBounds = true
//        profilePictureButton.layer.borderWidth = 2
//        profilePictureButton.layer.borderColor = UIColor.whiteColor().CGColor
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        sentIMG = image.resize(0.1)
      
        let imga = image

//        let img = sentIMG!.resize(0.1)
        let iimg = UIImageJPEGRepresentation(sentIMG!, 0.1)
        let img = UIImage(data: iimg!)!
        //newcode
        
        self.newPic = img
        picToParse(img)
        //ImgView.image = sentIMG!
        let maniiy = dispatch_get_main_queue()
        dispatch_async(maniiy) { () -> Void in
        self.profilePictureButton.setImage(imga, forState: .Normal)
        self.profilePictureButton.imageView?.image = imga
        self.profilePictureButton.imageView?.contentMode = .ScaleAspectFill
        self.profilePictureButton.layer.cornerRadius = 31
        self.profilePictureButton.layer.masksToBounds = true
        self.profilePictureButton.layer.borderWidth = 2
        self.profilePictureButton.layer.borderColor = UIColor.whiteColor().CGColor
            
            self.seggy()

           // self.userInfoQuery()
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
       

        
//        profilePictureButton.setImage(img, forState: .Normal)
//        profilePictureButton.layer.cornerRadius = 31
//        profilePictureButton.layer.masksToBounds = true
//        profilePictureButton.layer.borderWidth = 2
//        profilePictureButton.layer.borderColor = UIColor.whiteColor().CGColor
        
    }
    

    func seggy(){
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc: SWRevealViewController = storyboard.instantiateViewControllerWithIdentifier("homeR") as! SWRevealViewController
        self.presentViewController(vc, animated: true, completion: nil)
        
    }

    

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    
    
    
    
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "mcNAVI"{
            let vc : MyClassesTableViewController = segue.destinationViewController as! MyClassesTableViewController
            
            vc.theSchool = self.theSchool
        }
    }


}
extension UIImage {
    func resize(scale:CGFloat)-> UIImage {
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: size.width*scale, height: size.height*scale)))
        imageView.contentMode = UIViewContentMode.ScaleAspectFill//ScaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContext(imageView.bounds.size)
        imageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
}
}
