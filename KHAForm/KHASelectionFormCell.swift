//
//  KHASelectionFormCell.swift
//  KHAForm
//
//  Created by Kohei Hayakawa on 5/1/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import UIKit

class KHASelectionFormCell: KHAFormCell {

    class var cellID: String {
        return "KHASelectionCell"
    }
    
    override var selectedIndex: Int {
        willSet {
            detailTextLabel?.text = selections[newValue]
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Value1, reuseIdentifier: reuseIdentifier)

        textLabel?.text = "Label"
        detailTextLabel?.text = "None"
        accessoryType = .DisclosureIndicator
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
