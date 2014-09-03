//
//  BASetupBudgetViewController.swift
//  budget
//
//  Created by Joseph Anderson on 8/21/14.
//  Copyright (c) 2014 ifd. All rights reserved.
//

import UIKit

class BASetupBudgetViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var budgetTableView: UITableView!
    var arrayOfExpenseCategories = [PFObject]()
    var arrayOfExpenses = [PFObject]()
    var arrayOfSetBudgetTotal = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var query = PFQuery(className: "Expense")
        query.whereKey("user", equalTo: PFUser.currentUser())
        query.includeKey("expenseCategory")
        query.findObjectsInBackgroundWithBlock { (objects:[AnyObject]!, error: NSError!) -> Void in
            for expense in objects {
                let expenseCat = expense["expenseCategory"] as PFObject
                self.arrayOfExpenseCategories.append(expenseCat)
                self.arrayOfExpenses.append(expense as PFObject)
                // need to make empty array
                self.arrayOfSetBudgetTotal.append(500);
            }
            self.budgetTableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return arrayOfExpenseCategories.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let kCellIdentifier: String = "budgetCell"
        var cell = budgetTableView?.dequeueReusableCellWithIdentifier(kCellIdentifier, forIndexPath: indexPath) as? BABudgetTableViewCell
        if cell == nil {
            cell = BABudgetTableViewCell(style: .Default, reuseIdentifier: kCellIdentifier)
        }
        cell!.expenseCategoryLabel.text = arrayOfExpenseCategories[indexPath.row]["name"] as? String
        cell!.budgetAmountLabel.text = NSString(format: "$%d", arrayOfSetBudgetTotal[indexPath.row])
        cell!.budgetSlider.tag = indexPath.row
        return cell
    }
    
    @IBAction func sliderDidSlide(sender: UISlider) {
        let sliderIndexPath = NSIndexPath(forRow: sender.tag, inSection: 0)
        let cell = budgetTableView.cellForRowAtIndexPath(sliderIndexPath) as BABudgetTableViewCell
        var sliderValue: Float = floor(sender.value)
        arrayOfSetBudgetTotal[sender.tag] = Int(sliderValue * 100)
        cell.budgetAmountLabel.text = NSString(format: "$%.00f", sliderValue * 100)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if segue.identifier == "setupBudgetSegue" {
            for (index, expense) in enumerate(arrayOfExpenses) {
                expense["amount"] = arrayOfSetBudgetTotal[index]
                expense.saveInBackground()
                //May need a loader here, or delegate to update next view on complete
            }
        }
    }

}
