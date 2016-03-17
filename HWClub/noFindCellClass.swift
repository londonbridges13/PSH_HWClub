//
//  noFindCellClass.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 1/2/16.
//  Copyright © 2016 Lyndon Samual McKay. All rights reserved.
//

import UIKit

protocol AddClassDelegate{
    func addNewOne()
}

class noFindCellClass: UITableViewCell {

    var delegate = AddClassDelegate?()
    
    @IBOutlet var findClassButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func createClass(sender: AnyObject) {
        print("One Tap")
        if let delegate = self.delegate{
            print("Mid-Tap")
            delegate.addNewOne()
        }
    }
}
