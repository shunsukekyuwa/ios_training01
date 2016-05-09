//
//  ViewController.swift
//  lesson01
//
//  Created by Soya Tanaka on 2016/05/09.
//  Copyright © 2016年 Soya Tanaka. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addDatesBtn: UIBarButtonItem!
    var dates:[(year_month_day: String, time: String)] = []
    let image:UIImage? = UIImage(named: "image")
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        registerTableViewCellNib("DateTableViewCell", identifier: "DateTableViewCell")
        registerTableViewCellNib("PhotoDateTableViewCell", identifier: "PhotoDateTableViewCell")
        registerTableViewCellNib("PhotoTimeTableViewCell", identifier: "PhotoTimeTableViewCell")
        registerTableViewCellNib("PhotoDateTimeTableViewCell", identifier: "PhotoDateTimeTableViewCell")
    }
    
    @IBAction func buttonTapped(sender: AnyObject) {
        let date = NSDate()
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = .NoStyle
        dateFormatter.dateStyle = .ShortStyle
        
        let dateFormatterForTime = NSDateFormatter()
        dateFormatterForTime.timeStyle = .ShortStyle
        dateFormatterForTime.dateStyle = .NoStyle
        
        let dateTuple = (year_month_day: dateFormatter.stringFromDate(date), time: dateFormatterForTime.stringFromDate(date))
        dates.append(dateTuple)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let date = dates[indexPath.row]
                (segue.destinationViewController as! DetailViewController)
                    .detailItem = date
            }
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dates.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let year_month_day = dates[indexPath.row].year_month_day
        let time = dates[indexPath.row].time
        
        let row = indexPath.row
        if row % 2 == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("PhotoDateTableViewCell") as! PhotoDateTableViewCell
            cell.photoDateImage?.image = image
            cell.photoDateLabel?.text = year_month_day
            return cell
        } else if row % 3 == 0 {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("PhotoTimeTableViewCell") as! PhotoTimeTableViewCell
            cell.photoTimeImage?.image = image
            cell.photoTimeLabel?.text = time
            return cell
        } else if row % 6 == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("PhotoDateTimeTableViewCell") as! PhotoDateTimeTableViewCell
            cell.photoDateTimeImage?.image = image
            cell.PhotoDateTimeDateLabel?.text = year_month_day
            cell.PhotoDateTimelLabel?.text = time
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("DateTableViewCell") as! DateTableViewCell
            cell.dayLabel?.text = year_month_day
            cell.timeLabel?.text = time
            return cell
        }
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath
        indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {
        performSegueWithIdentifier("showDetail", sender: self)
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let deleteBtn = UITableViewRowAction(style: .Default, title: "Delete") {
            (action, indexPath) -> Void in
            print("\(indexPath) deleted!")
            self.dates.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
        deleteBtn.backgroundColor = UIColor.redColor()
        return [deleteBtn]
    }
    
    private func registerTableViewCellNib(nibName: String, identifier: String) {
        tableView.registerNib(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: identifier)
    }

}

