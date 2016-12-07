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
    var selectedIndexPath: IndexPath?
    
    
    // METHODS
    // ------------------------------------------------------------------------------------------
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // ------------------------------------------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = selectedIndexPath {
            if let cell = tableView.cellForRow(at: indexPath) as? dataTableViewCell {
               cell.dataImage.alpha = 0.95
            }
        }
    }
    
    // ------------------------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setImageNames()
        
        if dataType == "Technical Experience" { cellAccessory = .disclosureIndicator }
        
        // create an observer to know when we enter the foreground
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: .UIApplicationWillEnterForeground, object: nil)
        
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
        let navHeight: CGFloat
        if let nc = navigationController {
            navHeight = nc.navigationBar.frame.size.height
        } else {
            print("The navigation controller is nil")
            navHeight = 0.0
        }
        
        return (tableView.frame.size.height - navHeight) / 3.0
    }
    
    // ------------------------------------------------------------------------------------------
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        // nav height shoudl be 44
        let navHeight: CGFloat
        if let nc = navigationController {
            navHeight = nc.navigationBar.frame.size.height
        } else {
            print("The navigation controller is nil")
            navHeight = 0.0
        }
        return (tableView.frame.size.height  - navHeight) / 3.0
    }
    
    // ------------------------------------------------------------------------------------------
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SectionCell", for: indexPath) as! dataTableViewCell
        
        let type = dataType.lowercased()
        let name: String = type.replacingOccurrences(of: " ", with: "").appending(imageNames[indexPath.row].appending(".jpg"))
        print(name)
        cell.dataImage.image = UIImage(named: name)
        cell.dataImage.alpha = 0.95
        
        // modify the labe attributes
        cell.dataLabel.text = data[indexPath.row]
        //cell.interestLabel.frame = cell.frame
        cell.dataLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: cell.frame.height / 6)
        cell.dataLabel.textColor = UIColor.white
        cell.accessoryType = cellAccessory
        if cellAccessory != .none { cell.isUserInteractionEnabled = true }
        
        if (cell.dataLabel.text == "jlandman@tamu.edu") { cell.isUserInteractionEnabled = true }
        
        if dataType == "Publications" { cell.dataLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: cell.frame.height / 12) }
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
        if (dataType == "Awards" || dataType == "Publications" || dataType == "Technical Experience" || dataType == "Personal Info") {
            for i in 0 ..< data.count {
                imageNames.append(String(i))
            }
        } else {
            imageNames = data
        }
    }
    
    // ------------------------------------------------------------------------------------------
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? dataTableViewCell {
            
            cell.dataImage.alpha = 0.5
            selectedIndexPath = indexPath
            
            if cell.dataLabel.text == "jlandman@tamu.edu" {
                if let url = URL(string: "mailto:jlandman@tamu.edu") {
                    UIApplication.shared.open(url, options: [:])
                    return
                }
            }
            
            performSegue(withIdentifier: "segueToDetailView", sender: self)
        }
    }
    
    // ------------------------------------------------------------------------------------------
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueToDetailView") {
            if let vc = segue.destination as? detailViewController {
                if let indexPath = selectedIndexPath {
                    let name: String = dataType.lowercased().replacingOccurrences(of: " ", with: "").appending(imageNames[indexPath.row])
                    vc.imageName = name.appending(".jpg")
                    let text = loadText(withName: name)
                    vc.text = text
                    vc.label = data[indexPath.row]
                }
            }
        }
    }
    
    // ------------------------------------------------------------------------------------------
    
    func loadText(withName fileName: String) -> String {
        // don't need to unwrap the selected index path because at this point we know it has been set
        print(fileName)
        if let filePath = Bundle.main.path(forResource: fileName, ofType: "txt") {
            do {
                let detailText = try String(contentsOfFile: filePath)
                return detailText
            } catch {
                // should present an alert controller here
                print("The detailed data could not be loaded")
            }
        }
        
        return ""
    }
    
    // ------------------------------------------------------------------------------------------
    
    func willEnterForeground() {
        if let indexPath = selectedIndexPath {
            if let cell = tableView.cellForRow(at: indexPath) as? dataTableViewCell {
                cell.dataImage.alpha = 0.95
            }
        }
    }
    
    // ------------------------------------------------------------------------------------------

}
