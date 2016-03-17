//
//  oPostingCell.swift
//  Dac
//
//  Created by Lyndon Samual McKay on 3/15/16.
//  Copyright © 2016 Lyndon Samual McKay. All rights reserved.
//

import UIKit

class oPostingCell: UITableViewCell {

    @IBOutlet var PostButton : UIButton!
    @IBOutlet var AskButton : UIButton!
    
    var thatBlue = UIColor(red: 54/255, green: 185/255, blue: 208/255, alpha: 1)
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        PostButton.layer.cornerRadius = 6
        AskButton.layer.cornerRadius = 6
        AskButton.layer.borderWidth = 1
        AskButton.layer.borderColor = thatBlue.CGColor
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
