//
//  interestsTableViewCell.swift
//  JTL
//
//  Created by Jacob Landman on 12/1/16.
//  Copyright © 2016 Jacob Landman. All rights reserved.
//

import UIKit

class interestsTableViewCell: UITableViewCell {
    
    // PARAMETERS
    // ------------------------------------------------------------------------------------------
    @IBOutlet weak var interestLabel: UILabel!
    @IBOutlet weak var interestImage: UIImageView!


    // METHODS
    // ------------------------------------------------------------------------------------------
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // ------------------------------------------------------------------------------------------
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // ------------------------------------------------------------------------------------------

}
