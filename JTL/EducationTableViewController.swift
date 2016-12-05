//
//  EducationTableViewController.swift
//  JTL
//
//  Created by Jacob Landman on 12/1/16.
//  Copyright © 2016 Jacob Landman. All rights reserved.
//

import UIKit

class EducationTableViewController: UITableViewController {

    
    // PARAMETERS
    // ------------------------------------------------------------------------------------------
    let cellText = [String]()
    
    // METHODS
    // ------------------------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadText()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    // ------------------------------------------------------------------------------------------
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // nav height shoudl be 44
        let navHeight: CGFloat = (navigationController?.navigationBar.frame.size.height)!
        
        return (tableView.frame.size.height - navHeight) / 2.0
    }
    
    // ------------------------------------------------------------------------------------------
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let navHeight: CGFloat = (navigationController?.navigationBar.frame.size.height)!
        return (tableView.frame.size.height - navHeight) / 2.0
    }
    
    // ------------------------------------------------------------------------------------------
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
    }
    
    // ------------------------------------------------------------------------------------------
    
    func loadText() {
        
    }
    
    // ------------------------------------------------------------------------------------------
}
