//
//  FindClassTableViewCell.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 9/25/15.
//  Copyright © 2015 Lyndon Samual McKay. All rights reserved.
//

import UIKit

class FindClassTableViewCell: UITableViewCell {

    @IBOutlet var classnameLabel: UILabel!
    
    @IBOutlet var teacherNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
