//
//  NoClassHomeCell.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 1/1/16.
//  Copyright © 2016 Lyndon Samual McKay. All rights reserved.
//

import UIKit

class NoClassHomeCell: UITableViewCell {

    var teal : UIColor = UIColor(red: 52, green: 185, blue: 208, alpha: 1)
    
    @IBOutlet var findClassButton : UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        findClassButton.layer.borderColor = teal.CGColor
        findClassButton.layer.borderWidth = 1
        findClassButton.layer.cornerRadius = 8
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
