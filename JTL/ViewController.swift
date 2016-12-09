//
//  ViewController.swift
//  JTL
//
//  Created by Jacob Landman on 11/29/16.
//  Copyright © 2016 Jacob Landman. All rights reserved.
//

import UIKit
import SafariServices
import CoreSpotlight
import MobileCoreServices

class ViewController: UITableViewController {
    
    // PARAMETERS
    // ------------------------------------------------------------------------------------------
    // projects is an array of projects, which are also arrays
    // each project will hold the project name and its subtitle
    var projects = [[String]]()
    var showAC: Bool = true
    
    // METHODS
    // ------------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fillProjectsArray()
        
        // load UserDefaults if it exists there already
        let defaults = UserDefaults.standard
        if let showAlertController = defaults.object(forKey: "showAC") as? Bool {
            showAC = showAlertController
        }
        
        // set table view to be in editing mode and allow users to tap on rows to select them
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        title = "Hacking With Swift Tutorial Series"
        
        setupSearchableContent()
    }
    
    // ------------------------------------------------------------------------------------------
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // ------------------------------------------------------------------------------------------
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    // ------------------------------------------------------------------------------------------
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let project = projects[indexPath.row]
        cell.textLabel?.attributedText = makeAttributedString(title: project[0], subtitle: project[1])
        //cell.detailTextLabel?.text = project
        
        return cell
    }
    
    // ------------------------------------------------------------------------------------------
    // the following two functions make sure auto layout does the hard work for us to automatically size every cell
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // nav height shoudl be 44
        let navHeight: CGFloat
        if let nc = navigationController {
            navHeight = nc.navigationBar.frame.size.height
        } else {
            print("the nav controller is nil")
            navHeight = 44
        }
        return UITableViewAutomaticDimension
        return (tableView.frame.size.height - navHeight) / 5.0
    }
    
    // ------------------------------------------------------------------------------------------
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        // nav height shoudl be 44
        let navHeight: CGFloat
        if let nc = navigationController {
            navHeight = nc.navigationBar.frame.size.height
        } else {
            print("the nav controller is nil")
            navHeight = 44
        }
        return UITableViewAutomaticDimension
        return (tableView.frame.size.height - navHeight) / 5.0
    }
    
    // ------------------------------------------------------------------------------------------
    
    func fillProjectsArray() {
        projects.append(["Project 1: Storm Viewer", "Constants and variables, UITableView, UIImageView, FileManager, storyboards"])
        projects.append(["Project 2: Guess the Flag", "@2x and @3x images, asset catalogs, integers, doubles, floats, operators (+= and -=), UIButton, enums, CALayer, UIColor, random numbers, actions, string interpolation, UIAlertController"])
        projects.append(["Project 3: Social Media", "UIBarButtonItem, UIActivityViewController, the Social framework, URL"])
        projects.append(["Project 4: Easy Browser", "loadView(), WKWebView, delegation, classes and structs, URLRequest, UIToolbar, UIProgressView., key-value observing"])
        projects.append(["Project 5: Word Scramble", "Closures, method return values, booleans, NSRange"])
        projects.append(["Project 6: Auto Layout", "Get to grips with Auto Layout using practical examples and code"])
        projects.append(["Project 7: Whitehouse Petitions", "JSON, Data, UITabBarController"])
        projects.append(["Project 8: 7 Swifty Words", "addTarget(), enumerated(), count, index(of:), property observers, range operators."])
    }
    
    // ------------------------------------------------------------------------------------------
    
    func makeAttributedString(title: String, subtitle: String) -> NSAttributedString {
        // NSFontAttributesName is the dictionary key that specifies what font the attributed text should be
        // should be provided with UIFont as its value
        // NSForegroundColorAttributeName is the dictionary key that specifies what text color to use.
        let titleAttributes = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: .headline), NSForegroundColorAttributeName: UIColor.purple]
        let subtitleAttributes = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: .subheadline)]
        
        // the title is created as mutable because we append the subtitle to the title to make one attributed string that can be returned
        let titleString = NSMutableAttributedString(string: "\(title)\n", attributes: titleAttributes)
        let subtitleString = NSAttributedString(string: "\(subtitle)", attributes: subtitleAttributes)
        
        titleString.append(subtitleString)
        
        return titleString
    }
    
    // ------------------------------------------------------------------------------------------
    
    func showTutorial(_ which: Int) {
        if let url = URL(string: "https://www.hackingwithswift.com/read/\(which + 1)") {
            let vc = SFSafariViewController(url: url, entersReaderIfAvailable: true)
            present(vc, animated: true)
        }
    }
    
    // ------------------------------------------------------------------------------------------
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showTutorial(indexPath.row)
    }
    
    // ------------------------------------------------------------------------------------------
    
    func index(item: Int) {
        let project = projects[item]
        
        // kUTTypeTexas as String tells iOS we want to store text in our indexed record
        let attributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
        attributeSet.title = project[0]
        attributeSet.contentDescription = project[1]
        
        let item = CSSearchableItem(uniqueIdentifier: "\(item)", domainIdentifier: "com.hackingwithswift", attributeSet: attributeSet)
        // never expire index
        item.expirationDate = Date.distantFuture
        CSSearchableIndex.default().indexSearchableItems([item]) { error in
            if let error = error {
                print("Indexing error: \(error.localizedDescription)")
            } else {
                print("Search item successfully indexed!")
            }
        }
    }
    
    // ------------------------------------------------------------------------------------------
    
    func setupSearchableContent() {
        for i in 0 ..< projects.count {
            index(item: i)
        }
    }
    
    // ------------------------------------------------------------------------------------------
    
}


