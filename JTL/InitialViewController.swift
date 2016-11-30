//
//  InitialViewController.swift
//  JTL
//
//  Created by Jacob Landman on 11/29/16.
//  Copyright © 2016 Jacob Landman. All rights reserved.
//

import UIKit
import SafariServices

class InitialViewController: UIViewController {

    // PARAMETERS
    // ------------------------------------------------------------------------------------------
    var jacobLabel: UILabel!
    var taylorLabel: UILabel!
    var landmanLabel: UILabel!
    
    
    
    @IBOutlet weak var iosButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var linkedInButton: UIButton!
    @IBOutlet weak var resumeButton: UIButton!
    
    // METHODS
    // ------------------------------------------------------------------------------------------
    // This method only gets called once. We will make the labels here and add them as subviews
    
    override func loadView() {
        super.loadView()
        
        editButtons()
        makeLabels()
    }
    
    // ------------------------------------------------------------------------------------------
    // here I'm going to set the button borders
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        for subview in self.view.subviews {
            // loop through the buttons here to set their values
            if let btn = subview as? UIButton {
                btn.layer.borderWidth = 1.0
                btn.layer.borderColor = self.view.tintColor.cgColor
                btn.layer.cornerRadius = 10
            }
        }
    }
    
    
    // ------------------------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Animate the labels to move in
        animateLabels()

    }
    
    // ------------------------------------------------------------------------------------------

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // ------------------------------------------------------------------------------------------
    
    @IBAction func tappedIOSExperience(_ sender: Any) {
        let vc = ViewController()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    // ------------------------------------------------------------------------------------------
    // if the user taps the facebook button, they will be redirected to my facebook
    
    @IBAction func tappedFacebook(_ sender: Any) {
        let UID: String = "1372129908"
        let URLString = "fb://profile/" + UID
        
        if let url = URL(string: URLString) {
            if UIApplication.shared.canOpenURL(url) {
                // if the app is installed open it there
                print("facebook is installed")
                UIApplication.shared.open(url, options: [:])
            } else {
                // if the facebook app isn't installed open in safari
                if let safariUrl = URL(string: "https://www.facebook.com/" + UID) {
                    let vc = SFSafariViewController(url: safariUrl, entersReaderIfAvailable: true)
                    present(vc, animated: true)
                }
            }
        }
    }
    
    // ------------------------------------------------------------------------------------------
    
    @IBAction func tappedLinkedIn(_ sender: Any) {
        let UID: String = "25216973"
        let URLString = "https://www.linkedin.com/in/jacob-landman-" + UID
        
        if let url = URL(string: URLString) {
            if UIApplication.shared.canOpenURL(url) {
                // if the app is installed open it there
                print("linkedin is installed")
                UIApplication.shared.open(url, options: [:])
            } else {
                // if the facebook app isn't installed open in safari
                let vc = SFSafariViewController(url: url, entersReaderIfAvailable: false)
                present(vc, animated: true)
            }
        }
    }
    
    // ------------------------------------------------------------------------------------------
    
    @IBAction func tappedResume(_ sender: Any) {
    }
    
    // ------------------------------------------------------------------------------------------
    
    func animateLabels() {
        UIView.animate(withDuration: 1) { [unowned self] in self.jacobLabel.transform = CGAffineTransform(translationX: -self.view.frame.size.width, y: 0) }
        UIView.animate(withDuration: 1, delay: 1, options: [], animations: { [unowned self] in self.taylorLabel.transform = CGAffineTransform(translationX: -self.view.frame.size.width, y: 0) }, completion: nil)
        UIView.animate(withDuration: 1, delay: 2, options: [], animations: { [unowned self] in self.landmanLabel.transform = CGAffineTransform(translationX: -self.view.frame.size.width, y: 0) }, completion: nil)
    }
    
    // ------------------------------------------------------------------------------------------
    
    func makeLabels() {
        
        // the size of the screen is in points
        let sizeOfScreen: CGSize = UIScreen.main.bounds.size

        let offset: CGFloat = 20.0
        let viewWidth: CGFloat = sizeOfScreen.width
        
        let labelHeight: CGFloat = 56
        let labelStartingPosition: CGFloat = 77
        
        jacobLabel = UILabel()
        jacobLabel.frame = CGRect(x: viewWidth + offset, y: labelStartingPosition, width: viewWidth, height: labelHeight)
        jacobLabel.text = "Jacob"
        jacobLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: labelHeight)
        view.addSubview(jacobLabel)
        
        taylorLabel = UILabel()
        taylorLabel.frame = CGRect(x: viewWidth + offset, y: labelStartingPosition + 1 * labelHeight, width: viewWidth, height: labelHeight)
        taylorLabel.text = "Taylor"
        taylorLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: labelHeight)
        view.addSubview(taylorLabel)
        
        landmanLabel = UILabel()
        landmanLabel.frame = CGRect(x: viewWidth + offset, y: labelStartingPosition + 2 * labelHeight, width: viewWidth, height: labelHeight)
        landmanLabel.text = "Landman"
        landmanLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: labelHeight)
        view.addSubview(landmanLabel)
    }
    
    // ------------------------------------------------------------------------------------------
    
    func editButtons() {
        
        // the size of the screen is in points
        // let sizeOfScreen: CGSize = UIScreen.main.bounds.size
        
        // let offsetFromBottom: CGFloat = 40
        // let distanceBetween: CGFloat = 20
        
        // let maxButtonHeight = 0.33 * sizeOfScreen.height
        // let buttonCoverage = 0.66 * sizeOfScreen.height
        // let numberOfButtons: CGFloat = 4
        
        // we need the button height
        // let buttonHeight = (buttonCoverage - (numberOfButtons - 1) * distanceBetween - offsetFromBottom) / 4
        // let buttonWidth: CGFloat = sizeOfScreen.width / 2
        
        // iosButton.translatesAutoresizingMaskIntoConstraints = false
        // iosButton.frame = CGRect(x: <#T##CGFloat#>, y: sizeOfScreen, width: buttonWidth, height: buttonHeight)
        
        
    }
    
    // ------------------------------------------------------------------------------------------
}
