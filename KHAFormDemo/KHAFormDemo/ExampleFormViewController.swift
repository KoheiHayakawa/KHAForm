//
//  ExampleFormController.swift
//  KHAFormDemo
//
//  Created by Kohei Hayakawa on 4/5/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import UIKit
import KHAForm // Import KHAForm


// Inherit KHAFormViewController

class ExampleFormViewController: KHAFormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Override a method to determine form structure
    override func formCellsInForm(_ form: KHAFormViewController) -> [[KHAFormCell]] {
        
        // setup cells
        let cell1 = KHAFormCell.formCellWithType(.textField) // We can init form cell with type.
        let cell2 = dequeueReusableFormCellWithType(.segmentedControl) // But it's better to dequeue.
        let cell3 = dequeueReusableFormCellWithType(.switch)
        let cell4 = dequeueReusableFormCellWithType(.date)
        let cell5 = dequeueReusableFormCellWithType(.date)
        let cell6 = dequeueReusableFormCellWithType(.selection)
        let cell7 = dequeueReusableFormCellWithType(.selection)
        let cell8 = dequeueReusableFormCellWithType(.textView)
        let cell9 = dequeueReusableFormCellWithType(.button)
        let cell10 = dequeueReusableFormCellWithType(.button)
        let cell11 = KHAFormCell()   // we can use custom cell
        let cell12 = KHAFormCell()
        
        // settings for each cell
        cell1.textField.text = "Title"
        cell1.textField.placeholder = "placeholder"
        cell1.textField.clearButtonMode = UITextFieldViewMode.always
        
        cell2.segmentedControl.setTitle("First", forSegmentAt: 0)
        cell2.segmentedControl.setTitle("Second", forSegmentAt: 1)
		cell2.segmentedControl.insertSegment(withTitle: "Third", at: 2, animated: false) // Add segment
        
        cell4.textLabel?.text = "Start"
        cell4.date = Date()

        cell5.textLabel?.text = "End"
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        cell5.dateFormatter = dateFormatter // We can change date format
        cell5.datePickerMode = .date        // and picker mode
        cell5.date = Date()
        
        cell6.textLabel?.text = "Fruits"
        let fruitsSelectionFormViewController = KHASelectionFormViewController()
        fruitsSelectionFormViewController.title = "Fruits"
        fruitsSelectionFormViewController.selections = ["None", "Apple", "Grape", "Orange"] // We must init selection list
        fruitsSelectionFormViewController.selectedIndex = 1 // We must assign initial selected value
        cell6.selectionFormViewController = fruitsSelectionFormViewController
    
        cell7.textLabel?.text = "Phone"
        let phoneSelectionFormViewController = PhoneSelectionFormViewController() // We can use custom controller
        cell7.selectionFormViewController = phoneSelectionFormViewController
        
        cell8.textView.placeholder = "placeholder" // We can add placeholder on textview
        
        cell9.button.setTitle("Delete", for: .normal)
        cell9.button.setTitleColor(UIColor.red, for: .normal)
        cell9.button.addTarget(self, action: #selector(ExampleFormViewController.didPressedDeleteButton(_:)), for: UIControlEvents.touchUpInside)
        
        cell10.button.setTitle("Cancel", for: .normal)
        cell10.button.setTitleColor(UIColor.darkGray, for: .normal)
        cell10.button.addTarget(self, action: #selector(ExampleFormViewController.didPressedCancelButton(_:)), for: UIControlEvents.touchUpInside)
        
        cell11.textLabel?.text = "custom cell"
        
        cell12.textLabel?.text = "Open"
        cell12.customInlineCell = cell1
        
        // Form structure is determined by using two-dimensional array.
        // First index determines section and second index determines row.
        return [[cell1, cell2, cell3], [cell4, cell5], [cell6, cell7], [cell8], [cell9, cell10], [cell11], [cell12]]
    }
    
    func didPressedDeleteButton(_ sender: UIButton) {
        print("delete")
        
        // We can access to the first cell contains text field...
        let cell1 = formCellForIndexPath(IndexPath(row: 0, section: 0))
        print(cell1.textField.text)
        
        // ...and second cell contains segmented controller, etc...
        let cell2 = formCellForIndexPath(IndexPath(row: 1, section: 0))
        print(cell2.segmentedControl.selectedSegmentIndex)
        
        let cell3 = formCellForIndexPath(IndexPath(row: 2, section: 0))
        print(cell3.sswitch.isOn)
        
        let cell4 = formCellForIndexPath(IndexPath(row: 0, section: 1))
        print(cell4.date)
        
        let cell6 = formCellForIndexPath(IndexPath(row: 0, section: 2))
		
	
		print(cell6.selectionFormViewController.selections[cell6.selectionFormViewController.selectedIndex])
    }
    
    func didPressedCancelButton(_ sender: UIButton) {
        print("cancel")
    }

}

