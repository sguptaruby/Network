//
//  HistoryTableViewCell.swift
//  UCash
//
//  Created by Sagar.Gupta on 07/06/17.
//  Copyright © 2017 Sagar.Gupta. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    @IBOutlet var vw:UIView!
    @IBOutlet var lblName:UILabel!
    @IBOutlet var lblDate:UILabel!
    @IBOutlet var lblTime:UILabel!
    @IBOutlet var lblMoney:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let yourAttributes = [NSForegroundColorAttributeName: UIColor.black]
        let yourOtherAttributes = [NSForegroundColorAttributeName: UIColor.red]
        let partOne = NSMutableAttributedString(string: "$", attributes: yourAttributes)
        let partTwo = NSMutableAttributedString(string: "  1000", attributes: yourOtherAttributes)
        let combination = NSMutableAttributedString()
        combination.append(partOne)
        combination.append(partTwo)
        lblMoney.attributedText = combination
        vw.showShadow()
        vw.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data:History.Data)  {
        lblName.text = data.userName
        let yourAttributes = [NSForegroundColorAttributeName: UIColor.black]
        let yourOtherAttributes = [NSForegroundColorAttributeName: UIColor.red]
        let partOne = NSMutableAttributedString(string: "$ ", attributes: yourAttributes)
        let partTwo = NSMutableAttributedString(string: data.totalAmount.toString, attributes: yourOtherAttributes)
        let combination = NSMutableAttributedString()
        combination.append(partOne)
        combination.append(partTwo)
        lblMoney.attributedText = combination
        let date = data.lastUpdate.splitString()
        lblDate.text = date.data1
        lblTime.text = date.data2
    }
    
}
