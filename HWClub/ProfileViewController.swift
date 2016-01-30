//
//  ProfileViewController.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 9/24/15.
//  Copyright © 2015 Lyndon Samual McKay. All rights reserved.
//
import Parse

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet var tableview: UITableView!
    @IBOutlet var uLabel: UILabel!
    @IBOutlet var menuButton: UIBarButtonItem!
    var theSchool : String?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableview.delegate = self
        self.tableview.dataSource = self
        
        let cUser = PFUser.currentUser()
        
        if cUser != nil{
            //uLabel.text = "@\(cUser?.username)"
        }
        
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            // Uncomment to change the width of menu
         //   self.revealViewController().rearViewRevealWidth = 200
        }

        
        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCellWithIdentifier("", forIndexPath: indexPath)
        
        return cell
    }
    
//    override func preferredStatusBarStyle() -> UIStatusBarStyle {
//        return UIStatusBarStyle.LightContent
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
