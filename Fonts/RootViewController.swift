//
//  RootViewController.swift
//  Fonts
//
//  Created by Sam Stevens on 20/06/2015.
//  Copyright © 2015 Sam Stevens. All rights reserved.
//

import UIKit

class RootViewController: UITableViewController {

    // Will hold the names of the font families
    private var familyNames: [String]!
    
    // The font size to use to display the font family names
    private var cellPointSize: CGFloat!
    
    // Singleton instance of FavourtesList
    private var favouritesList: FavouritesList!
    
    // The tableview cell identifier name for font family cells
    private let familyCell = "FamilyName"
    
    // The tableview cell identifier name for the favourites cell
    private let favouritesCell = "Favourites"
    

    // Load in the family names from UIFont upon load, and set the
    // cell point size as well as loading in the favourites
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load in the font family names
        familyNames = UIFont.familyNames().sort() as [String]
        
        let preferredTableViewFont = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        cellPointSize = preferredTableViewFont.pointSize
        
        favouritesList = FavouritesList.sharedFavouritesList
        
    }
    
    // Always reload table data before the view appears
    // so that in the case of data changing before controllers
    // being popped off the stack, the data is kept in sync.
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    // How many sections in the table? Well if we have any favourites, then
    // two, otheriwse, just the one
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return !favouritesList.favourites.isEmpty ? 2 : 1
    }
    
    
    // How many rows in a section? If its the first section (all font families), then
    // the number of families. If it's the second (Favourites), then just one.
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? familyNames.count : 1
    }
    
    
    // Section titles
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "All Font Families" : "My Favourite Fonts"
    }
    
    
    // Return a UITableViewCell to render for a given NSIndexPath
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
    
            let cell = tableView.dequeueReusableCellWithIdentifier(familyCell, forIndexPath: indexPath) as UITableViewCell
            cell.textLabel?.font = fontForDisplay(atIndexPath: indexPath)
            cell.textLabel?.text = familyNames[indexPath.row]
            cell.detailTextLabel?.text = familyNames[indexPath.row]
            
            return cell
        }
        
        // Or, its the favourites list.
        return tableView.dequeueReusableCellWithIdentifier(favouritesCell, forIndexPath: indexPath) as UITableViewCell
    }
    
    
    // Helper function to get the font to use for a cell at a given NSIndexPath
    func fontForDisplay(atIndexPath indexPath: NSIndexPath) -> UIFont? {
        
        // If we're in the fony family section
        if indexPath.section == 0 {
            // Set the font to just be the first font in the font family
            // being displayed
            let familyName = familyNames[indexPath.row] as String!
            let fontName = UIFont.fontNamesForFamilyName(familyName).first as String!
            
            return UIFont(name: fontName, size: cellPointSize)
        }
        
        return nil
    }
}
