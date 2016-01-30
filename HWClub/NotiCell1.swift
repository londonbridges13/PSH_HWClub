//
//  NotiCell1.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 12/31/15.
//  Copyright © 2015 Lyndon Samual McKay. All rights reserved.
//

import UIKit
import Parse
class NotiCell1: UITableViewCell {
    
    @IBOutlet var whatLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var userPic: UIImageView!
    
    var username : String?
    
    var theSchool : String?
    var theTeacher : String?
    var theClass : String?
    var theLesson : String? // theAssignment
    var theQuestion : String?
    var theAnswer : String?
    var theQComment : String?  // Comments on a Question
    var theAComment : String?  // Comments on a Answer
    var thePic : PFFile?
    var proPic : PFFile?
    
    var pictureselect : UIImage?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        userPic.layer.cornerRadius = 31
        userPic.backgroundColor = UIColor.purpleColor()
    }
    
    
    func changeColor(){
        print("Changeeeee")
        self.backgroundColor = UIColor(red: 242/255, green:  244/255, blue:  250/255, alpha: 1)
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
