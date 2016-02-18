//
//  AddSchoolVC.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 1/7/16.
//  Copyright © 2016 Lyndon Samual McKay. All rights reserved.
//

import UIKit

class AddSchoolVC: UIViewController, UITextFieldDelegate {

    var SchoolName : String?

    @IBOutlet var schoolTF : UITextField!
    @IBOutlet var Next : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        schoolTF.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func samefunc(){
        self.Next.sendActionsForControlEvents(.TouchUpInside)
    }
    
    
    @IBAction func addSchoolName(){
        while self.schoolTF?.text!.characters.last == " "{
            //            if theTopic?.characters.last == " "{
            print("remove")
            //                theTopic = newTopicTX.text
            print("\(self.schoolTF?.text!)ttt")
            var toko = self.schoolTF?.text!.substringToIndex((self.schoolTF?.text!.endIndex.predecessor())!)
            self.schoolTF?.text! = toko!
            print("\(self.schoolTF?.text!)ttt")
        }
        
        if schoolTF.text?.characters.count > 2{
            
            self.SchoolName = schoolTF.text!
            if self.SchoolName != nil{
                performSegueWithIdentifier("toLocation", sender: self)

            }else{
                print("youhoo")
            }
            
        }else{
            print("Must Have at least three characters")
        }
    }
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        self.Next.sendActionsForControlEvents(.TouchUpInside)
        
        return true
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc : AddCityVC = segue.destinationViewController as! AddCityVC
        
        vc.SchoolName = self.SchoolName!
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
