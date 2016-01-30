//
//  AnswersTableViewCell.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 9/29/15.
//  Copyright © 2015 Lyndon Samual McKay. All rights reserved.
//

import UIKit
import Parse
protocol CustomCellDelegate{
    func flagPost(objyID:String)
    func dappedIt(objyID:String)
    func Comment(say:String, aID:String, aPID:String)
}

class AnswersTableViewCell: UITableViewCell {

    var AnswerID : String?
    var AnswerProviderID : String?
    var theSay : String?
    var delegate = CustomCellDelegate?()
    let cUser = PFUser.currentUser()
    var proppie : PFFile?
    
    
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var dapButton: UIButton!
    @IBOutlet var classLabel: UILabel!
    @IBOutlet var circle: UIImageView!
    @IBOutlet var answerLabel: UILabel!
    @IBOutlet var dateLabel : UILabel!
    
    @IBOutlet var fullAnswerLabel: UILabel!
    @IBOutlet var moreOptionsButton: UIButton!
    var dappers = [String]()
    let lBlue = UIColor(red: 134/255, green: 218/255, blue: 233/255, alpha: 1)
    var numDaps : Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        dapButton.layer.borderColor = lBlue.CGColor
        dapButton.layer.borderWidth = 1
        dapButton.layer.borderColor = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1).CGColor
        dapButton.layer.cornerRadius = 8
    }

    @IBAction func FlagButtonTapped() {
        
        // When the button is pressed, buttonTapped method will send message to cell's delegate to call showActionSheet method.
        if let delegate = self.delegate {
            delegate.flagPost(AnswerID!)
        }
    }
    
    @IBAction func DapButtonTapped() {
        
//        // When the button is pressed, buttonTapped method will send message to cell's delegate to call showActionSheet method.
//        if let delegate = self.delegate {
//            delegate.dappedIt(AnswerID!)
//        }
//        //
        //    ORIGINAL ABOVE
        
        let ioioiooioio = PFUser.currentUser()
        let diko = NSMutableArray(array: dappers)
        var RdNUM = dappers.count - 1
        var AdNUM = dappers.count + 1
        
        //cell.dapButton.setTitle(" | \(self.commys[rico].numOfDaps!) Dap", forState: .Normal)
        if diko.containsObject(ioioiooioio!.objectId!) == true{
            //remove dap
            
            //Removefunc is in dapComment below
            if let delegate = self.delegate{
                print(AnswerID)
                delegate.dappedIt(AnswerID!)
            }
            if RdNUM == 1{
                dapButton.setTitle(" | \(RdNUM) Dap", forState: .Normal)
            }else{
                dapButton.setTitle(" | \(RdNUM) Daps", forState: .Normal)
            }
            diko.removeObject(ioioiooioio!.objectId!)
            let riri = ioioiooioio!.objectId!
            let irir = dappers.indexOf(riri)
            dappers.removeAtIndex(irir!) // remove me from dappers
        }else{
            //add Daps
            
            if let delegate = self.delegate{
                print(AnswerID)
                delegate.dappedIt(AnswerID!)
                if proppie != nil{
                    if self.AnswerProviderID != cUser!.objectId!{
                        dapNotifyUser(AnswerProviderID!, cDapORaDap: "DapAnswer", giverUserName: cUser!.username!, pAoRvA: "PAnswer", answerID: AnswerID!, proppie: self.proppie!, theMessage: self.fullAnswerLabel.text!)
                    }else{print("I AM /DAPPED")}
                }else{print("proppie is nil")}
            }
            if AdNUM == 1{
                dapButton.setTitle(" | \(AdNUM) Dap", forState: .Normal)
            }else{
                dapButton.setTitle(" | \(AdNUM) Daps", forState: .Normal)
            }
            diko.addObject(ioioiooioio!.objectId!)
            dappers.append(ioioiooioio!.objectId!)
        }

    }
    
    @IBAction func CommentButtonTapped() {
        
        // When the button is pressed, buttonTapped method will send message to cell's delegate to call showActionSheet method.
        if let delegate = self.delegate {
            delegate.Comment(self.theSay!, aID: self.AnswerID!, aPID: self.AnswerProviderID!)
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func sameFunc(sender: AnyObject) {
    }
    @IBAction func moreOptions(sender: AnyObject) {

        
        //self.presentViewController(optionMenu, animated: true, completion: nil)
    }
    /*
    func flagPost(){
        let optionMenu = UIAlertController(title: nil, message: "Add a Picture", preferredStyle: .ActionSheet)
        let TPAction = UIAlertAction(title: "Flag Post", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("FLAGGED")
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        optionMenu.addAction(TPAction)
        optionMenu.addAction(cancelAction)
        self.presentViewController(optionMenu, animated: true, completion: nil)

        
    }
*/

}
