# KHAForm

[![Platform](http://img.shields.io/badge/platform-ios-blue.svg?style=flat
)](https://developer.apple.com/iphone/index.action)
[![Language](http://img.shields.io/badge/language-swift-brightgreen.svg?style=flat
)](https://developer.apple.com/swift)

###CocoaPods
~~~
platform :ios, '8.0'
use_frameworks!

pod 'KHAForm'
~~~

###Requirements
* iOS 8.0+
* Xcode 6.3+
* Swift 1.2

###Screen Shots
<img alt="Screen Shot 01" src="https://raw.githubusercontent.com/wiki/KoheiHayakawa/Form/images/screen_shot_01.png" width="200"/>
<img alt="Screen Shot 02" src="https://raw.githubusercontent.com/wiki/KoheiHayakawa/Form/images/screen_shot_02.png" width="200"/>

###Usage
```swift
import UIKit
import KHAForm // Import KHAForm


// Inherit KHAFormController and adopt KHAFormControllerDataSource

class ExampleFormController: KHAFormController, KHAFormDataSource {

    // Override a method to determine form structure
    override func formCellsInForm(form: KHAFormController) -> [[KHAFormCell]] {
    
        // setup cells
        let cell1 = KHAFormCell.formCellWithType(.TextField) // We can init form cell with type.
        let cell2 = dequeueReusableFormCellWithType(.SegmentedControl) // But it's better to dequeue.
        let cell3 = dequeueReusableFormCellWithType(.Switch)
        let cell4 = dequeueReusableFormCellWithType(.Date)
        let cell5 = dequeueReusableFormCellWithType(.Date)
        let cell6 = dequeueReusableFormCellWithType(.TextView)
        let cell7 = dequeueReusableFormCellWithType(.Button)
        let cell8 = dequeueReusableFormCellWithType(.Button)
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
```

###Contact
[@kohei_hayakawa](https://twitter.com/kohei_hayakawa)

###License
KHAForm is released under the MIT license. See LICENSE for details.
