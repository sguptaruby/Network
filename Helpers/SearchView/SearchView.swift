//
//  SearchView.swift
//  UCash
//
//  Created by Sagar.Gupta on 07/06/17.
//  Copyright © 2017 Sagar.Gupta. All rights reserved.
//

import UIKit

protocol SearchViewDelegate {
    func search(name:String)
}

class SearchView: UIView,UITextFieldDelegate {
    
    @IBOutlet var txtSearch: UITextField!
    var delegate: SearchViewDelegate!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        txtSearch.delegate = self
        txtSearch.returnKeyType = .search
    }
   
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate.search(name: textField.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate.search(name: textField.text!)
        return true
    }

}
