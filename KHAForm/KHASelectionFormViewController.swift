//
//  KHASelectionFormViewController.swift
//  KHAForm
//
//  Created by Kohei Hayakawa on 5/1/15.
//
//

import UIKit

protocol KHASelectionFormViewDelegate: class {
    func selectionFormDidChangeSelectedIndex(_ selectionForm: KHASelectionFormViewController)
	func dateRepeatDidChangeSelectedIndex(_ selectionForm: KHADateRepeatViewController)
}

public protocol KHASelectionFormViewDataSource {
    func selectionsForSelectionForm(_ selectionForm: KHASelectionFormViewController) -> [String]
    func selectedIndexForSelectionForm(_ selectionForm: KHASelectionFormViewController) -> Int
}

open class KHASelectionFormViewController: UITableViewController, KHASelectionFormViewDataSource {

    fileprivate let cellID = "cell"
    open var selections: [String] = []
    open var selectedIndex: Int = 0
    weak var delegate: KHASelectionFormViewDelegate?

    
    // MARK: View lifecycle
    
    // Form is always grouped tableview
    convenience init() {
        self.init(style: .grouped)
        selections = selectionsForSelectionForm(self)
        selectedIndex = selectedIndexForSelectionForm(self)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.reloadData()
        DispatchQueue.main.async(execute: { () -> Void in
            self.tableView.scrollToRow(at: IndexPath(row: self.selectedIndex, section: 0), at: .top, animated: false)
        })
    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    open func selectionsForSelectionForm(_ selectionForm: KHASelectionFormViewController) -> [String] {
        return selections
    }
    
    open func selectedIndexForSelectionForm(_ selectionForm: KHASelectionFormViewController) -> Int {
        return selectedIndex
    }

    
    // MARK: - Table view data source
    
    override open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selections.count
    }

    override open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) 
        
        cell.textLabel?.text = selections[(indexPath as NSIndexPath).row]
        
        if selectedIndex == (indexPath as NSIndexPath).row {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }

    override open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Remove checkmark from old selected cell
        let oldSelectedCell = tableView.cellForRow(at: IndexPath(row: selectedIndex, section: 0))
        oldSelectedCell?.accessoryType = .none
        
        // Add checkmark to new selected cell
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        selectedIndex = (indexPath as NSIndexPath).row
        delegate?.selectionFormDidChangeSelectedIndex(self)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
