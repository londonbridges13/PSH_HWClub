//
//  HomePost.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 12/31/15.
//  Copyright © 2015 Lyndon Samual McKay. All rights reserved.
//

import Foundation
import RealmSwift
import Parse

class HomePost {
    dynamic var ObjectID = "" //: String? = ""

    dynamic var theSchool : String?
    dynamic var theTeacher : String?
    dynamic var theClass : String?
    dynamic var theLesson : String? // theAssignment
    dynamic var theQuestion : String?
    dynamic var QuestionId : String?
    dynamic var theAnswer : String?
    dynamic var theQComment : String?  // Comments on a Question
    dynamic var theAComment : String?  // Comments on a Answer
    dynamic var thePic : PFFile?
    var date : NSDate?
    var hasIMG : Bool?
    var proCachy : UIImage?
    dynamic var cachedIMG : UIImage?
    dynamic var proPic : PFFile?
    dynamic var theAssignmentID : String?
    dynamic var AskerID : String?
    dynamic var theQuestionID : String?
    dynamic var theAnswerID : String?
    dynamic var theDap : String?  // yes or no
    dynamic var numOfDaps : String?  // for the Daps Button
    dynamic var What : String?
    dynamic var lowWhat : String?
    dynamic var highWhat : String?
    dynamic var POSTERNAME : String?
    dynamic var Type : String?
    dynamic var IDCheck : String?
    dynamic var cachedIMGDATA : NSData?
}




class RealmHomePost : Object {
    dynamic var ObjectID = "" //: String? = ""
    dynamic var theSchool = "" //: String?
    dynamic var theTeacher = "" //: String?
    dynamic var theClass = "" //: String?
    dynamic var theLesson = "" //: String? // theAssignment
    dynamic var theQuestion = "" //: String?
    dynamic var QuestionId = "" //: String?
    dynamic var theAnswer = "" //: String?
    dynamic var theQComment = "" //: String?  // Comments on a Question
    dynamic var theAComment = "" //: String?  // Comments on a Answer
//    dynamic var thePic = PFFile()
    dynamic var thePicNSData : NSData? = nil//= NSData()
    dynamic var date : NSDate? = nil//= NSDate()  //: NSDate?
    dynamic var hasIMG = false //: Bool?
//    var proCachy : UIImage?
    dynamic var proCachyNSData : NSData? = nil//= NSData()
//    dynamic var cachedIMG : UIImage?
    dynamic var cachedIMGNSData : NSData? = nil//= NSData()
//    dynamic var proPic : PFFile?
    dynamic var proPicData : NSData? = nil//= NSData()
    dynamic var theAssignmentID = "" //: String?
    dynamic var AskerID = "" //: String?
    dynamic var theQuestionID = "" //: String?
    dynamic var theAnswerID = "" //: String?
    dynamic var theDap = "" //: String?  // yes or no
    dynamic var numOfDaps = "" //: String?  // for the Daps Button
    dynamic var What = "" //: String?
    dynamic var lowWhat = "" //: String?
    dynamic var highWhat = "" //: String?
    dynamic var POSTERNAME = "" //: String?
    dynamic var Type = "" //: String?
    dynamic var IDCheck = "" //: String?
    
    dynamic var ExtraOne = "" //
    dynamic var ExtraTwo = "" //
    dynamic var ExtraThree = "" //
}