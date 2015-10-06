//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by Jake Moskowitz on 9/29/15.
//  Copyright © 2015 Jake Moskowitz. All rights reserved.
//

import UIKit

protocol ToDoTableViewControllerDelegate {
    func addedInfo(info: NSMutableArray)
    func getCompletion() -> Int?
}

class ToDoTableViewController: UITableViewController, ToDoTableViewControllerDelegate {
    
    @IBOutlet var statsButton: UIButton!
    @IBOutlet var addNewItemButton: UIButton!
    var cellData: NSMutableArray = []
    var completion: Int = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        addNewItemButton.setTitle("Add New Item", forState: .Normal)
        statsButton.setTitle("Stats", forState: .Normal)
        self.tableView.allowsMultipleSelectionDuringEditing = false
        
        let date = NSDate()
        let formatter = NSDateFormatter()
        formatter.timeStyle = .ShortStyle
        if formatter.stringFromDate(date) == "12:00 AM" {
            completion = 0
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "pressedAddNewFromToDo" {
            let vc = segue.destinationViewController as! AddNewItemViewController
            vc.delegate = self
        } else if segue.identifier == "pressedStatsFromToDo" {
            let vc = segue.destinationViewController as! StatsViewController
            vc.delegate = self
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: TableView Methods
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell!
        let cellTitle = cell.contentView.viewWithTag(1) as! UILabel
        cellTitle.text = cellData[indexPath.row][0] as? String
        let cellDetail = cell.contentView.viewWithTag(2) as! UILabel
        cellDetail.text = cellData[indexPath.row][1] as? String
        let cellCompleted = cell.contentView.viewWithTag(3) as! UILabel
        cellCompleted.layer.cornerRadius = 7.0
        cellCompleted.clipsToBounds = true
        if String(cellData[indexPath.row][2]) == "grey" {
            cellCompleted.backgroundColor = UIColor.lightGrayColor()
        } else {
            cellCompleted.backgroundColor = UIColor.greenColor()
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as UITableViewCell!
        let cellCompleted = cell.contentView.viewWithTag(3) as! UILabel
        let temp = cellData[indexPath.row] as! NSMutableArray
        if String(cellData[indexPath.row][2]) == "grey" {
            cellCompleted.backgroundColor = UIColor.greenColor()
            cell.selectionStyle = .None
            temp.replaceObjectAtIndex(2, withObject: "green")
            cellData.replaceObjectAtIndex(indexPath.row, withObject: temp)
            completion++
        } else {
            cellCompleted.backgroundColor = UIColor.lightGrayColor()
            cell.selectionStyle = .None
            temp.replaceObjectAtIndex(2, withObject: "grey")
            cellData.replaceObjectAtIndex(indexPath.row, withObject: temp)
            completion--
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellData.count
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            cellData.removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    //MARK: Delegate
    
    func addedInfo(info: NSMutableArray) {
        cellData.addObject(info)
        self.tableView.reloadData()
    }

    func getCompletion() -> Int? {
        return completion
    }

}

