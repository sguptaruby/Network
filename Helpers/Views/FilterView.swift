//
//  FilterView.swift
//  UCash
//
//  Created by Sagar.Gupta on 07/06/17.
//  Copyright © 2017 Sagar.Gupta. All rights reserved.
//

import UIKit
import NHRangeSlider

protocol FilterViewDeleagte {
    func filterCancel()
    func filterApply(fromDate:String,toDate:String,minAmount:String,maxAmount:String)
}

class FilterView: UIView {
    
    @IBOutlet var txtFromDate:YoshikoTextField!
    @IBOutlet var txtToDate:YoshikoTextField!
    @IBOutlet weak var minimumLabel: UILabel!
    @IBOutlet weak var maximimLabel: UILabel!
    @IBOutlet weak var slider: UIView!
    @IBOutlet weak var topview: UIView!
    let numberFomatter = NumberFormatter()
    var DatePickerView  : UIDatePicker = UIDatePicker()
    
    var ToDate:String = ""
    var FromDate:String = ""
    
    var delegate:FilterViewDeleagte!
    var txtTagValue:Int = 0
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        txtFromDate.setBottomBorder()
        txtToDate.setBottomBorder()
        DatePickerView.datePickerMode = UIDatePickerMode.date
        txtToDate.inputView = DatePickerView
        txtToDate.delegate = self
        txtFromDate.inputView = DatePickerView
        txtFromDate.delegate = self
        txtToDate.tag = 1
        txtFromDate.tag = 2
        DatePickerView.addTarget(self, action: #selector(handleDatePicker), for: UIControlEvents.valueChanged)
        
        let sliderView = NHRangeSliderView(frame:CGRect(x: 0, y: 0, width: slider.frame.width, height: 40))
        sliderView.minimumValue = 0.0
        sliderView.maximumValue = 5000.0
        sliderView.lowerValue = 0.0
        sliderView.upperValue = 5000.0
        sliderView.delegate = self
        sliderView.lowerLabel?.isHidden = true
        sliderView.upperLabel?.isHidden = true
        sliderView.sizeToFit()
        slider.addSubview(sliderView)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.hideFilterView))
        topview.addGestureRecognizer(tapGesture)
    }
    
    func fliterViewHide()  {
        self.hideFilterView()
    }
    
    func handleDatePicker() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.day, .month, .year], from: DatePickerView.date as Date)
        let year = components.year!
        let month = components.month!
        let day = components.day!
        print("\(year)-\(month)-\(day)")
        if txtTagValue == 1 {
            ToDate = "\(year)-\(month)-\(day)"
            txtToDate.text = dateFormatter.string(from: DatePickerView.date)
        }else if txtTagValue == 2 {
            FromDate = "\(year)-\(month)-\(day)"
         txtFromDate.text = dateFormatter.string(from: DatePickerView.date)
        }
    }
    
    
    @IBAction func handleSliderChange(_ sender: AnyObject) {
       
    }
    
    func abbreviateNumber(_ num: NSNumber) -> NSString {
        var ret: NSString = ""
        let abbrve: [String] = ["K", "M", "B"]
        
        let floatNum = num.floatValue
        
        if floatNum > 1000 {
            
            for i in 0..<abbrve.count {
                let size = pow(10.0, (Float(i) + 1.0) * 3.0)
                if (size <= floatNum) {
                    let num = floatNum / size
                    let str = floatToString(num)
                    ret = NSString(format: "%@%@", str, abbrve[i])
                }
            }
        } else {
            ret = NSString(format: "%d", Int(floatNum))
        }
        
        return ret
    }
    
    func floatToString(_ val: Float) -> NSString {
        var ret = NSString(format: "%.1f", val)
        var c = ret.character(at: ret.length - 1)
        
        while c == 48 {
            ret = ret.substring(to: ret.length - 1) as NSString
            c = ret.character(at: ret.length - 1)
            
            
            if (c == 46) {
                ret = ret.substring(to: ret.length - 1) as NSString
            }
        }
        return ret
    }
    
    @IBAction func btnCancleAction(sender:UIButton) {
        delegate.filterCancel()
    }
    
    @IBAction func btnApplyAction(sender:UIButton) {
        delegate.filterApply(fromDate: FromDate , toDate: ToDate , minAmount: minimumLabel.text ?? "", maxAmount: maximimLabel.text ?? "")
    }
}

extension FilterView:UITextFieldDelegate,NHRangeSliderViewDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        txtTagValue = textField.tag
    }
    
    func sliderValueChanged(slider: NHRangeSlider?) {
        minimumLabel.text = String(format: "$ %.0f", (slider?.lowerValue)!)
        maximimLabel.text = String(format: "$ %.0f", (slider?.upperValue)!)
    }
}



