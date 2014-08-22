//
//  SetupExpenseTableViewCell.swift
//  budget
//
//  Created by Joseph Anderson on 8/21/14.
//  Copyright (c) 2014 ifd. All rights reserved.
//

import UIKit

class SetupExpenseTableViewCell: UITableViewCell {
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var selectSwitch: UISwitch!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
