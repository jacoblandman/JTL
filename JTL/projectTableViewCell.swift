//
//  projectTableViewCell.swift
//  JTL
//
//  Created by Jacob Landman on 12/8/16.
//  Copyright © 2016 Jacob Landman. All rights reserved.
//

import UIKit
import AVFoundation

class projectTableViewCell: UITableViewCell {
    
    // PARAMETERS
    // ------------------------------------------------------------------------------------------
    @IBOutlet weak var projectImage: UIImageView!
    @IBOutlet weak var projectNumberLabel: UILabel!
    @IBOutlet weak var projectNameLabel: UILabel!

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
    
    func resizeImageView() {
        
        print(projectImage.frame)
        if let image = projectImage.image {
            
            // compute what the rect is for the image with a set aspect ratio
            let newRect = AVMakeRect(aspectRatio: image.size, insideRect: projectImage.frame)
            print(newRect)
            
            projectImage.frame = CGRect(x: 0.0, y: newRect.origin.y,
                                        width: newRect.size.width, height: newRect.size.height)
        }
        
        print(projectImage.frame)
        
        
        
        /*
        let originalImageFrame = projectImage.frame
        print(originalImageFrame)
        
        
            print(image.size)
            let frame = image.accessibilityFrame
            print(frame)
            projectImage.frame = frame
        }*/
        
    }
    
    // ------------------------------------------------------------------------------------------
    
}
