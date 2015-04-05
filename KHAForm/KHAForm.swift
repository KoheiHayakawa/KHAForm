//
//  KHAForm.swift
//  KHAForm
//
//  Created by Kohei Hayakawa on 2/20/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import UIKit

enum KHAFormCellType: Int {
    
    case TextField
    case SegmentedControl
    case Switch
    case Date
    case DatePicker
    case TextView
    case Button
    
    private func cellId() -> String {
        switch self {
        case .TextField:        return KHATextFieldFormCell.cellID
        case .SegmentedControl: return KHASegmentedControlFormCell.cellID
        case .Switch:           return KHASwitchFormCell.cellID
        case .Date:             return KHADateFormCell.cellID
        case .DatePicker:       return KHADatePickerFormCell.cellID
        case .TextView:         return KHATextViewFormCell.cellID
        case .Button:           return KHAButtonFormCell.cellID
        }
    }
}

protocol KHAFormDataSource {
    func formCellsInForm(form: KHAForm) -> [[KHAFormCell]]
}

class KHAForm: UITableViewController, UITextFieldDelegate, UITextViewDelegate, KHAFormDataSource {
    
    private var cells:[[KHAFormCell]] = [[]]
    private var datePickerIndexPath: NSIndexPath?
    
    // Form is always grouped tableview
    convenience override init() {
        self.init(style: .Grouped)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // register cells
        tableView.registerClass(KHATextFieldFormCell.self, forCellReuseIdentifier: KHATextFieldFormCell.cellID)
        tableView.registerClass(KHASegmentedControlFormCell.self, forCellReuseIdentifier: KHASegmentedControlFormCell.cellID)
        tableView.registerClass(KHASwitchFormCell.self, forCellReuseIdentifier: KHASwitchFormCell.cellID)
        tableView.registerClass(KHADateFormCell.self, forCellReuseIdentifier: KHADateFormCell.cellID)
        tableView.registerClass(KHADatePickerFormCell.self, forCellReuseIdentifier: KHADatePickerFormCell.cellID)
        tableView.registerClass(KHATextViewFormCell.self, forCellReuseIdentifier: KHATextViewFormCell.cellID)
        tableView.registerClass(KHAButtonFormCell.self, forCellReuseIdentifier: KHAButtonFormCell.cellID)

        // init form structure
        cells = formCellsInForm(self)
    }
    
    /*! Determine form structure by using two-dimensional array.
        First index determines section and second index determines row.
        This method must be overridden in subclass.
    */
    func formCellsInForm(form: KHAForm) -> [[KHAFormCell]] {
        return  cells
    }

