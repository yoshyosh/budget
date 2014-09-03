//
//  BASetupExpensesViewController.swift
//  budget
//
//  Created by Joseph Anderson on 8/21/14.
//  Copyright (c) 2014 ifd. All rights reserved.
//

import UIKit

class BASetupExpensesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var setupTableView: UITableView!
    var categoryArray = [PFObject]()
    var savedCategories = [PFObject]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var query = PFQuery(className: "ExpenseCategory")
        //TODO: check if user already has saved expenses, rather than pulling from the global list
        query.findObjectsInBackgroundWithBlock { (categories: [AnyObject]!, error: NSError!) -> Void in
            if (error == nil) {
                self.categoryArray = categories as Array
                self.savedCategories = self.categoryArray
                self.setupTableView.reloadData()
            }
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
        return categoryArray.count;
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier("setupCell", forIndexPath: indexPath) as SetupExpenseTableViewCell
        cell.categoryLabel.text = categoryArray[indexPath.row]["name"] as String
        cell.selectSwitch.tag = indexPath.row
        cell.selectSwitch.addTarget(self, action: "changeSwitch:", forControlEvents: UIControlEvents.ValueChanged)
        return cell
    }
    
    func changeSwitch(sender: UISwitch){
        var category = self.categoryArray[sender.tag]
        if (sender.on){
            println(sender.tag)
            //function that adds to category array
            for object in self.savedCategories {
                if (object == category){
                    return
                }
                self.savedCategories.append(category)
            }
        } else {
            
            for (index, object) in enumerate(self.savedCategories) {
                if (object == category){
                    //object is already in saved categories remove it
                    self.savedCategories.removeAtIndex(index)
                }
            }
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if (segue.identifier == "setupExpensesSegue"){
        println("pressed next")
            //Need a way to check if we have already added a category, dont want duplicates
            for category in savedCategories {
                var currentUser = PFUser.currentUser()
                var query = PFQuery(className: "Expense")
                query.whereKey("user", equalTo: currentUser)
                query.whereKey("expenseCategory", equalTo: category)
                query.findObjectsInBackgroundWithBlock({ (arrayOfObjects: [AnyObject]!, error: NSError!) -> Void in
                    if (arrayOfObjects.count > 0){
                        // object already exists
                    } else {
                        var object = PFObject(className: "Expense")
                        object["user"] = PFUser.currentUser()
                        object["expenseCategory"] = category
                        object.saveInBackground()
                        //Curious about saving 10 + things from an array, seems like we fire off a request after each one, maybe there is a better way to batch
                    }
                })
            }
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
