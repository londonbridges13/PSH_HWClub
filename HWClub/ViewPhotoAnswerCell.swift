//
//  ViewPhotoAnswerCell.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 12/29/15.
//  Copyright © 2015 Lyndon Samual McKay. All rights reserved.
//

import UIKit

class ViewPhotoAnswerCell: UITableViewCell {

    @IBOutlet var dateLabel: UILabel!

    @IBOutlet var answerLabel: UILabel!
    
    
    @IBOutlet var usernameLabel: UILabel!

    @IBOutlet var proPic: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
