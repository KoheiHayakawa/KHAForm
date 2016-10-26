//
//  KHAButtonCell.swift
//  KHAForm
//
//  Created by Kohei Hayakawa on 3/8/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import UIKit

class KHAButtonFormCell: KHAFormCell {
    
    class var cellID: String {
        return "KHAButtonCell"
    }
    
    fileprivate let kFontSize: CGFloat = 15
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        button.setTitle("Button", for: UIControlState())
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
