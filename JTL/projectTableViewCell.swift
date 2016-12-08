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
    @IBOutlet weak var baseImageView: UIImageView!
    @IBOutlet weak var projectImageView: UIImageView!
    @IBOutlet weak var projectNumberLabel: UILabel!
    @IBOutlet weak var projectNameLabel: UILabel!
    var projectImage: UIImage?
    var heightConstraint: NSLayoutConstraint?
    var widthConstraint: NSLayoutConstraint?
    var baseView: UIView?

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
        
        if let image = projectImage {
            
            // since cells can be reused, we have to remove the previous constraints and create new ones
            // this is because some images come from ipads and are different sizes
            if let hConstraint = heightConstraint {
                hConstraint.isActive = false
            }
            if let wConstraint = widthConstraint {
                wConstraint.isActive = false
            }
            
            // compute what the rect is for the image with a set aspect ratio
            let newRect = AVMakeRect(aspectRatio: image.size, insideRect: baseImageView.frame)
            projectImageView.frame = CGRect(x: 0.0, y: newRect.origin.y,
                                        width: newRect.size.width, height: newRect.size.height)
            
            // create a new UIView, but first lets check to see if there is already a view created before and we will delete it
            if let view = baseView {
                view.removeFromSuperview()
            }
            
            baseView = UIView(frame: projectImageView.frame)
            self.addSubview(baseView!)
            
            heightConstraint = NSLayoutConstraint(item: projectImageView, attribute: .height, relatedBy: .equal, toItem: baseView, attribute: .height, multiplier: 1.0, constant: 0.0)
            heightConstraint!.isActive = true
            
            widthConstraint = NSLayoutConstraint(item: projectImageView, attribute: .width, relatedBy: .equal, toItem: baseView, attribute: .width, multiplier: 1.0, constant: 0.0)
            widthConstraint!.isActive = true
            
            projectImageView.image = image
        }
    }
    
    // ------------------------------------------------------------------------------------------
    
}
