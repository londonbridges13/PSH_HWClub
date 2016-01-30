//
//  DateConversion.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 12/31/15.
//  Copyright © 2015 Lyndon Samual McKay. All rights reserved.
//

import Foundation

class DateConversion {
    
}

public func dts(date : NSDate)->String{
    let today = NSDate()
    var theString : String?
    print(date.dayy)
    print(today.dayy)
    if date.dayy == today.dayy{
        // Today @ 12:23
        let h = date.hourr
        let m = date.minutee
        var hh : Int?
        var mm : String?
        
        print(h)
        print(m)
        if h == 1{
            hh = 1
        };if h == 13{
            hh = 1
        };if h == 2{
            hh = 2
        };if h == 14{
            hh = 2
        };if h == 3{
            hh = 3
        };if h == 15{
            hh = 3
        };if h == 4{
            hh = 4
        };if h == 16{
            hh = 4
        };if h == 5{
            hh = 5
        };if h == 17{
            hh = 5
        };if h == 6{
            hh = 6
        };if h == 18{
            hh = 6
        };if h == 7{
            hh = 7
        };if h == 19{
            hh = 7
        };if h == 8{
            hh = 8
        };if h == 20{
            hh = 8
        };if h == 9{
            hh = 9
        };if h == 21{
            hh = 9
        };if h == 10{
            hh = 10
        };if h == 22{
            hh = 10
        };if h == 11{
            hh = 11
        };if h == 23{
            hh = 11
        };if h == 12{
            hh = 12
        };if h == 24{
            hh = 12
        };if h == 0{
            hh = 1
        }
        
        
        mm = "\(m)"
        
        if mm?.characters.count == 1{
            mm = "0\(m)"
        }
        
        
        print(mm!)
        print(hh!)
        theString = "Today @ \(hh!):\(mm!)"
        print(theString!)
        return theString!

    }else{
        // 12/21/16
        let dd = date.dayy
        let mm = date.monthh
        let yy = date.yearr
        
        theString = "\(mm)/\(dd)/\(yy)"
//        print("Down with the sauce!")
        print(theString!)
        return theString!
    }
    
}