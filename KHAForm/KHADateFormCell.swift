//
//  KHADateCell.swift
//  KHAForm
//
//  Created by Kohei Hayakawa on 3/8/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import UIKit

public class KHADateFormCell: KHAFormCell {
    
    public override var date: NSDate? {
        willSet {
            if let newValue = newValue {
                detailTextLabel?.text = dateFotmatter.stringFromDate(newValue)
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Value1, reuseIdentifier: reuseIdentifier)
        textLabel?.text = "Label"
        detailTextLabel?.text = "Date"
        dateFotmatter.dateStyle = .ShortStyle
        dateFotmatter.timeStyle = .ShortStyle
    }

    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}