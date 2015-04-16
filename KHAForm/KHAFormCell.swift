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
