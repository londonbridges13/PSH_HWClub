//
//  CommyObject.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 1/16/16.
//  Copyright © 2016 Lyndon Samual McKay. All rights reserved.
//

import Foundation
import Parse

class CommyObject {
    dynamic var Comment : String?
    dynamic var theCommenter : String?
    dynamic var theCommenterID : String?
    dynamic var theProfilePic : PFFile?
    dynamic var objectID : String?
    var numOfDaps : Int?
    var Dappers = [String]()//NSMutableArray()

}