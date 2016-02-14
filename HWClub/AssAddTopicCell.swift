//
//  AssAddTopicCell.swift
//  Dac
//
//  Created by Lyndon Samual McKay on 2/13/16.
//  Copyright © 2016 Lyndon Samual McKay. All rights reserved.
//

import UIKit

class AssAddTopicCell: UITableViewCell {

    @IBOutlet var addTopicButton : UIButton!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addTopicButton.layer.cornerRadius = 5
        
        addTopicButton.layer.borderColor = UIColor.whiteColor().CGColor
        addTopicButton.layer.borderWidth = 1
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
