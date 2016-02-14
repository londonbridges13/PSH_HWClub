//
//  AssQuestionAskCell.swift
//  Dac
//
//  Created by Lyndon Samual McKay on 2/13/16.
//  Copyright © 2016 Lyndon Samual McKay. All rights reserved.
//

import UIKit

class AssQuestionAskCell: UITableViewCell {

    
    @IBOutlet var askButton : UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        askButton.layer.cornerRadius = 5
        
        askButton.layer.borderColor = UIColor.whiteColor().CGColor
        askButton.layer.borderWidth = 1
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
