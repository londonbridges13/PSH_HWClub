//
//  HomeCellPic.swift
//  Dac
//
//  Created by Lyndon Samual McKay on 1/23/16.
//  Copyright © 2016 Lyndon Samual McKay. All rights reserved.
//

import UIKit

class HomeCellPic: UITableViewCell {

    @IBOutlet var classLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var PictureView: UIImageView!
    @IBOutlet var QuestionLabel: UILabel!
    @IBOutlet var AnswerLabel: UILabel!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var userPic: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
