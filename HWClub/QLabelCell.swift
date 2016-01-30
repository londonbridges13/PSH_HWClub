//
//  QLabelCell.swift
//  Dac
//
//  Created by Lyndon Samual McKay on 1/25/16.
//  Copyright © 2016 Lyndon Samual McKay. All rights reserved.
//

import UIKit

class QLabelCell: UITableViewCell {

    @IBOutlet var qLabel : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
