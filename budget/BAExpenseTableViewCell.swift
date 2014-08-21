//
//  BAExpenseTableViewCell.swift
//  budget
//
//  Created by Joseph Anderson on 8/19/14.
//  Copyright (c) 2014 ifd. All rights reserved.
//

import UIKit

class BAExpenseTableViewCell: UITableViewCell {
    @IBOutlet weak var expenseTitle: UILabel!
    @IBOutlet weak var expenseButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func expenseAddDidPress(sender: AnyObject) {
        println("Here the button was pressed")
    }

}
