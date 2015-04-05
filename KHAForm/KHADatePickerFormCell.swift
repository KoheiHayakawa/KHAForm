//
//  KHADatePickerCell.swift
//  KHAForm
//
//  Created by Kohei Hayakawa on 3/8/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import UIKit

class KHADatePickerFormCell: KHAFormCell {
    
    let datePicker: UIDatePicker = UIDatePicker()
    
    private let kCellHeight: CGFloat = 216
    
    class var cellID: String {
        return "KHADatePickerCell"
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        super.frame = CGRect(
            x: super.frame.origin.x,
            y: super.frame.origin.y,
            width: super.frame.width,
            height: kCellHeight)
        super.contentView.addSubview(datePicker)
    }
}