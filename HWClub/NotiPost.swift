//
//  NaviPost.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 12/31/15.
//  Copyright © 2015 Lyndon Samual McKay. All rights reserved.
//

import Foundation
import Parse

class NotiPost {
    var cellNumber : Int?
    dynamic var NotiID : String?
    dynamic var theSchool : String?
    dynamic var theTeacher : String?
    dynamic var theClass : String?
    dynamic var theLesson : String? // theAssignment
    dynamic var theQuestion : String?
    dynamic var theAnswer : String?
    dynamic var theQComment : String?  // Comments on a Question
    dynamic var theAComment : String?  // Comments on a Answer
    dynamic var thePic : PFFile?
    dynamic var theDap : String?  // yes or no
    dynamic var numOfDaps : String?  // for the Daps Button
    dynamic var profilePic : PFFile?
    dynamic var theDate : NSDate?
    dynamic var theAnswerID : String?
    dynamic var theType : String?
    dynamic var theGiver : String?
    dynamic var cachedIMG : UIImage?
    dynamic var cachedIMGp : UIImage?
    dynamic var theDType : String?
    dynamic var QuestionID : String?
    var Recieved : Bool?
    
}

