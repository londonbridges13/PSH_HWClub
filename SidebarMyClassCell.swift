//
//  SidebarMyClassCell.swift
//  Dac
//
//  Created by Lyndon Samual McKay on 2/7/16.
//  Copyright © 2016 Lyndon Samual McKay. All rights reserved.
//

import UIKit

class SidebarMyClassCell: UITableViewCell {

    
    var theClass : String?
    var theTeacher : String?
    
    @IBOutlet var myClassLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        myClassLabel.layer.cornerRadius = 8
        myClassLabel.layer.masksToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
