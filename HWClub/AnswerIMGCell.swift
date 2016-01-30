//
//  AnswerIMGCell.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 9/30/15.
//  Copyright © 2015 Lyndon Samual McKay. All rights reserved.
//

import UIKit
import Parse

protocol IMGCustomCellDelegate{
    func flagPost(objyID:String)
    func dappedIt(objyID:String)
    func Comment(say:String, aID:String, aPID:String)
}

class AnswerIMGCell: UITableViewCell {

    
    
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var classLabel : UILabel!
    @IBOutlet var dateLabel : UILabel!
    @IBOutlet var shortAnswerLabel: UILabel!
    @IBOutlet var circle: UIImageView!
    var numDaps : Int?
    var dappers = [String]()
    var AnswerID : String?
    var AnswerProviderID : String?
    var theSay : String?
    var delegate = IMGCustomCellDelegate?()
    @IBOutlet var spinning: UIActivityIndicatorView!
    var answerIMG : UIImage?
//    @IBOutlet weak var backIMG: UIImageView!
    @IBOutlet var dapsButton: UIButton!
    @IBOutlet weak var AnswerIMGView: UIImageView!
    @IBOutlet var answerLabel: UILabel!
//    @IBOutlet var sameButton: UIButton!
    var cellfile : PFFile?
    
    let lBlue = UIColor(red: 134/255, green: 218/255, blue: 233/255, alpha: 1)

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code   
        
        dapsButton.layer.borderColor = lBlue.CGColor
        dapsButton.layer.borderWidth = 1
        dapsButton.layer.borderColor = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1).CGColor
        dapsButton.layer.cornerRadius = 8 //15
        

        //spinning.startAnimating()
        print("Im the CELL")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        // Configure the view for the selected state
    }

    @IBAction func DapButtonTapped() {
        
//        // When the button is pressed, buttonTapped method will send message to cell's delegate to call showActionSheet method.
//        if let delegate = self.delegate {
//            delegate.dappedIt(AnswerID!)
//        }
//        
        //   ORIGINAL ABOVE
        
        
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
                dapsButton.setTitle(" | \(RdNUM) Dap", forState: .Normal)
            }else{
                dapsButton.setTitle(" | \(RdNUM) Daps", forState: .Normal)
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
            }
            if AdNUM == 1{
                dapsButton.setTitle(" | \(AdNUM) Dap", forState: .Normal)
            }else{
                dapsButton.setTitle(" | \(AdNUM) Daps", forState: .Normal)
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

    @IBAction func FlagButtonTapped() {
        
        // When the button is pressed, buttonTapped method will send message to cell's delegate to call showActionSheet method.
        if let delegate = self.delegate {
            delegate.flagPost(AnswerID!)
        }
    }


}
