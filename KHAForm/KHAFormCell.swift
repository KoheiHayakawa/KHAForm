//
//  KHAFormCell.swift
//  KHAForm
//
//  Created by Kohei Hayakawa on 3/10/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import UIKit

public enum KHAFormCellType {
    
    case TextField
    case SegmentedControl
    case Switch
    case Date
    case DatePicker
    case TextView
    case Button
}

public class KHAFormCell: UITableViewCell {

    public let button: UIButton = UIButton()
    public var date: NSDate = NSDate()
    public var dateFotmatter = NSDateFormatter()
    public let datePicker: UIDatePicker = UIDatePicker()
    public var segmentedControl: UISegmentedControl = UISegmentedControl()
    public let sswitch: UISwitch = UISwitch()
    public let textField: UITextField = UITextField()
    public let textView: UIPlaceholderTextView = UIPlaceholderTextView()
    
    // MARK: How can I implement class cluster at init?
    // The comment outed code below doesn't work.
    
//    public convenience init(type: KHAFormCellType) {
//        self.init()
//        
//        var subClass: AnyClass
//        switch type {
//        case .TextField:
//            subClass = KHATextFieldFormCell.self
//        case .SegmentedControl:
//            subClass = KHASegmentedControlFormCell.self
//        case .Switch:
//            subClass = KHASwitchFormCell.self
//        case .Date:
//            subClass = KHADateFormCell.self
//        case .DatePicker:
//            subClass = KHADatePickerFormCell.self
//        case .TextView:
//            subClass = KHATextViewFormCell.self
//        case .Button:
//            subClass = KHAButtonFormCell.self
//        }
//        object_setClass(self, subClass)
//    }

    
    public class func formCellWithType(type: KHAFormCellType) -> KHAFormCell {
        switch type {
        case .TextField:
            return KHATextFieldFormCell()
        case .SegmentedControl:
            return KHASegmentedControlFormCell()
        case .Switch:
            return KHASwitchFormCell()
        case .Date:
            return KHADateFormCell()
        case .DatePicker:
            return KHADatePickerFormCell()
        case .TextView:
            return KHATextViewFormCell()
        case .Button:
            return KHAButtonFormCell()
        }
    }
}
