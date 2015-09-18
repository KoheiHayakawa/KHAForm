//
//  PhoneSelectionFormViewController.swift
//  KHAFormDemo
//
//  Created by Kohei Hayakawa on 6/2/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import UIKit
import KHAForm

// Inherit KHASelectionFormViewController

class PhoneSelectionFormViewController: KHASelectionFormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Phone"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func selectionsForSelectionForm(selectionForm: KHASelectionFormViewController) -> [String] {
        return ["iPhone 6", "iPhone 6 Plus", "iPhone 5s"]
    }
    
    override func selectedIndexForSelectionForm(selectionForm: KHASelectionFormViewController) -> Int {
        return 0
    }
    
}
