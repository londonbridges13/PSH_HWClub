//
//  ViewAnswerAllOptionsCell.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 12/30/15.
//  Copyright © 2015 Lyndon Samual McKay. All rights reserved.
//

import UIKit
import Parse

class ViewAnswerAllOptionsCell: UITableViewCell {

    
    
    @IBOutlet var dapButton : UIButton!
    @IBOutlet var commentButton : UIButton!
    @IBOutlet var moreOptionsButton : UIButton!
    var dappers = [String]()
    var AnswerID : String?
    var cUser = PFUser.currentUser()
    var AnswerProviderID : String?

    var proppie : PFFile?
    let lBlue = UIColor(red: 134/255, green: 218/255, blue: 233/255, alpha: 1)

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        print(AnswerID)
        print(proppie)
        print(AnswerProviderID)
        print(dappers)
        
        dapButton.layer.borderColor = lBlue.CGColor
        dapButton.layer.borderWidth = 1
        dapButton.layer.borderColor = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1).CGColor
        dapButton.layer.cornerRadius = 8
    }
    @IBAction func dappingAnswer(){
        if self.AnswerID != nil{
            if dappers.contains(cUser!.objectId!) == false{
                self.dapButton.setTitle("| \(dappers.count + 1) Dap", forState: .Normal)

            DapAnswer(AnswerID!)
                if AnswerProviderID != cUser!.objectId!{
                    let _ = dapNotifyUser(AnswerProviderID!, cDapORaDap: "DapAnswer", giverUserName: cUser!.username!, pAoRvA: "Answer", answerID: AnswerID!, proppie: proppie!, theMessage: "\(cUser!.username!) just Dapped your Answer")
                }
            }else{
                // remove dap, remove objectid
            }
        }
    }
    
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
