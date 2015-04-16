//
//  ExampleFormTableViewController.swift
//  KHAFormDemo
//
//  Created by Kohei Hayakawa on 4/5/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import UIKit
import KHAForm

class ExampleFormTableViewController: KHAFormController, KHAFormControllerDataSource { // Implement subclass of KHAForm

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // override a method to determine form structure
    override func formCellsInForm(form: KHAFormController) -> [[KHAFormCell]] {
        
        // setup cells
        let cell1 = KHAFormCell.formCellWithType(.TextField)
        let cell2 = KHAFormCell.formCellWithType(.SegmentedControl)
        let cell3 = KHAFormCell.formCellWithType(.Switch)
        let cell4 = KHAFormCell.formCellWithType(.Date)
        let cell5 = KHAFormCell.formCellWithType(.Date)
        let cell6 = KHAFormCell.formCellWithType(.TextView)
        let cell7 = KHAFormCell.formCellWithType(.Button)
        let cell8 = KHAFormCell.formCellWithType(.Button)
        let cell9 = KHAFormCell()   // we can use custom cell
        
        // settings for each cell
        cell1.textField.text = "Title"
        cell1.textField.placeholder = "placeholder"
        cell1.textField.clearButtonMode = UITextFieldViewMode.Always
        
        cell2.segmentedControl.setTitle("First", forSegmentAtIndex: 0)
        cell2.segmentedControl.setTitle("Second", forSegmentAtIndex: 1)
        cell2.segmentedControl.insertSegmentWithTitle("Third", atIndex: 2, animated: false) // Add segment
        
        cell4.date = NSDate()

        cell5.date = NSDate()
        
        cell6.textView.placeholder = "placeholder" // We can add placeholder on textview
        
        cell7.button.setTitle("Delete", forState: .Normal)
        cell7.button.setTitleColor(UIColor.redColor(), forState: .Normal)
        cell7.button.addTarget(self, action: Selector("didPressedDeleteButton:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        cell8.button.setTitle("Cancel", forState: .Normal)
        cell8.button.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        cell8.button.addTarget(self, action: Selector("didPressedCancelButton:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        cell9.textLabel?.text = "custom cell"
        
        // Form structure is determined by using two-dimensional array.
        // First index determines section and second index determines row.
        return [[cell1, cell2, cell3], [cell4, cell5], [cell6], [cell7, cell8], [cell9]]
    }
    
    func didPressedDeleteButton(sender: UIButton) {
        println("delete")
        
        // We can access to the first cell contains text field...
        let cell1 = formCellForIndexPath(NSIndexPath(forRow: 0, inSection: 0))
        println(cell1.textField.text)
        
        // ...and second cell contains segmented controller, etc...
        let cell2 = formCellForIndexPath(NSIndexPath(forRow: 1, inSection: 0))
        println(cell2.segmentedControl.selectedSegmentIndex)
        
        let cell3 = formCellForIndexPath(NSIndexPath(forRow: 2, inSection: 0))
        println(cell3.sswitch.on)
        
        let cell4 = formCellForIndexPath(NSIndexPath(forRow: 0, inSection: 1))
        println(cell4.date)
    }
    
    func didPressedCancelButton(sender: UIButton) {
        println("cancel")
    }

}

