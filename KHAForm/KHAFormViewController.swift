//
//  KHAFormController.swift
//  KHAForm
//
//  Created by Kohei Hayakawa on 2/20/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import UIKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}


public protocol KHAFormViewDataSource {
     func formCellsInForm(_ form: KHAFormViewController) -> [[KHAFormCell]]
}

open
class KHAFormViewController: UITableViewController, UITextFieldDelegate, UITextViewDelegate, KHAFormViewDataSource, KHASelectionFormViewDelegate {
    
    fileprivate var cells = [[KHAFormCell]]()
    fileprivate var datePickerIndexPath: IndexPath?
    fileprivate var customInlineCellIndexPath: IndexPath?
    fileprivate var lastIndexPath: IndexPath? // For selection form cell
    
    // Form is always grouped tableview
    convenience public init() {
        self.init(style: .grouped)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        // init form structure
        reloadForm()
    }
    
    open func reloadForm() {
        cells = formCellsInForm(self)
        tableView.reloadData()
    }
    
    /*! Determine form structure by using two-dimensional array.
        First index determines section and second index determines row.
        This method must be overridden in subclass.
    */
    open func formCellsInForm(_ form: KHAFormViewController) -> [[KHAFormCell]] {
        return  cells
    }

    open func formCellForIndexPath(_ indexPath: IndexPath) -> KHAFormCell {
        var before = false
        if hasInlineDatePicker() {
            before = ((datePickerIndexPath as NSIndexPath?)?.row < (indexPath as NSIndexPath).row) && ((datePickerIndexPath as NSIndexPath?)?.section == (indexPath as NSIndexPath).section)
        }
        else if hasInlineCustomCell() {
            before = ((customInlineCellIndexPath as NSIndexPath?)?.row < (indexPath as NSIndexPath).row && (customInlineCellIndexPath as NSIndexPath?)?.section == (indexPath as NSIndexPath).section)
        }
        
        let row = (before ? (indexPath as NSIndexPath).row - 1 : (indexPath as NSIndexPath).row)

        var cell = dequeueReusableFormCellWithType(.datePicker)
        if hasCustomCellAtIndexPath(indexPath) {
            cell = cells[(indexPath as NSIndexPath).section][row-1]
            if let inlineCell = cell.customInlineCell , customInlineCellIndexPath == indexPath {
                cell = inlineCell
            }
        }
        else if (!hasPickerAtIndexPath(indexPath) || !hasCustomCellAtIndexPath(indexPath)) && indexPath != datePickerIndexPath {
            cell = cells[(indexPath as NSIndexPath).section][row]
        }
        return cell
    }
    
    open func dequeueReusableFormCellWithType(_ type: KHAFormCellType) -> KHAFormCell {
        // Register the picker cell if form has a date cell and still not registered
        if type == .date && tableView.dequeueReusableCell(withIdentifier: type.cellID()) == nil {
            tableView.register(KHADatePickerFormCell.self, forCellReuseIdentifier: KHADatePickerFormCell.cellID)
        }
        // Register initialized cell if form doesn't have that cell
        if let cell = tableView.dequeueReusableCell(withIdentifier: type.cellID()) as? KHAFormCell {
            return cell
        } else {
            tableView.register(type.cellClass(), forCellReuseIdentifier: type.cellID())
            return tableView.dequeueReusableCell(withIdentifier: type.cellID()) as! KHAFormCell
        }
    }

    // MARK: - UITableViewDataSource
    
