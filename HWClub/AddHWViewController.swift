//
//  AddHWViewController.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 10/11/15.
//  Copyright © 2015 Lyndon Samual McKay. All rights reserved.
//

import UIKit
import Parse

class AddHWViewController: UIViewController, UITextViewDelegate,UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var BackToQButton: UIButton!
    var shouldSend : Bool?
    
    
    @IBOutlet var BackToAButton: UIButton!
    
    
    
    var QuestionID : String?
    var QuestionerID : String?
    var theQuestion : String?
    var theSay : String?
    let cUser = PFUser.currentUser()
    var proppie : PFFile?
    var theClass : String?
    var seger : String?
    
    var howMEhere : String?
    // set teachername, class name, assignment, and question
    @IBOutlet var actINDI: UIActivityIndicatorView!
    

    @IBOutlet var unwindBuuton: UIButton!
    var klkl = PFUser.currentUser()
    
    var imagePicker: UIImagePickerController!
    
    @IBOutlet var shortAnswerTX: UITextField! = nil
    @IBOutlet var NewSenderButton: UIButton!
    @IBOutlet var doneButton: UIBarButtonItem!
    
    var txt : String?
    var sentIMG : UIImage?
    var sendingIMG : Bool?

    
    var dGray = UIColor(red: 106/255, green: 106/255, blue: 106/255, alpha: 1)
    @IBOutlet var answerTXT: UITextView! = nil
    @IBOutlet var ImgView: UIImageView!
    
    @IBOutlet var addPhotoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(howMEhere)
        actINDI.stopAnimating()
        print(QuestionerID)
        print(QuestionID)
        print(seger)
        
        quickQuery()
        self.shortAnswerTX.delegate = self
        
        self.shortAnswerTX.becomeFirstResponder()
        
        self.answerTXT.delegate = self
        answerTXT.text = "Full Answer"
        answerTXT.textColor = UIColor.lightGrayColor()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    
    
    @IBAction func showActionSheet(sender: AnyObject) {
        // 1
        let optionMenu = UIAlertController(title: nil, message: "Add a Picture", preferredStyle: .ActionSheet)
        
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
        optionMenu.addAction(cancelAction)
        
        // 5
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }
    
    
    

    
    
    @IBAction func newSendFunc(sender: AnyObject) {

        ParsePart()

    }
    
    func sendAnswers(){
        
        if shortAnswerTX.text != "" || answerTXT.text != ""{
 
            if shortAnswerTX.text == nil{
                shortAnswerTX.text = answerTXT.text
            }
            if shortAnswerTX.text == ""{
                shortAnswerTX.text = answerTXT.text
            }
            if answerTXT.text == "Full Answer"{
                print("Full House")
                answerTXT.text = shortAnswerTX.text
            }
            if answerTXT.text == ""{
                print("Full House")
                answerTXT.text = shortAnswerTX.text
            }
            
            
            if ImgView.image != nil{
                // set photo = to sentIMG
                
                self.sendingIMG = true
                print("sending Image")
                self.theSay = "PAnswer"
            }else{
                self.sendingIMG = false
                print("not sending Image")
                self.theSay = "Answer"

            }
            
            self.txt = answerTXT!.text
            
            print(self.txt!)
            
        }
        
    }

    func ParsePart(){
        
        answerTXT.endEditing(true)
        shortAnswerTX.endEditing(true)
        sendAnswers()
        
        if txt == nil{
            if sentIMG == nil{
                self.shouldSend = false
            }
        }
        
        if shouldSend != false{
        
        if self.QuestionerID != cUser!.objectId!{
            
                print("I AM")

        let answer = PFObject(className: "Answers")
        answer["Answer"] = self.answerTXT.text!
        answer["hasAnImage"] = sendingIMG!
            answer["username"] = klkl?.username!
            answer["shortAnswer"] = self.shortAnswerTX.text!
            answer["numOfDaps"] = 0
            answer["QuestionID"] = self.QuestionID
            answer["usernameID"] = klkl?.objectId!
            answer["profilePic"] = self.proppie!
            answer["Question"] = self.theQuestion!
            answer["classname"] = self.theClass

        print("passed 1")
        if sendingIMG == true{
            let iData = UIImagePNGRepresentation(sentIMG!)
            let aFile = PFFile(data: iData!)
            answer["AnswerImage"] = aFile
        }else{
            let zzz = UIImagePNGRepresentation(UIImage(named: "menu")!)
            let trans = PFFile(data: zzz!)
            answer["AnswerImage"] = trans
        }
        answer.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            print("saveditttttt")
            if (success == true){
                print("sent \(self.txt!)")
            }else{
                print("Error \(error!.description)")
            }
            self.notifyUser(self.QuestionerID!)
            self.answerTXT.endEditing(true)
            
            let aa = SCLAlertView()
            
            aa.showCloseButton = false
            aa.addButton("Great", action: { () -> Void in
            })
//            aa.addButton("View Answers", action: { () -> Void in
//                
//                // here add unwind bubububuttttttt
            
//            if self.howMEhere == nil{
//                self.unwindBuuton.sendActionsForControlEvents(.TouchUpInside)
//            }else{
//                self.BackToQButton.sendActionsForControlEvents(.TouchUpInside)
//            }
            
//                self.unwindBuuton.sendActionsForControlEvents(.TouchUpInside)
//                
//            })
            aa.showSuccess("Sent Answer", subTitle: "Great, your answer has be Successfully Posted")
            }
            }else{
                print("I AM NOT")
                let answer = PFObject(className: "Answers")
                answer["Answer"] = self.answerTXT.text!
                answer["hasAnImage"] = sendingIMG!
                answer["username"] = klkl?.username!
                answer["shortAnswer"] = self.shortAnswerTX.text!
                answer["numOfDaps"] = 0
                answer["QuestionID"] = self.QuestionID
                answer["usernameID"] = klkl?.objectId!
                answer["profilePic"] = self.proppie!
                answer["Question"] = self.theQuestion!
                answer["classname"] = self.theClass
                //ISSUE: Parse says Null value somewhere in here
                print("passed 1")
                if sendingIMG == true{
                    let iData = UIImagePNGRepresentation(sentIMG!)
                    let aFile = PFFile(data: iData!)
                    answer["AnswerImage"] = aFile
                }else{
                    let zzz = UIImagePNGRepresentation(UIImage(named: "menu")!)
                    let trans = PFFile(data: zzz!)
                    answer["AnswerImage"] = trans
                }
                answer.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                    print("saveditttttt")
                    if (success == true){
                        print("sent \(self.txt!)")
                    }else{
                        print("Error \(error!.description)")
                    }
//                    self.notifyUser(self.QuestionerID!)
                    self.answerTXT.endEditing(true)
                    
                    let aa = SCLAlertView()
                    
                    aa.showCloseButton = false
                    aa.addButton("Great", action: { () -> Void in
                        self.itt()
                    })
                    //            aa.addButton("View Answers", action: { () -> Void in
                    //
                    //                // here add unwind bubububuttttttt
//                    if self.howMEhere == nil{
//                        self.unwindBuuton.sendActionsForControlEvents(.TouchUpInside)
//                    }else{
//                        self.BackToQButton.sendActionsForControlEvents(.TouchUpInside)
//                    }
                    
                    //                self.unwindBuuton.sendActionsForControlEvents(.TouchUpInside)
                    //                
                    //            })
                    aa.showSuccess("Sent Answer", subTitle: "Great, your answer has be Successfully Posted")
                }

            }

    }
    }
    
    
    func notifyUser(notiUserid: String){
        print(notiUserid)
        print(theSay)
        let noti = PFObject(className: "Notifications")
        noti["recieved"] = false
        noti["getterID"] = self.QuestionerID
        noti["notiType"] = self.theSay
        noti["giverUserName"] = (cUser?.username)!
        noti["Answer"] = answerTXT.text
        noti["QuestionID"] = self.QuestionID
        noti["Question"] = self.theQuestion!
        noti["profilePic"] = self.proppie!
        noti["thePic"] = self.proppie!  // setting this up to aviod error
        print("yes IMG")
        print("no IMG")
        // SCHOOL Doesn't matter for comments
        noti.saveInBackgroundWithBlock({ (success:Bool, error:NSError?) -> Void in
            if (success == true){
                print("Notified User, and Done")
                self.pushNotify(self.QuestionerID!)
                self.itt()
                
            }else{
                print(error?.description)
            }
        })
    }
    
    func pushNotify(notifyThisOne: String){
        // Find users near a given location
        let userQuery = PFUser.query()
        userQuery!.whereKey("objectId", equalTo: notifyThisOne)
        
        
        // Find devices associated with these users
        let pushQuery = PFInstallation.query()
        //pushQuery!.whereKey("userID", equalTo: notifyThisOne)
        pushQuery!.whereKey("user", matchesQuery: userQuery!)
        
        
        // Send push notification to query
        let push = PFPush()
        push.setQuery(pushQuery) // Set our Installation query
        push.setMessage("\(cUser!.username!) answered your Question: \(self.theQuestion!)")
        push.sendPushInBackground()
        self.itt()

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
    
    
    func itt(){
        self.unwindBuuton.sendActionsForControlEvents(.TouchUpInside)
    }
    
    @IBAction func unwindING(sender: AnyObject) {
        
        if self.howMEhere == nil{
            self.BackToAButton.sendActionsForControlEvents(.TouchUpInside)
        }else{
            self.BackToQButton.sendActionsForControlEvents(.TouchUpInside)
        }
        if seger == "questionToAnswer"{
//            performSegueWithIdentifier("questionToAnswer", sender: self)
        }else{
//            performSegueWithIdentifier("qListToAnswer", sender: self)
        }
    }
    
    @IBAction func picViewfunc(sender: AnyObject) {
//        if self.ImgView.image != nil{
//            performSegueWithIdentifier("picview", sender: self)
//        }else{
//            print("no photo")
//        }
        
        let optionMenu = UIAlertController(title: nil, message: "Picture Options", preferredStyle: .ActionSheet)
        
        // 2
        let vAction = UIAlertAction(title: "View Photo", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            if self.ImgView.image != nil{
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.performSegueWithIdentifier("picview", sender: self)
                })
            }else{
                print("no photo")
            }
        })
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
        optionMenu.addAction(vAction)
        optionMenu.addAction(TPAction)
        optionMenu.addAction(PLAction)
        optionMenu.addAction(cancelAction)
        
        // 5
        self.presentViewController(optionMenu, animated: true, completion: nil)

        
    }
    
    @IBAction func newDoneButton(sender: AnyObject) {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            
            self.actINDI.startAnimating()

        }

        actINDI.hidesWhenStopped = false

        print("Newie")
        self.NewSenderButton.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
        
        actINDI.stopAnimating()
    }
    
    @IBAction func Done(sender: AnyObject) {
        print("pushed")
        
        ParsePart()
        //actINDI.startAnimating()
        
        
        //self.NewSenderButton.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "picview"{
                let vc : imageViewViewController = segue.destinationViewController as! imageViewViewController
        
            vc.theImage = self.ImgView.image!
        }
        if segue.identifier == "questionToAnswer"{
            let vc : AnswersTableViewController = segue.destinationViewController as! AnswersTableViewController
        }
        if segue.identifier == "qListToAnswer"{
            let vc : QuestionsTableViewController = segue.destinationViewController as! QuestionsTableViewController
        }
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    
    func takePic(){
        
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func openPhotoLibrary(){
        
        
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = .PhotoLibrary
    // if error change this back to uiimage... sourcetype.photolibrary
        self.presentViewController(image, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let uuu = info[UIImagePickerControllerOriginalImage] as? UIImage

        sentIMG = uuu?.resize(0.3)
        
        ImgView.image = uuu!

        picker.dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    
     func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
//        sentIMG = image.resize(0.1)
        let uuu = UIImageJPEGRepresentation(image, 0.3)
        sentIMG = UIImage(data: uuu!)
        ImgView.image = image//sentIMG!
        picker.dismissViewControllerAnimated(true, completion: nil)
    }

    
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        


        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        self.answerTXT.becomeFirstResponder()
        return true
    }
    
    
    

    func textViewShouldBeginEditing(textView: UITextView) -> Bool{
        if textView.text == "Full Answer"{
            textView.text = ""
            textView.textColor = self.dGray
            
        }
        
        
        print("keyboard")
        // Create a button bar for the number pad
        let keyboardDoneButtonView = UIToolbar()
        keyboardDoneButtonView.sizeToFit()
        
        // Setup the buttons to be put in the system.
        //let Ditem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("dopi") )
        let Ditem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: Selector("dopi"))
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil);
        
        let item = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Camera, target: self, action: Selector("tipi"))
        var toolbarButtons = [item,flexibleSpace,Ditem]
        
        //Put the buttons into the ToolBar and display the tool bar
        keyboardDoneButtonView.setItems(toolbarButtons, animated: false)
        textView.inputAccessoryView = keyboardDoneButtonView
        //        keyboardDoneButtonView.seti //= Ditem
        
        return true
    }
    
    func tipi(){
        self.addPhotoButton.sendActionsForControlEvents(.TouchUpInside)
    }
    
    
    func dopi(){
        print("pushed")
        
        actINDI.startAnimating()
        
        self.NewSenderButton.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
    }
    
    
    
    
    
}





/*
extension UIImage {
    func resize(scale:CGFloat)-> UIImage {
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: size.width*scale, height: size.height*scale)))
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContext(imageView.bounds.size)
        imageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
}
}*/