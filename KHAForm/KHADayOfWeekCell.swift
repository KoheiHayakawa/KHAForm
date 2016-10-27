//
//  KHADayOfWeekCell.swift
//  Pods
//
//  Created by Eric Heitmuller on 10/27/16.
//
//

import Foundation

class KHADayOfWeekCell: KHAFormCell {
 
class var cellID: String {
         return "KHADayOfWeekCell"
}
 
     private let kFontSize: CGFloat = 15
 
     override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         selectionStyle = .none
 
         button.setTitle("NEED 5 BUTTONS", for: .normal)
         button.titleLabel?.font = UIFont.systemFont(ofSize: kFontSize)
         button.titleLabel?.textAlignment = .center
         button.translatesAutoresizingMaskIntoConstraints = false
         contentView.addSubview(button)
 
         contentView.addConstraints([
             NSLayoutConstraint(
                 item: button,
                 attribute: .left,
                 relatedBy: .equal,
                 toItem: contentView,
                 attribute: .left,
                 multiplier: 1,
                 constant: 0),
             NSLayoutConstraint(
                 item: button,
                 attribute: .right,
                 relatedBy: .equal,
                 toItem: contentView,
                 attribute: .right,
                 multiplier: 1,
                 constant: 0),
             NSLayoutConstraint(
                 item: button,
                 attribute: .height,
                 relatedBy: .equal,
                 toItem: nil,
                 attribute: .notAnAttribute,
                 multiplier: 1,
                 constant: 44)]
         )
     }
 
     required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
 }
