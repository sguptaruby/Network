//
//  FaqHeaderView.swift
//  UCash
//
//  Created by Sagar.Gupta on 13/06/17.
//  Copyright © 2017 Sagar.Gupta. All rights reserved.
//

import UIKit

protocol FaqHeaderViewDelegate {
    func cellReload(activeSection:Int)
}

class FaqHeaderView: UIView {
    
    @IBOutlet weak var vw:UIView!
    @IBOutlet var lblQuestion:UILabel!
    @IBOutlet var btnTaped:UIButton!
    var deleagte:FaqHeaderViewDelegate!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       vw.showShadow()
    }
    
    @IBAction func btnReloadCell(sender:UIButton) {
        deleagte.cellReload(activeSection: sender.tag)
    }

}
