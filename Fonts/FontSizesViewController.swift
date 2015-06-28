//
//  FontSizesViewController.swift
//  Fonts
//
//  Created by Sam Stevens on 28/06/2015.
//  Copyright © 2015 Sam Stevens. All rights reserved.
//

import UIKit

class FontSizesViewController: UITableViewController {
    
    var font: UIFont!
    
    private var pointSizes: [CGFloat] {
        struct Constants {
            static let pointSizes: [CGFloat] = [
                9, 10,11, 12, 13, 14, 18, 24, 36, 48, 64, 72, 96, 144
            ]
        }
        
        return Constants.pointSizes
    }
    
    private let cellIdentifier = "FontNameAndSize"
    
    
    // Make the table cell height auto adjust...
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    
    // How many rows in each section...
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pointSizes.count
    }
    
    // What to show in the cells
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.font = fontForDisplay(atIndexPath: indexPath)
        cell.textLabel?.text = font.fontName
        cell.detailTextLabel?.text = "\(pointSizes[indexPath.row]) point"
        
        return cell
        
    }
    
    
    // Helper function to grab the right UIFont for a given indexPath (row)
    func fontForDisplay(atIndexPath indexPath: NSIndexPath) -> UIFont {
        let pointSize = pointSizes[indexPath.row]
        return font.fontWithSize(pointSize)
    }
}
