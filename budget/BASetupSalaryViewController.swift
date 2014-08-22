//
//  BASetupSalaryViewController.swift
//  budget
//
//  Created by Joseph Anderson on 8/21/14.
//  Copyright (c) 2014 ifd. All rights reserved.
//

import UIKit

class BASetupSalaryViewController: UIViewController {
    @IBOutlet weak var incomeTextField: UITextField!
    @IBOutlet weak var frequencySegmentedControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if (segue.identifier == "setupSalarySegue") {
            var currentUser = PFUser.currentUser()
            //TODO: Regex for $ sign
            currentUser["income"] = incomeTextField.text.toInt()
            currentUser["incomeFrequency"] = frequencySegmentedControl.selectedSegmentIndex
            currentUser.saveInBackground()
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}
