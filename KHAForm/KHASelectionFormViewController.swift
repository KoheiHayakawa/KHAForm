//
//  KHASelectionFormViewController.swift
//  KHAForm
//
//  Created by Kohei Hayakawa on 5/1/15.
//
//

import UIKit

protocol KHASelectionFormViewDelegate: class {
    func selectionFormDidChangeSelectedIndex(selectionForm: KHASelectionFormViewController)
}

class KHASelectionFormViewController: UITableViewController {

    private let cellID = "cell"
    var selections: [String] = []
    var selectedIndex: Int = 0
    weak var delegate: KHASelectionFormViewDelegate?

    
    // MARK: View lifecycle
    
    // Form is always grouped tableview
    convenience init() {
        self.init(style: .Grouped)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.reloadData()
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: self.selectedIndex, inSection: 0), atScrollPosition: .Top, animated: false)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selections.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel?.text = selections[indexPath.row]
        
        if selectedIndex == indexPath.row {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
        
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // Remove checkmark from old selected cell
        let oldSelectedCell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: selectedIndex, inSection: 0))
        oldSelectedCell?.accessoryType = .None
        
        // Add checkmark to new selected cell
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = .Checkmark
        selectedIndex = indexPath.row
        delegate?.selectionFormDidChangeSelectedIndex(self)
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}
