//
//  QHeaderCell.swift
//  HWClub
//
//  Created by Lyndon Samual McKay on 9/28/15.
//  Copyright © 2015 Lyndon Samual McKay. All rights reserved.
//

import UIKit

protocol SEGon{
    func segit()
}
class QHeaderCell: UITableViewCell {

    let lBlue = UIColor(red: 134/255, green: 218/255, blue: 233/255, alpha: 1)
    let teal = UIColor(red: 52/255, green: 185/255, blue: 208/255, alpha: 1)

    @IBOutlet var askQuestionButton: UIButton!
    @IBOutlet var AssignmenTitleLabel: UILabel!
    var delegate = SEGon?()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        askQuestionButton.layer.borderColor = UIColor.whiteColor().CGColor//teal.CGColor
        askQuestionButton.layer.borderWidth = 1
        askQuestionButton.layer.cornerRadius = 7
        askQuestionButton.layer.masksToBounds = true
    }

    @IBAction func tapping(){
        if let delegate = self.delegate{
            delegate.segit()
        }
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
