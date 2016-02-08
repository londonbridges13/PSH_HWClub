//
//  ChildViewController.swift
//  uisegmentInContainerCell
//
//  Created by Lyndon Samual McKay on 2/6/16.
//  Copyright © 2016 Lyndon Samual McKay. All rights reserved.
//

import UIKit

protocol Childing{
    func followClass()
    func unfollowClass()
}


class ChildViewController: UIViewController {

    
    @IBOutlet var myLabel : UILabel!
    @IBOutlet var teacherLabel : UILabel!
    @IBOutlet var follow : UIButton!
    @IBOutlet var saysom : UIButton!
    
    @IBOutlet var seggy : UISegmentedControl!
    
    var delegate = Childing?()
    
    let dRed = UIColor(red: 234/255, green: 141/255, blue: 158/255, alpha: 1)

    
    var shepard : String?
    override func viewDidLoad() {
        super.viewDidLoad()

        follow.setTitle("Follow", forState: UIControlState.Normal)

        if shepard != nil{
            myLabel.text = shepard!
        }
        
        saysom.layer.cornerRadius = 5
        follow.layer.cornerRadius = 5
        
        saysom.layer.borderColor = UIColor.whiteColor().CGColor
        saysom.layer.borderWidth = 1
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
//    
//    func yeah(){
//        
//        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 3 * Int64(NSEC_PER_SEC))
//        dispatch_after(time, dispatch_get_main_queue()) {
//
//        let red = self.parentViewController as! ViewController
//        
//        red.talk = "Yea BOI"
//            
//        }
//    }

    
    
    @IBAction func jacked(sender: AnyObject){
        
        if let delegate = self.delegate{
//            delegate.yeah("Yea BOI")
            // SEGGY TO

        }
    }
    
    
    @IBAction func followClassPressed(sender: AnyObject) {
        print(follow.titleLabel?.text)
        if follow.titleLabel?.text == "Follow" {
            
            if let delegate = self.delegate {
                delegate.followClass()
            }
            
            // change the color of the follow button
            follow.setTitle("Following", forState: UIControlState.Normal)
            //followButton.layer.borderColor = dRed.CGColor
            follow.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            follow.backgroundColor = dRed
//            follow.alpha = 1
            
        }else{
            if let delegate = self.delegate {
                let q = dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)
                dispatch_async(q, { () -> Void in
                    delegate.unfollowClass()
                })
            }
            
            // change the color of the follow button
            follow.setTitle("Follow", forState: UIControlState.Normal)
//            follow.layer.borderColor = UIColor.lightGrayColor().CGColor
            follow.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            follow.backgroundColor = UIColor.lightGrayColor()
//            newLessonButton.alpha = 0
            
            
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

}
