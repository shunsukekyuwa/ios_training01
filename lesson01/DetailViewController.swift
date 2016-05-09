//
//  DetailViewController.swift
//  lesson01
//
//  Created by Soya Tanaka on 2016/05/09.
//  Copyright © 2016年 Soya Tanaka. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var yearMonthDayLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    var detailItem: (year_month_day: String, time: String)! {
        didSet {
            self.configureView()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }
    
    func configureView() {
        if let detail: (year_month_day: String, time: String) = self.detailItem {
            if let yearMonthDay = self.yearMonthDayLabel {
                yearMonthDay.text = detail.year_month_day
            }
            if let time = self.timeLabel {
                time.text = detail.time
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}