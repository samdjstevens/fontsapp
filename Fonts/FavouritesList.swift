//
//  FavouritesList.swift
//  Fonts
//
//  Created by Sam Stevens on 20/06/2015.
//  Copyright © 2015 Sam Stevens. All rights reserved.
//

import Foundation
import UIKit

class FavouritesList {
    
    class var sharedFavouritesList : FavouritesList {
        struct Singleton {
            static let instance = FavouritesList()
        }
        
        return Singleton.instance
    }
    
    private(set) var favourites: [String]
    
    init() {
        let defaults = NSUserDefaults.standardUserDefaults()
        let storedFavourites = defaults.objectForKey("favourites") as? [String]
        favourites = storedFavourites != nil ? storedFavourites! : []
    }
    
    
    func addFavourite(fontName: String) {
        
        // If the font name isn't in the current list of favourites...
        if !favourites.contains(fontName) {
            // Add to the list
            favourites.append(fontName)
            // And save
            saveFavourites()
        }
    }
    
    func removeFavourite(fontName: String) {
        
        // If the font name is actually in the list of favourites...
        if let index = favourites.indexOf(fontName) {
            // Remove it from the list
            favourites.removeAtIndex(index)
            // And save
            saveFavourites();
        }
        
    }
    
    func moveItem(fromIndex from: Int, toIndex to: Int) {
        let item = favourites[from]
        favourites.removeAtIndex(from)
        favourites.insert(item, atIndex: to)
        saveFavourites()
    }
    
    func saveFavourites() {
        
        // Fetch the user defaults
        let defaults = NSUserDefaults.standardUserDefaults()
        // Write to the object with the array
        defaults.setObject(favourites, forKey: "favourites")
        defaults.synchronize()
    }
    
    
}