    override open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = formCellForIndexPath(indexPath)
        return cell.bounds.height
    }
    
    override open func numberOfSections(in tableView: UITableView) -> Int {
        return cells.count
    }

    override open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if hasInlineDatePickerAtSection(section) || hasCustomInlineCellAtSection(section) {
            // we have a date picker, so allow for it in the number of rows in this section
            return cells[section].count + 1
        }
        return cells[section].count;
    }
    
    override open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = formCellForIndexPath(indexPath)
        
        if cell is KHATextFieldFormCell {
            cell.textField.delegate = self
        } else if cell is KHATextViewFormCell {
            cell.textView.delegate = self
        } else if cell is KHADatePickerFormCell {
            let dateCell = formCellForIndexPath(IndexPath(row: (indexPath as NSIndexPath).row-1, section: (indexPath as NSIndexPath).section))
            cell.datePicker.datePickerMode = dateCell.datePickerMode
            cell.datePicker.minuteInterval = dateCell.datePicker.minuteInterval
            cell.datePicker.addTarget(self, action: #selector(KHAFormViewController.didDatePickerValueChanged(_:)), for: UIControlEvents.valueChanged)
        }
        return cell
    }
    
    
    // MARK: - UITableViewDelegate
    
    override open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! KHAFormCell

        if cell is KHADateFormCell {
            displayInlineDatePickerForRowAtIndexPath(indexPath)
        } else if cell is KHASelectionFormCell {
            lastIndexPath = indexPath
            let selectionFormViewController = cell.selectionFormViewController
            selectionFormViewController.delegate = self
            navigationController?.pushViewController(selectionFormViewController, animated: true)
        }
        else if cell.customInlineCell != nil {
            displayCustomInlineCellForRowAtIndexPath(indexPath)
        }
        tableView.deselectRow(at: indexPath, animated: true)
        view.endEditing(true)
    }
    
    
    // MARK: - DatePicker
    
    /*! Updates the UIDatePicker's value to match with the date of the cell above it.
    */
    open func updateDatePicker() {
        if let indexPath = datePickerIndexPath {
            if let associatedDatePickerCell = tableView.cellForRow(at: indexPath) {
                let cell = cells[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row - 1] as! KHADateFormCell
                (associatedDatePickerCell as! KHADatePickerFormCell).datePicker.setDate(cell.date as Date, animated: false)
            }
        }
    }
    
    fileprivate func hasInlineDatePickerAtSection(_ section: Int) -> Bool {
        if hasInlineDatePicker() {
            return (datePickerIndexPath as NSIndexPath?)?.section == section
        }
        return false
    }
    
    fileprivate func hasCustomInlineCellAtSection(_ section: Int)-> Bool {
        if hasInlineCustomCell() {
            return (customInlineCellIndexPath as NSIndexPath?)?.section == section
        }
        return false
    }
    
    /*! Determines if the given indexPath points to a cell that contains the UIDatePicker.
        @param indexPath The indexPath to check if it represents a cell with the UIDatePicker.
    */
    fileprivate func hasPickerAtIndexPath(_ indexPath: IndexPath) -> Bool {
        return hasInlineDatePicker() && ((datePickerIndexPath as NSIndexPath?)?.row == (indexPath as NSIndexPath).row) && ((datePickerIndexPath as NSIndexPath?)?.section == (indexPath as NSIndexPath).section)
    }
    
    fileprivate func hasCustomCellAtIndexPath(_ indexPath: IndexPath)->Bool {
        return hasInlineCustomCell() && ((customInlineCellIndexPath as NSIndexPath?)?.row == (indexPath as NSIndexPath).row) && ((customInlineCellIndexPath as NSIndexPath?)?.section == (indexPath as NSIndexPath).section)
    }
    
    /*! Determines if the UITableViewController has a UIDatePicker in any of its cells.
    */
    fileprivate func hasInlineDatePicker() -> Bool {
        return datePickerIndexPath != nil
    }
    
    fileprivate func hasInlineCustomCell()->Bool {
        return customInlineCellIndexPath != nil
    }
    
    /*! Adds or removes a UIDatePicker cell below the given indexPath.
        @param indexPath The indexPath to reveal the UIDatePicker.
    */
    fileprivate func toggleDatePickerForSelectedIndexPath(_ indexPath: IndexPath) {
        tableView.beginUpdates()
        let indexPaths = [IndexPath(row: (indexPath as NSIndexPath).row + 1, section: (indexPath as NSIndexPath).section)]
        tableView.insertRows(at: indexPaths, with: .fade)
        tableView.endUpdates()
    }
    
    /*! Reveals the date picker inline for the given indexPath, called by "didSelectRowAtIndexPath".
        @param indexPath The indexPath to reveal the UIDatePicker.
    */
    fileprivate func displayInlineDatePickerForRowAtIndexPath(_ indexPath: IndexPath) {
        
        // display the date picker inline with the table content
        tableView.beginUpdates()
        
        var before = false // indicates if the date picker is below "indexPath", help us determine which row to reveal
        if hasInlineDatePicker() {
            before = ((datePickerIndexPath as NSIndexPath?)?.row < (indexPath as NSIndexPath).row) && ((datePickerIndexPath as NSIndexPath?)?.section == (indexPath as NSIndexPath).section)
        }
        
        let sameCellClicked = (((datePickerIndexPath as NSIndexPath?)?.row == (indexPath as NSIndexPath).row + 1) && ((datePickerIndexPath as NSIndexPath?)?.section == (indexPath as NSIndexPath).section))
        
        // remove any date picker cell if it exists
        if hasInlineDatePicker() {
            tableView.deleteRows(at: [IndexPath(row: (datePickerIndexPath! as NSIndexPath).row, section: (datePickerIndexPath! as NSIndexPath).section)], with: .fade)
            datePickerIndexPath = nil
        }
        
        if !sameCellClicked {
            // hide the old date picker and display the new one
            let rowToReveal = (before ? (indexPath as NSIndexPath).row - 1 : (indexPath as NSIndexPath).row)
            let indexPathToReveal = IndexPath(row: rowToReveal, section: (indexPath as NSIndexPath).section)
            toggleDatePickerForSelectedIndexPath(indexPathToReveal)
            datePickerIndexPath = IndexPath(row: (indexPathToReveal as NSIndexPath).row + 1, section: (indexPath as NSIndexPath).section)
        }
        
        // always deselect the row containing the start or end date
        tableView.deselectRow(at: indexPath, animated:true)
        
        tableView.endUpdates()
        
        // inform our date picker of the current date to match the current cell
        updateDatePicker()
    }
    
    fileprivate func displayCustomInlineCellForRowAtIndexPath(_ indexPath: IndexPath) {
        tableView.beginUpdates()
        var before = false
        if hasInlineCustomCell() {
            before = ((customInlineCellIndexPath as NSIndexPath?)?.row < (indexPath as NSIndexPath).row && (customInlineCellIndexPath as NSIndexPath?)?.section == (indexPath as NSIndexPath).section)
        }
        
        let sameCellClicked = (((customInlineCellIndexPath as NSIndexPath?)?.row == (indexPath as NSIndexPath).row + 1 ) && (customInlineCellIndexPath as NSIndexPath?)?.section == (indexPath as NSIndexPath).section)
        
        // remove any other custom cell if it exists
        if let indexPath = customInlineCellIndexPath , hasInlineCustomCell() {
            tableView.deleteRows(at: [indexPath], with: .fade)
            customInlineCellIndexPath = nil
        }
        
        if !sameCellClicked {
            // hide the old custom cell and display the new one
            let rowToReveal = before ? (indexPath as NSIndexPath).row-1 : (indexPath as NSIndexPath).row
            let indexPathToReveal = IndexPath(row: rowToReveal, section: (indexPath as NSIndexPath).section)
            tableView.insertRows(at: [IndexPath(row: (indexPathToReveal as NSIndexPath).row+1, section: (indexPathToReveal as NSIndexPath).section)], with: .fade)
            customInlineCellIndexPath = IndexPath(row: (indexPathToReveal as NSIndexPath).row+1, section: (indexPathToReveal as NSIndexPath).section)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        tableView.endUpdates()
    }
    
    fileprivate func removeAnyDatePickerCell() {
        if hasInlineDatePicker() {
            tableView.beginUpdates()
            
            let indexPath = IndexPath(row: (datePickerIndexPath! as NSIndexPath).row, section: (datePickerIndexPath! as NSIndexPath).section)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            datePickerIndexPath = nil
            
            // always deselect the row containing the start or end date
            tableView.deselectRow(at: indexPath, animated:true)
            
            tableView.endUpdates()
            
            // inform our date picker of the current date to match the current cell
            updateDatePicker()
        }
    }
    
    /*! User chose to change the date by changing the values inside the UIDatePicker.
        @param sender The sender for this action: UIDatePicker.
    */
    func didDatePickerValueChanged(_ sender: UIDatePicker) {
        
        var targetedCellIndexPath: IndexPath?
        
        if self.hasInlineDatePicker() {
            // inline date picker: update the cell's date "above" the date picker cell
            targetedCellIndexPath = IndexPath(row: (datePickerIndexPath! as NSIndexPath).row - 1, section: (datePickerIndexPath! as NSIndexPath).section)
        } else {
            // external date picker: update the current "selected" cell's date
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                targetedCellIndexPath = selectedIndexPath
            }
        }
        
        // update the cell's date string
        if let selectedIndexPath = targetedCellIndexPath {
            let cell = tableView.cellForRow(at: selectedIndexPath) as! KHADateFormCell
            let targetedDatePicker = sender
            cell.date = targetedDatePicker.date
        }
    }
    
    
    // MARK: - Delegate
    
    open func textFieldDidBeginEditing(_ textField: UITextField) {
        removeAnyDatePickerCell()
    }

    open func textViewDidBeginEditing(_ textView: UITextView) {
        removeAnyDatePickerCell()
    }
    
    func selectionFormDidChangeSelectedIndex(_ selectionForm: KHASelectionFormViewController) {
        let cell = tableView.cellForRow(at: lastIndexPath!) as! KHASelectionFormCell
        cell.detailTextLabel?.text = selectionForm.selections[selectionForm.selectedIndex]
    }
}
