//
//  CellViewModel.swift
//  lesson01
//
//  Created by Soya Tanaka on 2016/05/13.
//  Copyright © 2016年 Soya Tanaka. All rights reserved.
//

import Foundation

class CellViewModel {
    
    var dates:[(year_month_day: String, time: String)] = []
    
    func addCell() {
        let date = NSDate()
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = .NoStyle
        dateFormatter.dateStyle = .ShortStyle
        
        let dateFormatterForTime = NSDateFormatter()
        dateFormatterForTime.timeStyle = .ShortStyle
        dateFormatterForTime.dateStyle = .NoStyle
        
        let dateTuple = (year_month_day: dateFormatter.stringFromDate(date), time: dateFormatterForTime.stringFromDate(date))
        dates.append(dateTuple)
    }
    
    func deleteCell(indexPath: NSIndexPath) {
        dates.removeAtIndex(indexPath.row)
    }
    
    
    func targetDate(indexPath: NSIndexPath) -> (year_month_day: String, time: String) {
        return dates[indexPath.row]
    }
    
    func cellCount() -> Int {
        return dates.count
    }
}
