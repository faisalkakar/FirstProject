//
//  CustomCell.swift
//  Friendbook
//
//  Created by Faisal Khan on 12/10/15.
//  Copyright © 2015 Umbrella. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    var scholars = Scholarship()
    @IBOutlet var iconImage: UIImageView!
    @IBOutlet var headingLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        iconImage.layer.cornerRadius = iconImage.frame.width / 2
        iconImage.clipsToBounds = true
        
    }

  
//       override func setSelected(selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
    


}