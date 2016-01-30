//
//  QuestionTableViewCell.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 9/28/15.
//  Copyright © 2015 Lyndon Samual McKay. All rights reserved.
//

import UIKit

protocol toAnswerDelegate{
    func opop(qID:String,asker: String,theQ:String)
}

class QuestionTableViewCell: UITableViewCell {

        let lBlue = UIColor(red: 134/255, green: 218/255, blue: 233/255, alpha: 1)
    @IBOutlet var answerQButton: UIButton!
    @IBOutlet var circle: UIImageView!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var numOfALabel: UILabel!
    var QuestionID : String?
    var QuestionerID : String?
    var delegate = toAnswerDelegate?()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        answerQButton.layer.borderColor = lBlue.CGColor
        answerQButton.layer.borderWidth = 1
        answerQButton.layer.cornerRadius = 7
        answerQButton.layer.masksToBounds = true
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    
    @IBAction func answerIT(){
        if let delegate = self.delegate{
            delegate.opop(QuestionID!, asker: QuestionerID!, theQ: questionLabel.text!)
        }
    }

}
