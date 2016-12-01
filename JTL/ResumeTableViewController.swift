//
//  ResumeTableViewController.swift
//  JTL
//
//  Created by Jacob Landman on 11/30/16.
//  Copyright © 2016 Jacob Landman. All rights reserved.
//

import UIKit

class ResumeTableViewController: UITableViewController {

    // PARAMETERS
    // ------------------------------------------------------------------------------------------
    var sections = [String]()
    
    
    // METHODS
    // ------------------------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadSections()
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
        sections.append("Publications")
    }
    
    // ------------------------------------------------------------------------------------------
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // modify the text label attributes
        cell.textLabel?.text = sections[indexPath.row]
        cell.textLabel?.textColor = UIColor.black
        cell.textLabel?.backgroundColor = UIColor.clear
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: cell.frame.height / 6)
        
        // modify the add the image to the view and send it to the back
        let name: String = sections[indexPath.row].replacingOccurrences(of: " ", with: "").appending(".png")
        if let path = Bundle.main.path(forResource: name, ofType: nil) {
            print(name)
            let imageView = UIImageView(frame: cell.frame)
            imageView.image = UIImage(contentsOfFile: path)!
            imageView.center = cell.center
            imageView.frame.size = cell.frame.size
            imageView.contentMode = .scaleAspectFill
            cell.addSubview(imageView)
            cell.sendSubview(toBack: imageView)
        }
        
        
        return cell
    }
    
    // ------------------------------------------------------------------------------------------
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    
    // ------------------------------------------------------------------------------------------
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(sections[indexPath.row])
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
}
