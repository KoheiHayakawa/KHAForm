//
//  KHADateCell.swift
//  KHAForm
//
//  Created by Kohei Hayakawa on 3/8/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import UIKit

class KHADateFormCell: KHAFormCell {
    
    var date: NSDate? {
        willSet {
            if let newValue = newValue {
                super.detailTextLabel?.text = dateFotmatter.stringFromDate(newValue)
            }
        }
    }
    
    private var dateFotmatter = NSDateFormatter()
    
    class var cellID: String {
        return "KHADateCell"
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Value1, reuseIdentifier: reuseIdentifier)
        super.textLabel?.text = "Label"
        super.detailTextLabel?.text = "Date"
        dateFotmatter.dateStyle = .ShortStyle
        dateFotmatter.timeStyle = .ShortStyle
    }
}