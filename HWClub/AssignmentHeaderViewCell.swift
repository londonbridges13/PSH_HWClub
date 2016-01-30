//
//  AssignmentHeaderViewCell.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 9/27/15.
//  Copyright © 2015 Lyndon Samual McKay. All rights reserved.
//

import UIKit

protocol AssignmentDelagate{
    func followClass()
    func unfollowClass()
}

class AssignmentHeaderViewCell: UITableViewCell {

    @IBOutlet var classnameLabel: UILabel!
    @IBOutlet var teachernameLabel: UILabel!
    @IBOutlet var followButton: UIButton!
    @IBOutlet var newLessonButton: UIButton!
    
    var delegate = AssignmentDelagate?()

    let dRed = UIColor(red: 246/255, green: 118/255, blue: 134/255, alpha: 1)
    let lBlue = UIColor(red: 134/255, green: 218/255, blue: 233/255, alpha: 1)

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        followButton.layer.borderColor = lBlue.CGColor
        followButton.layer.borderWidth = 1
        followButton.layer.cornerRadius = 7
        followButton.layer.masksToBounds = true
        
        newLessonButton.layer.borderColor = lBlue.CGColor
        newLessonButton.layer.borderWidth = 1
        newLessonButton.layer.cornerRadius = 7
        newLessonButton.layer.masksToBounds = true
        

        newLessonButton.alpha = 0

        
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func followClassPressed(sender: AnyObject) {
        print(followButton.titleLabel?.text)
        if followButton.titleLabel?.text == "Follow" {
            
            if let delegate = self.delegate {
                delegate.followClass()
            }
            
            // change the color of the follow button
            followButton.setTitle("Following", forState: UIControlState.Normal)
            //followButton.layer.borderColor = dRed.CGColor
            followButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            followButton.backgroundColor = lBlue
            newLessonButton.alpha = 1

        }else{
            if let delegate = self.delegate {
                let q = dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)
                dispatch_async(q, { () -> Void in
                    delegate.unfollowClass()
                })
            }
            
            // change the color of the follow button
            followButton.setTitle("Follow", forState: UIControlState.Normal)
            followButton.layer.borderColor = lBlue.CGColor
            followButton.setTitleColor(lBlue, forState: .Normal)
            followButton.backgroundColor = UIColor.whiteColor()
            newLessonButton.alpha = 0


        }
        
    }

    
    
    

}
