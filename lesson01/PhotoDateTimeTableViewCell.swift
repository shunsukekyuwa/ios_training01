//
//  PhotoDateTimeTableViewCell.swift
//  lesson01
//
//  Created by Soya Tanaka on 2016/05/09.
//  Copyright © 2016年 Soya Tanaka. All rights reserved.
//

import UIKit

class PhotoDateTimeTableViewCell: UITableViewCell {

    @IBOutlet weak var photoDateTimeImage: UIImageView!
    @IBOutlet weak var PhotoDateTimeDateLabel: UILabel!
    @IBOutlet weak var PhotoDateTimelLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
