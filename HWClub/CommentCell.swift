//
//  CommentCell.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 1/4/16.
//  Copyright © 2016 Lyndon Samual McKay. All rights reserved.
//

import UIKit
import Parse

protocol CommentCellDelegate{
    func dapComment(objy:String)
    func RemovedapComment(objy:String)
}
class CommentCell: UITableViewCell {

    var theAnswerID : String?
    @IBOutlet var userPicView: UIImageView!
    @IBOutlet var commentLabel: UILabel!
    @IBOutlet var UserNameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var dapButton: UIButton!
    var CommenterID :String?
    var cUser = PFUser.currentUser()
    var obID : String?
    var dappers = [String]()
    var delegate = CommentCellDelegate?()
    var picFile : PFFile?
    var proppie : PFFile?
    var theAnswer : String?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        dapButton.layer.borderWidth = 1
        dapButton.layer.borderColor = UIColor.whiteColor().CGColor
        dapButton.layer.cornerRadius = 9
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func dapping(sender: AnyObject) {
        let ioioiooioio = PFUser.currentUser()
        let diko = NSMutableArray(array: dappers)
        var RdNUM = dappers.count - 1
        var AdNUM = dappers.count + 1
        
        //cell.dapButton.setTitle(" | \(self.commys[rico].numOfDaps!) Dap", forState: .Normal)
        if diko.containsObject(ioioiooioio!.objectId!) == true{
            //remove dap
            
            //Removefunc is in dapComment below
            if let delegate = self.delegate{
                print(obID)
                let _ = delegate.dapComment(obID!)
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
                print(obID)
                let _ = delegate.dapComment(obID!)
                if proppie != nil{
                    let _ = dapNotifyUser(self.CommenterID!, cDapORaDap: "DapComment", giverUserName: cUser!.username!, pAoRvA: "Answer", answerID: theAnswerID!, proppie: self.proppie!, theMessage: self.theAnswer!)
                }else{print("No proppie")}
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

}
