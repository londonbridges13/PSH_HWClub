//
//  SideBarSchoolCell.swift
//  Dac
//
//  Created by Lyndon Samual McKay on 2/7/16.
//  Copyright © 2016 Lyndon Samual McKay. All rights reserved.
//

import UIKit

class SideBarSchoolCell: UITableViewCell {

    @IBOutlet var SchoolLabel: UILabel!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var proPic: UIImageView!
    var imagePicker: UIImagePickerController!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
