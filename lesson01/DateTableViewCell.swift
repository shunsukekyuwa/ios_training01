//
//  DateTableViewCell.swift
//  lesson01
//
//  Created by Soya Tanaka on 2016/05/09.
//  Copyright © 2016年 Soya Tanaka. All rights reserved.
//

import UIKit

class DateTableViewCell: UITableViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(yearMonthDay: String, time: String) {
        dayLabel?.text = yearMonthDay
        timeLabel?.text = time
    }
    
}
