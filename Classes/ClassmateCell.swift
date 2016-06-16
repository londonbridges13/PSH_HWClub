//
//  ClassmateCell.swift
//  
//
//  Created by Lyndon Samual McKay on 5/30/16.
//
//

import UIKit

class ClassmateCell: UITableViewCell {

    
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var profilePic: UIImageView!
    
    var tyty = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
