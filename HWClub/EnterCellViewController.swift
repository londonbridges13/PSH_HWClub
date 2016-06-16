//
//  ViewController.swift
//  testVerification
//
//  Created by Lyndon Samual McKay on 5/24/16.
//  Copyright © 2016 Lyndon Samual McKay. All rights reserved.
//

import UIKit
import SinchVerification


class EnterCellViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet var numberTX: UITextField! = nil
    
    @IBOutlet var sendTextButton: UIButton!
    
    @IBOutlet var callButton: UIButton!
    
    var theNum : String?
    
    var theUsername : String?
    var thePassword :String?
    
    var verification:Verification?
    
    var appKey = "fc1e2b5c-2a34-4ffb-b53b-a0368bd0c3a6"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.numberTX.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func textVerify(sender: AnyObject) {
        print("pressed")
        
        self.verification = SMSVerification(applicationKey: self.appKey, phoneNumber: "1\(numberTX.text!)")
        
        self.verification!.initiate { (success: Bool, error: NSError?) -> Void in
            if (success)
            {
                self.performSegueWithIdentifier("verifySeg", sender:self)
            }else{
                print(error?.description)
            }
        }
    }
    
    
    
    
    
    override func viewDidAppear(animated: Bool) {
        self.numberTX.becomeFirstResponder();
    }
    
    
    
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let stringArray = numberTX.text!.componentsSeparatedByCharactersInSet(
            NSCharacterSet.decimalDigitCharacterSet().invertedSet)
        theNum = stringArray.joinWithSeparator("")
        
        let newString = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
        let components = newString.componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet)
        
        let decimalString : String = components.joinWithSeparator("")
        let length = decimalString.characters.count
        let decimalStr = decimalString as NSString
        let hasLeadingOne = length > 0 && decimalStr.characterAtIndex(0) == (1 as unichar)
        
        if length == 0 || (length > 10 && !hasLeadingOne) || length > 11
        {
            let newLength = (textField.text! as NSString).length + (string as NSString).length - range.length as Int
            
            return (newLength > 10) ? false : true
        }
        var index = 0 as Int
        let formattedString = NSMutableString()
        
        if hasLeadingOne
        {
            formattedString.appendString("1 ")
            index += 1
        }
        if (length - index) > 3
        {
            let areaCode = decimalStr.substringWithRange(NSMakeRange(index, 3))
            formattedString.appendFormat("(%@)", areaCode)
            index += 3
        }
        if length - index > 3
        {
            let prefix = decimalStr.substringWithRange(NSMakeRange(index, 3))
            formattedString.appendFormat("%@-", prefix)
            index += 3
        }
        
        let remainder = decimalStr.substringFromIndex(index)
        formattedString.appendString(remainder)
        textField.text = formattedString as String
        return false
    }
    

    
    func getDigits(Num : String) -> String {
        
        let stringArray = Num.componentsSeparatedByCharactersInSet(
            NSCharacterSet.decimalDigitCharacterSet().invertedSet)
        var newNum = stringArray.joinWithSeparator("")
        
        
        return "1\(newNum)"
    }
    
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? VerifyCodeViewController {
            vc.verification = verification;
            
            
            vc.theUsername = self.theUsername!
            vc.thePassword = self.thePassword!
            
            
            vc.PhoneNumber = getDigits(self.numberTX.text!)
        }
    }


    
    
    // dont care
    @IBAction func call(sender: AnyObject) {
    }
    
    
    
    
}

