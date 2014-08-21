//
//  AddExpenseViewController.swift
//  budget
//
//  Created by Joseph Anderson on 8/19/14.
//  Copyright (c) 2014 ifd. All rights reserved.
//

import UIKit

class AddExpenseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func cancelDidPress(sender: AnyObject) {
        [self .dismissViewControllerAnimated(true, completion: nil)]
    }

    @IBAction func submitButtonDidPress(sender: AnyObject) {
        [self .dismissViewControllerAnimated(true, completion: nil)]
    }

}
