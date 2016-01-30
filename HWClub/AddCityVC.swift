//
//  AddCityVC.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 1/7/16.
//  Copyright © 2016 Lyndon Samual McKay. All rights reserved.
//

import UIKit

class AddCityVC: UIViewController, UITextFieldDelegate  {

    var SchoolName : String?
    var City_County : String?
    
    @IBOutlet var cityTF : UITextField!
    @IBOutlet var Next : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityTF.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func samefunc(){
        self.Next.sendActionsForControlEvents(.TouchUpInside)
    }
    
    
    @IBAction func addLocation(){
        if cityTF.text?.characters.count > 2{
            
            self.City_County = cityTF.text!
            if self.City_County != nil{
                performSegueWithIdentifier("toState", sender: self)
                
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
        let vc : AddStateTVC = segue.destinationViewController as! AddStateTVC
        print("This is the School and Location, Below")
        print(City_County)
        print(SchoolName)
        vc.City_County = self.City_County!
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
