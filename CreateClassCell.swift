//
//  CreateClassCell.swift
//  Dac
//
//  Created by Lyndon Samual McKay on 3/7/16.
//  Copyright © 2016 Lyndon Samual McKay. All rights reserved.
//

import UIKit

protocol CreateClassDelegate{
    func addNewOne()
}
class CreateClassCell: UITableViewCell {

    @IBOutlet var findClassButton: UIButton!
    var delegate = CreateClassDelegate?()

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
