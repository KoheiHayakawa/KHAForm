//
//  KHADateRepeatViewController.swift
//  Pods
//
//  Created by Eric Heitmuller on 10/27/16.
//
//

import Foundation


public class KHADateRepeatViewController: KHASelectionFormViewController {
	
	public var selectedIndices : [Int] = []
	
	override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		// Remove checkmark from old selected cell
		let oldSelectedCell = tableView.cellForRow(at: IndexPath(row: selectedIndex, section: 0))
		oldSelectedCell?.accessoryType = .none
		
		// Add checkmark to new selected cell
		let cell = tableView.cellForRow(at: indexPath)
		cell?.accessoryType = .checkmark
		selectedIndex = indexPath.row
		
		delegate?.dateRepeatDidChangeSelectedIndex(self)
		tableView.deselectRow(at: indexPath, animated: true)
	}
}
