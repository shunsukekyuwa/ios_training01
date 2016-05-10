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
    enum cellType {
        case dateTableViewCell
        case photoDateTableViewCell
        case photoTimeTableViewCell
        case photoDateTimeTableViewCell
        
        var nibName: String {
            switch self {
                case .dateTableViewCell:
                    return "DateTableViewCell"
                case .photoDateTableViewCell:
                    return "PhotoDateTableViewCell"
                case .photoTimeTableViewCell:
                    return "PhotoTimeTableViewCell"
                case .photoDateTimeTableViewCell:
                    return "PhotoDateTimeTableViewCell"
            }
        }
        
        var identifier: String {
            switch self {
            case .dateTableViewCell:
                return "DateTableViewCell"
            case .photoDateTableViewCell:
                return "PhotoDateTableViewCell"
            case .photoTimeTableViewCell:
                return "PhotoTimeTableViewCell"
            case .photoDateTimeTableViewCell:
                return "PhotoDateTimeTableViewCell"
            }
        }
        
        func registerTableViewCellNib(tableView: UITableView) {
            tableView.registerNib(UINib(nibName: self.nibName, bundle: nil), forCellReuseIdentifier: self.identifier)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        cellType.dateTableViewCell.registerTableViewCellNib(tableView)
        cellType.photoDateTableViewCell.registerTableViewCellNib(tableView)
        cellType.photoTimeTableViewCell.registerTableViewCellNib(tableView)
        cellType.photoDateTimeTableViewCell.registerTableViewCellNib(tableView)
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
        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
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
        let row = indexPath.row
        let year_month_day = dates[row].year_month_day
        let time = dates[row].time
        
        let condition:Bool = (row % 2 == 0)
        let condition2:Bool = (row % 3 == 0)
        
        if condition && condition2 {
            let cell = tableView.dequeueReusableCellWithIdentifier(cellType.photoDateTimeTableViewCell.identifier) as! PhotoDateTimeTableViewCell
            cell.photoDateTimeImage?.image = image
            cell.PhotoDateTimeDateLabel?.text = year_month_day
            cell.PhotoDateTimelLabel?.text = time
            return cell
        } else if condition {
            let cell = tableView.dequeueReusableCellWithIdentifier(cellType.photoDateTableViewCell.identifier) as! PhotoDateTableViewCell
            cell.photoDateImage?.image = image
            cell.photoDateLabel?.text = year_month_day
            return cell
        } else if condition2 {
            let cell = tableView.dequeueReusableCellWithIdentifier(cellType.photoTimeTableViewCell.identifier) as! PhotoTimeTableViewCell
            cell.photoTimeImage?.image = image
            cell.photoTimeLabel?.text = time
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(cellType.dateTableViewCell.identifier) as! DateTableViewCell
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
        let deleteBtn = UITableViewRowAction(style: .Destructive, title: "Delete") {
            [weak self] (action, indexPath) -> Void in
            print("\(indexPath) deleted!")
            self?.dates.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
        return [deleteBtn]
    }
}

