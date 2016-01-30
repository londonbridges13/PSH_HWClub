//
//  HomeCell1.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 12/31/15.
//  Copyright © 2015 Lyndon Samual McKay. All rights reserved.
//

import UIKit

class HomeCell1: UITableViewCell {

    @IBOutlet var whatLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var userPic: UIImageView!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var userColor: UIImageView!
    @IBOutlet var classnameLabel: UILabel!
    @IBOutlet var byLabel: UILabel! // Posted By , Answered By ,Comment By
    
    @IBOutlet var highStatusLabel: UILabel!
    
    
    var theSchool : String?
    var theTeacher : String?
    var theClass : String?
    var theLesson : String? // theAssignment
    var theQuestion : String?
    var theAnswer : String?
    var theQComment : String?  // Comments on a Question
    var theAComment : String?  // Comments on a Answer
    var thePic : String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        userPic.layer.cornerRadius = 31
//        userPic.backgroundColor = UIColor.purpleColor()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
