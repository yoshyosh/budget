//
//  BABudgetTableViewCell.swift
//  budget
//
//  Created by Joseph Anderson on 8/21/14.
//  Copyright (c) 2014 ifd. All rights reserved.
//

import UIKit

class BABudgetTableViewCell: UITableViewCell {
    @IBOutlet weak var expenseCategoryLabel: UILabel!
    @IBOutlet weak var budgetAmountLabel: UILabel!
    @IBOutlet weak var budgetSlider: UISlider!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
