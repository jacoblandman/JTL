//
//  interestsTableViewController.swift
//  JTL
//
//  Created by Jacob Landman on 12/1/16.
//  Copyright © 2016 Jacob Landman. All rights reserved.
//

import UIKit

class interestsTableViewController: UITableViewController {

    // PARAMETERS
    // ------------------------------------------------------------------------------------------
    var interests = [String]()
    var context: CIContext!
    var filter: CIFilter!
    
    
    // METHODS
    // ------------------------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadInterests()
        
        filter = CIFilter(name: "CIExposureAdjust")
        context = CIContext()
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
        // nav height shoudl be 44
        let navHeight: CGFloat = (navigationController?.navigationBar.frame.size.height)!
        
        return (tableView.frame.size.height - navHeight) / 3.0
    }
    
    // ------------------------------------------------------------------------------------------
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let navHeight: CGFloat = (navigationController?.navigationBar.frame.size.height)!
        return (tableView.frame.size.height  - navHeight) / 3.0
    }
    
    // ------------------------------------------------------------------------------------------
    
    func loadInterests() {
        interests.append("Hiking")
        interests.append("Swimming")
        interests.append("Football")
        interests.append("Baseball")
        interests.append("Golf")
    }
    
    // ------------------------------------------------------------------------------------------
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! interestsTableViewCell
        
        let name: String = "interest".appending(interests[indexPath.row].replacingOccurrences(of: " ", with: "").appending(".jpg"))
        cell.interestImage.image = UIImage(named: name)
        
        // modify the labe attributes
        cell.interestLabel.text = interests[indexPath.row]
        //cell.interestLabel.frame = cell.frame
        cell.interestLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: cell.frame.height / 6)
        cell.interestLabel.textColor = UIColor.white
    
        return cell
    }
    
    // ------------------------------------------------------------------------------------------
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interests.count
    }
    
    // ------------------------------------------------------------------------------------------
}
