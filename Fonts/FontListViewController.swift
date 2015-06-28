//
//  FontListViewController.swift
//  Fonts
//
//  Created by Sam Stevens on 28/06/2015.
//  Copyright © 2015 Sam Stevens. All rights reserved.
//

import UIKit

class FontListViewController: UITableViewController {
    
    
    var fontNames: [String] = []
    var showFavourites: Bool = false
    
    private var cellPointSize: CGFloat!
    private let cellIdentifier = "FontName"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the table to auto adjust cell height
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let preferredTableViewFont = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        cellPointSize = preferredTableViewFont.pointSize
    }
    
    
    // Before the view will be presented on the screen, check whether or not we
    // are showing the Favourites list, and if we are, fetch the data and re-load
    // so that it's always correct.
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if showFavourites {
            fontNames = FavouritesList.sharedFavouritesList.favourites
            tableView.reloadData()
        }
        
    }
    
    
    // Helper method to get the font to use for a table row
    func fontForDisplay(atIndexPath indexPath: NSIndexPath) -> UIFont {
        let fontName = fontNames[indexPath.row]
        return UIFont(name: fontName, size: cellPointSize)!
    }
    
    // Number of rows in section = the number of font names
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fontNames.count
    }
    
    // What to display in the table rows
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.font = fontForDisplay(atIndexPath: indexPath)
        cell.textLabel?.text = fontNames[indexPath.row]
        cell.detailTextLabel?.text = fontNames[indexPath.row]
        
        return cell

    }
    
    // Only allow editing of the tableview if we're showing the favourites
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return showFavourites
    }
    
    // Deleti   ng
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        // Only editing on favourites
        if !showFavourites {
            return
        }
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            // Delete the row from the datasource
            let favourite = fontNames[indexPath.row]
            
            // delete the favourite
            FavouritesList.sharedFavouritesList.removeFavourite(favourite)
            
            // get the favourites again
            fontNames = FavouritesList.sharedFavouritesList.favourites
            
            // Remove the row from the table
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        }
    }
    
    
    // MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let tableViewCell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(tableViewCell)!
        let font = fontForDisplay(atIndexPath: indexPath)
        
        if segue.identifier == "ShowFontSizes" {
            
            let sizesVC = segue.destinationViewController as! FontSizesViewController
            sizesVC.navigationItem.title = font.fontName
            sizesVC.font = font
        
        } else {
            
            // Info VC
            let infoVC = segue.destinationViewController as! FontInfoViewController
            infoVC.font = font
            infoVC.favourite = FavouritesList.sharedFavouritesList.favourites.contains(font.fontName)
        }
    
    }
}
