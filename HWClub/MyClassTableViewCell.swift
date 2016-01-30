//
//  MyClassTableViewCell.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 9/29/15.
//  Copyright © 2015 Lyndon Samual McKay. All rights reserved.
//

import UIKit

class MyClassTableViewCell: UITableViewCell {

    @IBOutlet var classNameLabel: UILabel!
    
    @IBOutlet var teacherLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
