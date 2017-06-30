//
//  FaqTableViewCell.swift
//  UCash
//
//  Created by Sagar.Gupta on 13/06/17.
//  Copyright © 2017 Sagar.Gupta. All rights reserved.
//

import UIKit

class FaqTableViewCell: UITableViewCell {
    
    @IBOutlet var lblAnswer:UILabel!
    @IBOutlet var vw: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //vw.showShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
