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
    let image:UIImage? = UIImage(named: "image")!
    
    let cellViewModel = CellViewModel()
    
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
        cellViewModel.addCell()
        tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: .Automatic)
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                (segue.destinationViewController as! DetailViewController)
                    .detailItem = cellViewModel.targetDate(indexPath)
            }
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellViewModel.cellCount()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let targetDate = cellViewModel.targetDate(indexPath)
        let year_month_day = targetDate.year_month_day
        let time = targetDate.time
        
        let rowCondition = ((indexPath.row % 2 == 0), (indexPath.row % 3 == 0))
        
        switch rowCondition {
        case (let condition, let condition2) where condition && condition2:
            let cell = tableView.dequeueReusableCellWithIdentifier(cellType.photoDateTimeTableViewCell.identifier) as! PhotoDateTimeTableViewCell
            cell.set(image!, yearMonthDay: year_month_day, time: time)
            return cell
        case (let condition, _) where condition:
            let cell = tableView.dequeueReusableCellWithIdentifier(cellType.photoDateTableViewCell.identifier) as! PhotoDateTableViewCell
            cell.set(image!, yearMonthDay: year_month_day)
            return cell
        case (_, let condition2) where condition2:
            let cell = tableView.dequeueReusableCellWithIdentifier(cellType.photoTimeTableViewCell.identifier) as! PhotoTimeTableViewCell
            cell.set(image!, time: time)
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier(cellType.dateTableViewCell.identifier) as! DateTableViewCell
            cell.set(year_month_day, time: time)
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
            self?.cellViewModel.deleteCell(indexPath)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
        return [deleteBtn]
    }
}