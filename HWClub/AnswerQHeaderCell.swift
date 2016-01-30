//
//  AnswerHeaderCell.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 12/28/15.
//  Copyright © 2015 Lyndon Samual McKay. All rights reserved.
//

import UIKit

class AnswerQHeaderCell: UITableViewCell {

    let lBlue = UIColor(red: 134/255, green: 218/255, blue: 233/255, alpha: 1)

    @IBOutlet var QLabel: UILabel!
    @IBOutlet var answerButton: UIButton!
    @IBOutlet var commentButton: UIButton!
    @IBOutlet var moreButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        answerButton.layer.borderColor = lBlue.CGColor
        answerButton.layer.borderWidth = 1
        answerButton.layer.cornerRadius = 7
        answerButton.layer.masksToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
