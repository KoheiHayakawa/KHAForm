# KHAForm

[![Platform](http://img.shields.io/badge/platform-ios-blue.svg?style=flat
)](https://developer.apple.com/iphone/index.action)
[![Language](http://img.shields.io/badge/language-swift-brightgreen.svg?style=flat
)](https://developer.apple.com/swift)

###Screen Shots
<img alt="Screen Shot 01" src="https://raw.githubusercontent.com/wiki/KoheiHayakawa/Form/images/screen_shot_01.png" width="200"/>
<img alt="Screen Shot 02" src="https://raw.githubusercontent.com/wiki/KoheiHayakawa/Form/images/screen_shot_02.png" width="200"/>

###Usage
```swift
import UIKit

class ExampleForm: KHAForm { // Implement subclass of KHAForm

    // override a method to determine form structure
    override func formCellsInForm(form: KHAForm) -> [[KHAFormCell]] {
        
        // setup cells
        let cell1 = initFormCellWithType(.TextField)        as KHATextFieldFormCell
        let cell2 = initFormCellWithType(.SegmentedControl) as KHASegmentedControlFormCell
        let cell3 = initFormCellWithType(.Switch)           as KHASwitchFormCell
        let cell4 = initFormCellWithType(.Date)             as KHADateFormCell
        let cell5 = initFormCellWithType(.Date)             as KHADateFormCell
        let cell6 = initFormCellWithType(.TextView)         as KHATextViewFormCell
        let cell7 = initFormCellWithType(.Button)           as KHAButtonFormCell
        let cell8 = initFormCellWithType(.Button)           as KHAButtonFormCell
        
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
        
        // Form structure is determined by using two-dimensional array.
        // First index determines section and second index determines row.
        return [[cell1, cell2, cell3], [cell4, cell5], [cell6], [cell7, cell8]]
    }

    func didPressedDeleteButton(sender: UIButton) {
        println("delete")
        
        // We can access to the first cell contains text field...
        let cell1 = formCellForIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as KHATextFieldFormCell
        println(cell1.textField.text)
        
        // ...and second cell contains segmented controller, etc...
        let cell2 = formCellForIndexPath(NSIndexPath(forRow: 1, inSection: 0)) as KHASegmentedControlFormCell
        println(cell2.segmentedControl.selectedSegmentIndex)
        
        let cell3 = formCellForIndexPath(NSIndexPath(forRow: 2, inSection: 0)) as KHASwitchFormCell
        println(cell3.sswitch.on)
        
        let cell4 = formCellForIndexPath(NSIndexPath(forItem: 0, inSection: 1)) as KHADateFormCell
        println(cell4.date)
    }
    
    func didPressedCancelButton(sender: UIButton) {
        println("cancel")
    }
}
```
