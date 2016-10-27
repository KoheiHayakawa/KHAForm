//
//  KHADateCell.swift
//  KHAForm
//
//  Created by Kohei Hayakawa on 3/8/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import UIKit

class KHADateFormCell: KHAFormCell {
    
    class var cellID: String {
        return "KHADateCell"
    }
    
    override var date: Date {
        willSet {
            detailTextLabel?.text = dateFormatter.string(from: newValue)
        }
        didSet {
            dateDelegate?.dateDidChange(date)
        }
    }
    
    override var dateFormatter: DateFormatter {
        willSet {
            detailTextLabel?.text = newValue.string(from: date)
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        textLabel?.text = "Label"
        detailTextLabel?.text = "Date"
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        datePickerMode = .dateAndTime
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
