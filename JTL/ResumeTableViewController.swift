//
//  ResumeTableViewController.swift
//  JTL
//
//  Created by Jacob Landman on 11/30/16.
//  Copyright © 2016 Jacob Landman. All rights reserved.
//

import UIKit
import CoreImage

enum SectionType: Int {
    case personalInfo
    case technicalExperience
    case languages
    case education
    case awards
    case interests
    case publications
}

class ResumeTableViewController: UITableViewController {

    // PARAMETERS
    // ------------------------------------------------------------------------------------------
    var sections = [String]()
    var selectedIndexPath: IndexPath?
    var context: CIContext!
    var filter: CIFilter!
    
    
    // METHODS
    // ------------------------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadSections()
        
        filter = CIFilter(name: "CIExposureAdjust")
        context = CIContext()
    }
    
    // ------------------------------------------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = selectedIndexPath {
            let cell = tableView.cellForRow(at: indexPath) as! ResumeSectionTableViewCell
            cell.sectionImage.alpha = 0.9
        }
    }
    
    // ------------------------------------------------------------------------------------------

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // ------------------------------------------------------------------------------------------

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    // ------------------------------------------------------------------------------------------
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // tab height should be 49
        let tabHeight: CGFloat = (tabBarController?.tabBar.frame.size.height)!
        // nav height shoudl be 44
        let navHeight: CGFloat = (navigationController?.navigationBar.frame.size.height)!
        
        return (tableView.frame.size.height - tabHeight - navHeight) / 3.0
    }
    
    // ------------------------------------------------------------------------------------------
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let tabHeight: CGFloat = (tabBarController?.tabBar.frame.size.height)!
        let navHeight: CGFloat = (navigationController?.navigationBar.frame.size.height)!
        return (tableView.frame.size.height - tabHeight - navHeight) / 3.0
    }
    
    // ------------------------------------------------------------------------------------------
    
    func loadSections() {
        sections.append("Personal Info")
        sections.append("Technical Experience")
        sections.append("Languages")
        sections.append("Education")
        sections.append("Awards")
        sections.append("Interests")
        sections.append("Publications")
    }
    
    // ------------------------------------------------------------------------------------------
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ResumeSectionTableViewCell
        
        let name: String = sections[indexPath.row].replacingOccurrences(of: " ", with: "").appending(".jpg")
        cell.sectionImage.image = UIImage(named: name)
        
        // modify the labe attributes
        cell.sectionLabel.text = sections[indexPath.row]
        cell.sectionLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: cell.frame.height / 6)
        cell.sectionLabel.textColor = UIColor.white
        
        // it turns out that performance is suffering from filtering the image on the fly
        // instead we will do image filtering before
        // this isn't surprising since we have to create additional CIImage and CGImages
        //filterCellImage(cell: cell)
        
        return cell
    }
    
    // ------------------------------------------------------------------------------------------
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    
    // ------------------------------------------------------------------------------------------
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ResumeSectionTableViewCell
        cell.sectionImage.alpha = 0.5
        selectedIndexPath = indexPath
        
        segueToNextView(sectionType: SectionType(rawValue: indexPath.row)!)
        
    }
    
    // ------------------------------------------------------------------------------------------
    
    func changeTabBar(hidden: Bool, animated: Bool){
        let tabBar = self.tabBarController?.tabBar
        if tabBar!.isHidden == hidden { return }
        let frame = tabBar?.frame
        let offset = (hidden ? (frame?.size.height)! : -(frame?.size.height)!)
        let duration:TimeInterval = (animated ? 0.5 : 0.0)
        tabBar?.isHidden = false
        if frame != nil
        {
            UIView.animate(withDuration: duration, animations: {tabBar!.frame = frame!.offsetBy(dx: 0, dy: offset)}, completion: {
                print($0)
                if $0 {tabBar?.isHidden = hidden}
            })
        }
    }
    
    // ------------------------------------------------------------------------------------------
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            changeTabBar(hidden: true, animated: true)
        } else {
            changeTabBar(hidden: false, animated: true)
        }
    }
    
    // ------------------------------------------------------------------------------------------
    
    func segueToNextView(sectionType: SectionType) {
        
        switch sectionType {
            case .personalInfo:
                let vc = UITableViewController()
                (navigationController?.pushViewController(vc, animated: true))!
            
            case .languages:
                performSegue(withIdentifier: "segueToLanguages", sender: self)
            
            case .education:
                performSegue(withIdentifier: "segueToEducation", sender: self)
            
            case .interests:
                performSegue(withIdentifier: "segueToInterests", sender: self)
            
            default:
                let vc = UITableViewController()
                (navigationController?.pushViewController(vc, animated: true))!
        }

    }
    
    // ------------------------------------------------------------------------------------------
    
    func filterCellImage(cell: ResumeSectionTableViewCell) {
        // attempt to filter the image
        let inputImage = CIImage(image: cell.sectionImage.image!)
        
        // The inputEV value on the CIFilter adjusts exposure (negative values darken, positive values brighten)
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        filter.setValue(-2.0, forKey: kCIInputEVKey)
        
        // Break early if the filter was not a success (.outputImage is optional in Swift)
        if let cgimg = context.createCGImage(filter.outputImage!, from: filter.outputImage!.extent) {
            let processedImage = UIImage(cgImage: cgimg)
            let resizedImage = processedImage.resize(maxHeight: cell.frame.size.height, maxWidth: cell.frame.size.width)
            cell.sectionImage.image = resizedImage
        }

    }
    
    // ------------------------------------------------------------------------------------------
}