    func initFormCellWithType(type: KHAFormCellType) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(type.cellId()) as UITableViewCell
        return cell
    }

    func formCellForIndexPath(indexPath: NSIndexPath) -> UITableViewCell {
        var before = false
        if hasInlineDatePicker() {
            before = (datePickerIndexPath?.row < indexPath.row) && (datePickerIndexPath?.section == indexPath.section)
        }
        let row = (before ? indexPath.row - 1 : indexPath.row)
        
        var cell = tableView.dequeueReusableCellWithIdentifier(KHAFormCellType.DatePicker.cellId()) as UITableViewCell
        if !hasPickerAtIndexPath(indexPath) {
            cell = cells[indexPath.section][row]
        }
        return cell
    }
    

    // MARK: - UITableViewDataSource
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let cell = formCellForIndexPath(indexPath)
        return cell.bounds.height
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return cells.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if hasInlineDatePickerAtSection(section) {
            // we have a date picker, so allow for it in the number of rows in this section
            return cells[section].count + 1
        }
        return cells[section].count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = formCellForIndexPath(indexPath)
        
        switch cell.reuseIdentifier! {
        case KHAFormCellType.TextField.cellId():
            (cell as KHATextFieldFormCell).textField.delegate = self
        case KHAFormCellType.TextView.cellId():
            (cell as KHATextViewFormCell).textView.delegate = self
            cell.selectionStyle = .None;
        case KHAFormCellType.DatePicker.cellId():
            (cell as KHADatePickerFormCell).datePicker.addTarget(self, action: Selector("didDatePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        default:
            break // do nothing
        }
        return cell
    }
    
    
    // MARK: - UITableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)

        if cell?.reuseIdentifier == KHAFormCellType.Date.cellId() {
            displayInlineDatePickerForRowAtIndexPath(indexPath)
        } else {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
        view.endEditing(true)
    }
    
    
    // MARK: - DatePicker
    
    /*! Updates the UIDatePicker's value to match with the date of the cell above it.
    */
    private func updateDatePicker() {
        if let indexPath = datePickerIndexPath {
            if let associatedDatePickerCell = tableView.cellForRowAtIndexPath(indexPath) {
                let cell = cells[indexPath.section][indexPath.row - 1] as KHADateFormCell
                if let date = cell.date {
                    (associatedDatePickerCell as KHADatePickerFormCell).datePicker.setDate(date, animated: false)
                }
            }
        }
    }
    
    private func hasInlineDatePickerAtSection(section: Int) -> Bool {
        if hasInlineDatePicker() {
            return datePickerIndexPath?.section == section
        }
        return false
    }
    
    /*! Determines if the given indexPath points to a cell that contains the UIDatePicker.
        @param indexPath The indexPath to check if it represents a cell with the UIDatePicker.
    */
    private func hasPickerAtIndexPath(indexPath: NSIndexPath) -> Bool {
        return hasInlineDatePicker() && (datePickerIndexPath?.row == indexPath.row) && (datePickerIndexPath?.section == indexPath.section)
    }
    
    /*! Determines if the UITableViewController has a UIDatePicker in any of its cells.
    */
    private func hasInlineDatePicker() -> Bool {
        return datePickerIndexPath? != nil
    }
    
    /*! Adds or removes a UIDatePicker cell below the given indexPath.
        @param indexPath The indexPath to reveal the UIDatePicker.
    */
    private func toggleDatePickerForSelectedIndexPath(indexPath: NSIndexPath) {
        tableView.beginUpdates()
        let indexPaths = [NSIndexPath(forRow: indexPath.row + 1, inSection: indexPath.section)]
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Fade)
        tableView.endUpdates()
    }
    
    /*! Reveals the date picker inline for the given indexPath, called by "didSelectRowAtIndexPath".
        @param indexPath The indexPath to reveal the UIDatePicker.
    */
    private func displayInlineDatePickerForRowAtIndexPath(indexPath: NSIndexPath) {
        
        // display the date picker inline with the table content
        tableView.beginUpdates()
        
        var before = false // indicates if the date picker is below "indexPath", help us determine which row to reveal
        if hasInlineDatePicker() {
            before = (datePickerIndexPath?.row < indexPath.row) && (datePickerIndexPath?.section == indexPath.section)
        }
        
        var sameCellClicked = ((datePickerIndexPath?.row == indexPath.row + 1) && (datePickerIndexPath?.section == indexPath.section))
        
        // remove any date picker cell if it exists
        if hasInlineDatePicker() {
            tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: datePickerIndexPath!.row, inSection: datePickerIndexPath!.section)], withRowAnimation: .Fade)
            datePickerIndexPath = nil
        }
        
        if !sameCellClicked {
            // hide the old date picker and display the new one
            let rowToReveal = (before ? indexPath.row - 1 : indexPath.row)
            let indexPathToReveal = NSIndexPath(forRow: rowToReveal, inSection: indexPath.section)
            toggleDatePickerForSelectedIndexPath(indexPathToReveal)
            datePickerIndexPath = NSIndexPath(forRow: indexPathToReveal.row + 1, inSection: indexPath.section)
        }
        
        // always deselect the row containing the start or end date
        tableView.deselectRowAtIndexPath(indexPath, animated:true)
        
        tableView.endUpdates()
        
        // inform our date picker of the current date to match the current cell
        updateDatePicker()
    }
    
    private func removeAnyDatePickerCell() {
        if hasInlineDatePicker() {
            tableView.beginUpdates()
            
            let indexPath = NSIndexPath(forRow: datePickerIndexPath!.row, inSection: datePickerIndexPath!.section)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            datePickerIndexPath = nil
            
            // always deselect the row containing the start or end date
            tableView.deselectRowAtIndexPath(indexPath, animated:true)
            
            tableView.endUpdates()
            
            // inform our date picker of the current date to match the current cell
            updateDatePicker()
        }
    }
    
    /*! User chose to change the date by changing the values inside the UIDatePicker.
        @param sender The sender for this action: UIDatePicker.
    */
    func didDatePickerValueChanged(sender: UIDatePicker) {
        
        var targetedCellIndexPath: NSIndexPath?
        
        if self.hasInlineDatePicker() {
            // inline date picker: update the cell's date "above" the date picker cell
            targetedCellIndexPath = NSIndexPath(forRow: datePickerIndexPath!.row - 1, inSection: datePickerIndexPath!.section)
        } else {
            // external date picker: update the current "selected" cell's date
            if let selectedIndexPath = tableView.indexPathForSelectedRow() {
                targetedCellIndexPath = selectedIndexPath
            }
        }
        
        // update the cell's date string
        if let selectedIndexPath = targetedCellIndexPath {
            var cell = tableView.cellForRowAtIndexPath(targetedCellIndexPath!) as KHADateFormCell
            let targetedDatePicker = sender
            cell.date = targetedDatePicker.date
        }
    }
    
    
    // MARK: - Delegate
    
    func textFieldDidBeginEditing(textField: UITextField) {
        removeAnyDatePickerCell()
    }

    func textViewDidBeginEditing(textView: UITextView) {
        removeAnyDatePickerCell()
    }
}