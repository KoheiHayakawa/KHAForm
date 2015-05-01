//
//  KHASelectionFormCell.swift
//  Pods
//
//  Created by Kohei Hayakawa on 5/1/15.
//
//

import UIKit

class KHASelectionFormCell: KHAFormCell {

    class var cellID: String {
        return "KHASelectionCell"
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Value1, reuseIdentifier: reuseIdentifier)

        textLabel?.text = "Label"
        detailTextLabel?.text = "Detail"
        accessoryType = .DisclosureIndicator
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
