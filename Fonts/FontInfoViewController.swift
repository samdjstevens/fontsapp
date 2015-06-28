//
//  FontInfoViewController.swift
//  Fonts
//
//  Created by Sam Stevens on 28/06/2015.
//  Copyright © 2015 Sam Stevens. All rights reserved.
//

import UIKit

class FontInfoViewController: UIViewController {
    
    var font: UIFont!
    var favourite: Bool = false
    @IBOutlet weak var fontSampleLabel: UILabel!
    @IBOutlet weak var fontSizeSlider: UISlider!
    @IBOutlet weak var fontSizeLabel: UILabel!
    @IBOutlet weak var favouriteSwitch: UISwitch!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fontSampleLabel.font = font
        fontSampleLabel.text = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz 0123456789"
        fontSizeSlider.value = Float(font.pointSize)
        fontSizeLabel.text = "\(Int(font.pointSize))"
        favouriteSwitch.on = favourite
    }


    // When the slider value changes
    @IBAction func slideFontSize(slider: UISlider) {
        let newSize = roundf(slider.value)
        fontSampleLabel.font = font.fontWithSize(CGFloat(newSize))
        fontSizeLabel.text = "\(Int(newSize))"
    }
    
    // When the favourites switch is toggled
    @IBAction func toggleFavourite(sender: UISwitch) {
        let favouritesList = FavouritesList.sharedFavouritesList
        
        if sender.on {
            favouritesList.addFavourite(font.fontName)
        } else {
            favouritesList.removeFavourite(font.fontName)
        }
    }
}
