//
//  KHATextViewCell.swift
//  KHAForm
//
//  Created by Kohei Hayakawa on 3/8/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import UIKit

class KHATextViewFormCell: KHAFormCell {
    
    let textView: UIPlaceholderTextView = UIPlaceholderTextView()
    
    private let kCellHeight: CGFloat = 144
    private let kFontSize: CGFloat = 16
    
    class var cellID: String {
        return "KHATextViewCell"
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        super.selectionStyle = .None
        super.frame = CGRect(
            x: super.frame.origin.x,
            y: super.frame.origin.y,
            width: super.frame.width,
            height: kCellHeight)
        super.contentView.addSubview(textView)
        textView.font = UIFont.systemFontOfSize(kFontSize)
        textView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        // TODO: Fix constant value of left and right.
        // Current value is optimized for iPhone 6.
        // I don't have any good solution for this problem...
        contentView.addConstraints([
            NSLayoutConstraint(
                item: textView,
                attribute: .Left,
                relatedBy: .Equal,
                toItem: contentView,
                attribute: .Left,
                multiplier: 1,
                constant: 10),
            NSLayoutConstraint(
                item: textView,
                attribute: .Right,
                relatedBy: .Equal,
                toItem: contentView,
                attribute: .Right,
                multiplier: 1,
                constant: -5),
            NSLayoutConstraint(
                item: textView,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: nil,
                attribute: .NotAnAttribute,
                multiplier: 1,
                constant: kCellHeight)]
        )
    }
}


class UIPlaceholderTextView: UITextView {
    
    lazy var placeholderLabel:UILabel = UILabel()
    var placeholderColor:UIColor      = UIColor.lightGrayColor()
    var placeholder:NSString          = ""
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func setText(text:NSString) {
        super.text = text
        self.textChanged(nil)
    }
    
    override internal func drawRect(rect: CGRect) {

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textChanged:", name: UITextViewTextDidChangeNotification, object: nil)
        
        if(self.placeholder.length > 0) {
            self.placeholderLabel.frame           = CGRectMake(4,8,self.bounds.size.width - 16,0)
            self.placeholderLabel.lineBreakMode   = NSLineBreakMode.ByWordWrapping
            self.placeholderLabel.numberOfLines   = 0
            self.placeholderLabel.font            = self.font
            self.placeholderLabel.backgroundColor = UIColor.clearColor()
            self.placeholderLabel.textColor       = self.placeholderColor
            self.placeholderLabel.alpha           = 0
            self.placeholderLabel.tag             = 999            
            self.placeholderLabel.text = self.placeholder
            self.placeholderLabel.sizeToFit()
            self.addSubview(placeholderLabel)
        }
        self.sendSubviewToBack(placeholderLabel)
        
        if(self.text.utf16Count == 0 && self.placeholder.length > 0){
            self.viewWithTag(999)?.alpha = 1
        }
        super.drawRect(rect)
    }
    
    internal func textChanged(notification:NSNotification?) -> (Void) {
        if(self.placeholder.length == 0){
            return
        }
        if(countElements(self.text) == 0) {
            self.viewWithTag(999)?.alpha = 1
        }else{
            self.viewWithTag(999)?.alpha = 0
        }
    }
}