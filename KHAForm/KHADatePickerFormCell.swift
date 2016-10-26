//
//  KHADatePickerCell.swift
//  KHAForm
//
//  Created by Kohei Hayakawa on 3/8/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import UIKit

class KHADatePickerFormCell: KHAFormCell {
    
    class var cellID: String {
        return "KHADatePickerCell"
    }
    
    fileprivate let kCellHeight: CGFloat = 216
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        frame = CGRect(
            x: frame.origin.x,
            y: frame.origin.y,
            width: frame.width,
            height: kCellHeight)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(datePicker)
        
        contentView.addConstraints([
            NSLayoutConstraint(
                item: datePicker,
                attribute: .left,
                relatedBy: .equal,
                toItem: contentView,
                attribute: .left,
                multiplier: 1,
                constant: 0),
            NSLayoutConstraint(
                item: datePicker,
                attribute: .right,
                relatedBy: .equal,
                toItem: contentView,
                attribute: .right,
                multiplier: 1,
                constant: 0),
            NSLayoutConstraint(
                item: datePicker,
                attribute: .height,
                relatedBy: .equal,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: 1,
                constant: kCellHeight)]
        )
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
