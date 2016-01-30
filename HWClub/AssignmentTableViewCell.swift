//
//  AssignmentTableViewCell.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 9/27/15.
//  Copyright © 2015 Lyndon Samual McKay. All rights reserved.
//

import UIKit

class AssignmentTableViewCell: UITableViewCell {

    @IBOutlet var classnameLabel: UILabel!
    @IBOutlet var assignmentName: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var numOfQ: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
