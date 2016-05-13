//
//  PhotoTimeTableViewCell.swift
//  lesson01
//
//  Created by Soya Tanaka on 2016/05/09.
//  Copyright © 2016年 Soya Tanaka. All rights reserved.
//

import UIKit

class PhotoTimeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var photoTimeImage: UIImageView!
    @IBOutlet weak var photoTimeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(image: UIImage, time: String) {
        photoTimeImage?.image = image
        photoTimeLabel?.text = time
    }
    
    
}
