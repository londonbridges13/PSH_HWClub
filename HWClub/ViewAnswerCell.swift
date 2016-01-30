//
//  ViewAnswerCell.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 12/30/15.
//  Copyright © 2015 Lyndon Samual McKay. All rights reserved.
//

import UIKit

class ViewAnswerCell: UITableViewCell {

    @IBOutlet var answerLabel : UILabel!
    @IBOutlet var dateLabel : UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
