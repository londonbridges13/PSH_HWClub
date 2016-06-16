//
//  ExtraCodeStuff.swift
//  
//
//  Created by Lyndon Samual McKay on 5/24/16.
//
//

import Foundation
import UIKit
public func getDigits(Num : String) -> String {
    
    let stringArray = Num.componentsSeparatedByCharactersInSet(
        NSCharacterSet.decimalDigitCharacterSet().invertedSet)
    let newNum = stringArray.joinWithSeparator("")
    
    return newNum
}