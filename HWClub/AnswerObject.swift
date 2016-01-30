//
//  AnswerObject.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 12/18/15.
//  Copyright © 2015 Lyndon Samual McKay. All rights reserved.
//

import Foundation
import Parse

class AnswerObject  {
    
    dynamic var sAnswer : String?
    dynamic var lAnswer : String = ""
    dynamic var explaination : String = ""
    dynamic var username : String = ""
    dynamic var classname : String = ""     // for navigation purposes
    dynamic var teacher : String = ""       // for navigation purposes
    dynamic var assignment : String = ""    // for navigation purposes
    dynamic var date : NSDate?
    dynamic var hasIMG = false //by default
    dynamic var AnswerProviderID : String?
    dynamic var theSay : String?
    dynamic var AnswerID : String?
    var numOfDaps : Int?
    dynamic var proPicFile : PFFile?
    dynamic var ppPic : UIImage?
    dynamic var imgFile : PFFile?
    dynamic var IMG : UIImage?
    dynamic var cachedIMG : UIImage?
    dynamic var Question : String?
    dynamic var QuestionID : String?
    var Dappers = [String]()
    
    // HERE is where you convert the 'createdAt' date to Today @ 7:31
    func main(x: NSDate?){
        print("input \(x)Class func works")
    }
    
}