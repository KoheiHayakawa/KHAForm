//
//  KHADateRepeatCell.swift
//  Pods
//
//  Created by Eric Heitmuller on 10/27/16.
//
//

import Foundation

class KHADateRepeatCell: KHAFormCell {
 
     class var cellID: String {
         return "KHADateRepeatCell"
     }
 
     override var selectionFormViewController: KHASelectionFormViewController {
         willSet {
             detailTextLabel?.text = newValue.selections[newValue.selectedIndex]
         }
     }
 
     override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
         super.init(style: .value1, reuseIdentifier: reuseIdentifier)
 
         textLabel?.text = "Repeat"
         detailTextLabel?.text = "None"
         accessoryType = .disclosureIndicator
     }
 
     required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
 }
