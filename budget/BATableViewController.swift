//
//  BATableViewController.swift
//  budget
//
//  Created by Joseph Anderson on 8/19/14.
//  Copyright (c) 2014 ifd. All rights reserved.
//

import UIKit

class BATableViewController: UITableViewController {
    @IBOutlet var expenseTableView: UITableView!
    var expenseCategoryArray = [String]()
    var expenseArray = [AnyObject]()
    var paymentArray = [[AnyObject]]()
    var keepCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchExpenses()
    }
    
    func fetchExpenses() {
        var query = PFQuery(className: "Expense")
        query.whereKey("user", equalTo: PFUser.currentUser())
        query.includeKey("expenseCategory")
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in
            if (error == nil){
                self.paymentArray = [[AnyObject]](count: objects.count, repeatedValue: [])
                for (expense) in objects {
                    var expenseCat = expense["expenseCategory"] as PFObject
                    var expenseName = expenseCat["name"] as String
//                    var emptyArray = Array(count: 1, repeatedValue: 0)
//                    self.paymentArray.append(emptyArray)
                    self.expenseCategoryArray.append(expenseName)
                }
                self.expenseArray = objects
                self.expenseTableView.reloadData()
                self.buildPaymentsArray(self.expenseArray)
            }
        }
    }
    
    func buildPaymentsArray(expenses: Array<AnyObject>!){
        for (index, expense) in enumerate(expenses) {
            // query for all Payments for that expense
            var paymentQuery = PFQuery(className: "Payment")
            paymentQuery.whereKey("expense", equalTo: expense)
            paymentQuery.findObjectsInBackgroundWithBlock({ (objects: [AnyObject]!, error: NSError!) -> Void in
                self.paymentArray[index] = objects
//                var paymentIndexPath = NSIndexPath(forRow: self.keepCount, inSection: 0)
//                self.expenseTableView.reloadRowsAtIndexPaths([paymentIndexPath], withRowAnimation: .Fade)
                println("Payment array\n \(self.paymentArray)")
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return expenseCategoryArray.count;
    }

    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = expenseTableView.dequeueReusableCellWithIdentifier("CELL", forIndexPath: indexPath) as BAExpenseTableViewCell
        
        var budgetAmount = expenseArray[indexPath.row]["amount"] as Float
        var paymentAmount = 0.0 as Float
//        if let paymentObject = paymentArray[indexPath.row][0] as? PFObject {
//            var paymentAmount = paymentArray[indexPath.row][0]["amount"] as Float
//        }
        var amountLeftToSpend = 0.0 //(budgetAmount - paymentAmount)
        cell.expenseTitle.text = expenseCategoryArray[indexPath.row]
        cell.expenseSubtitle.text = NSString(format: "$%.02f left to spend", amountLeftToSpend)
        cell.expenseButton.tag = indexPath.row
        return cell
    }
    
    @IBAction func expenseCellAddButtonDidPress(sender: AnyObject) {
        
        //[self.expenseTableView.cellForRowAtIndexPath(indexPath)]
        println("pressed add button")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if (segue.identifier == "addExpenseSegue"){
            let destinationVC = segue.destinationViewController as AddExpenseViewController
            destinationVC.expenseCategory = self.expenseArray[sender.tag] as PFObject
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView!, moveRowAtIndexPath fromIndexPath: NSIndexPath!, toIndexPath: NSIndexPath!) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
