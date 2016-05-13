//
//  CellViewModelSpec.swift
//  lesson01
//
//  Created by Soya Tanaka on 2016/05/13.
//  Copyright © 2016年 Soya Tanaka. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import lesson01

class CellViewModelSpec: QuickSpec {
    override func spec() {
        let cellViewModel = CellViewModel()
        describe("#addCell") {
        }
        
        describe("#deleteCell") {
            cellViewModel.dates.append((year_month_day: "2000/10/10", time: "20:00"))
            it("deletes cell of target row") {
                
            }
        }
        
        describe("#targetDate") {
            cellViewModel.dates.append((year_month_day: "2000/10/10", time: "20:00"))
            it("returns right year_month_day") {
                //expect(cellViewModel.targetDate(indexPath))
            }
        }
        
        describe("#cellCount") {
            cellViewModel.dates.append((year_month_day: "2000/10/10", time: "20:00"))
            it("returns cell count") {
                expect(cellViewModel.cellCount()).to(equal(1))
            }
        }
    }
}