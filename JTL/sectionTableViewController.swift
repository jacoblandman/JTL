//
//  sectionTableViewController.swift
//  JTL
//
//  Created by Jacob Landman on 12/6/16.
//  Copyright © 2016 Jacob Landman. All rights reserved.
//

import UIKit

class sectionTableViewController: UITableViewController {

    // PARAMETERS
    // ------------------------------------------------------------------------------------------
    var data = [String]()
    var dataType: String = "Interests"
    var imageNames = [String]()
    var cellAccessory: UITableViewCellAccessoryType = .none
    
    
    // METHODS
    // ------------------------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setImageNames()
        
        if dataType == "Technical Experience" { cellAccessory = .disclosureIndicator }
        
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! dataTableViewCell
        
        let type = dataType.lowercased()
        let name: String = type.appending(imageNames[indexPath.row].replacingOccurrences(of: " ", with: "").appending(".jpg"))
        cell.dataImage.image = UIImage(named: name)
        
        // modify the labe attributes
        cell.dataLabel.text = data[indexPath.row]
        //cell.interestLabel.frame = cell.frame
        cell.dataLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: cell.frame.height / 6)
        cell.dataLabel.textColor = UIColor.white
        cell.accessoryType = cellAccessory  
        
        if cell.dataImage.image == nil { cell.dataLabel.textColor = UIColor.black }
        
        return cell
    }
    
    // ------------------------------------------------------------------------------------------
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    // ------------------------------------------------------------------------------------------
    
    func loadData() {
        if let filePath = Bundle.main.path(forResource: dataType.replacingOccurrences(of: " ", with: ""), ofType: "txt") {
            do {
                let text = try String(contentsOfFile: filePath)
                data = text.components(separatedBy: "\n")
            } catch {
                // should present an alert controller here
                print("The data could not be loaded")
            }
        }
        // make sure no elements are empty strings
        data = data.filter { $0 != "" }
    }
    
    // ------------------------------------------------------------------------------------------
    
    func setImageNames() {
        imageNames.removeAll()
        if (dataType == "Awards" || dataType == "Publications") {
            for i in 0 ..< data.count {
                imageNames.append(String(i))
            }
        } else {
            imageNames = data
        }
    }
    
    // ------------------------------------------------------------------------------------------

}
