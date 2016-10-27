//
//  KHATextViewCell.swift
//  KHAForm
//
//  Created by Kohei Hayakawa on 3/8/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import UIKit

class KHATextViewFormCell: KHAFormCell {
    
    class var cellID: String {
        return "KHATextViewCell"
    }
    
    fileprivate let kCellHeight: CGFloat = 144
    fileprivate let kFontSize: CGFloat = 16
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        frame = CGRect(
            x: frame.origin.x,
            y: frame.origin.y,
            width: frame.width,
            height: kCellHeight)
        contentView.addSubview(textView)
        textView.font = UIFont.systemFont(ofSize: kFontSize)
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        // TODO: Fix constant value of left and right.
        // Current value is optimized for iPhone 6.
        // I don't have any good solution for this problem...
        contentView.addConstraints([
            NSLayoutConstraint(
                item: textView,
                attribute: .left,
                relatedBy: .equal,
                toItem: contentView,
                attribute: .left,
                multiplier: 1,
                constant: 10),
            NSLayoutConstraint(
                item: textView,
                attribute: .right,
                relatedBy: .equal,
                toItem: contentView,
                attribute: .right,
                multiplier: 1,
                constant: -5),
            NSLayoutConstraint(
                item: textView,
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


open class UIPlaceholderTextView: UITextView {
    
    lazy var placeholderLabel:UILabel = UILabel()
    var placeholderColor:UIColor      = UIColor.lightGray
    open var placeholder:NSString   = ""
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override open func draw(_ rect: CGRect) {

        NotificationCenter.default.addObserver(self, selector: #selector(UIPlaceholderTextView.textChanged(_:)), name: NSNotification.Name.UITextViewTextDidChange, object: nil)
        
        if(self.placeholder.length > 0) {
            self.placeholderLabel.frame           = CGRect(x: 4,y: 8,width: self.bounds.size.width - 16,height: 0)
            self.placeholderLabel.lineBreakMode   = NSLineBreakMode.byWordWrapping
            self.placeholderLabel.numberOfLines   = 0
            self.placeholderLabel.font            = self.font
            self.placeholderLabel.backgroundColor = UIColor.clear
            self.placeholderLabel.textColor       = self.placeholderColor
            self.placeholderLabel.alpha           = 0
            self.placeholderLabel.tag             = 999            
            self.placeholderLabel.text = self.placeholder as String
            self.placeholderLabel.sizeToFit()
            self.addSubview(placeholderLabel)
        }
        self.sendSubview(toBack: placeholderLabel)
        
        if(self.text.characters.count == 0 && self.placeholder.length > 0){
            self.viewWithTag(999)?.alpha = 1
        }
        super.draw(rect)
    }
    
    internal func textChanged(_ notification:Notification?) -> (Void) {
        if(self.placeholder.length == 0){
            return
        }
        if(self.text.characters.count == 0) {
            self.viewWithTag(999)?.alpha = 1
        }else{
            self.viewWithTag(999)?.alpha = 0
        }
    }
}
