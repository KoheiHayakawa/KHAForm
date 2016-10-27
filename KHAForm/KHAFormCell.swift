//
//  KHAFormCell.swift
//  KHAForm
//
//  Created by Kohei Hayakawa on 3/10/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import UIKit

public enum KHAFormCellType {
    
    case textField
    case segmentedControl
    case `switch`
    case date
    case datePicker
    case textView
    case button
    case selection
    
    func cellID() -> String {
        switch self {
        case .textField:        return KHATextFieldFormCell.cellID
        case .segmentedControl: return KHASegmentedControlFormCell.cellID
        case .switch:           return KHASwitchFormCell.cellID
        case .date:             return KHADateFormCell.cellID
        case .datePicker:       return KHADatePickerFormCell.cellID
        case .textView:         return KHATextViewFormCell.cellID
        case .button:           return KHAButtonFormCell.cellID
        case .selection:        return KHASelectionFormCell.cellID
        }
    }
    
    func cellClass() -> AnyClass {
        switch self {
        case .textField:        return KHATextFieldFormCell.self
        case .segmentedControl: return KHASegmentedControlFormCell.self
        case .switch:           return KHASwitchFormCell.self
        case .date:             return KHADateFormCell.self
        case .datePicker:       return KHADatePickerFormCell.self
        case .textView:         return KHATextViewFormCell.self
        case .button:           return KHAButtonFormCell.self
        case .selection:        return KHASelectionFormCell.self
        }
    }
}

public protocol KHADateFormCellDelegate {
    func dateDidChange(_ date:Date)
}

open class KHAFormCell: UITableViewCell {

    open let button: UIButton = UIButton()
    open var date: Date = Date()
    open var dateDelegate:KHADateFormCellDelegate?
    open var dateFormatter = DateFormatter()
    open var datePickerMode = UIDatePickerMode.dateAndTime
    open let datePicker: UIDatePicker = UIDatePicker()
    open var segmentedControl: UISegmentedControl = UISegmentedControl()
    open let sswitch: UISwitch = UISwitch()
    open let textField: UITextField = UITextField()
    open let textView: UIPlaceholderTextView = UIPlaceholderTextView()
    open var selectionFormViewController = KHASelectionFormViewController()
    open var customInlineCell: KHAFormCell?
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

    
    open class func formCellWithType(_ type: KHAFormCellType) -> KHAFormCell {
        switch type {
        case .textField:
            return KHATextFieldFormCell()
        case .segmentedControl:
            return KHASegmentedControlFormCell()
        case .switch:
            return KHASwitchFormCell()
        case .date:
            return KHADateFormCell()
        case .datePicker:
            return KHADatePickerFormCell()
        case .textView:
            return KHATextViewFormCell()
        case .button:
            return KHAButtonFormCell()
        case .selection:
            return KHASelectionFormCell()
        }
    }
}
