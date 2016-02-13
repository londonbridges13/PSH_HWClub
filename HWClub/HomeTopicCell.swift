//
//  HomeTopicCell.swift
//  Dac
//
//  Created by Lyndon Samual McKay on 2/10/16.
//  Copyright © 2016 Lyndon Samual McKay. All rights reserved.
//

import UIKit

class HomeTopicCell: UITableViewCell {

    
    @IBOutlet var topicLabel: UILabel!
    @IBOutlet var WHatLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
