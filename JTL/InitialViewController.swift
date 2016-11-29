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
    
    // METHODS
    // ------------------------------------------------------------------------------------------
    // This method only gets called once. We will make the labels here and add them as subviews
    
    override func loadView() {
        super.loadView()
        
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

        let offset: CGFloat = 50.0
        let viewWidth: CGFloat = 375
        
        jacobLabel = UILabel()
        jacobLabel.frame = CGRect(x: viewWidth + offset, y: 77, width: 201.5, height: 56)
        jacobLabel.text = "Jacob"
        jacobLabel.textColor = UIColor.black
        jacobLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 50)
        view.addSubview(jacobLabel)
        
        taylorLabel = UILabel()
        taylorLabel.frame = CGRect(x: viewWidth + offset, y: 131, width: 201.5, height: 56)
        taylorLabel.text = "Taylor"
        taylorLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 50)
        view.addSubview(taylorLabel)
        
        landmanLabel = UILabel()
        landmanLabel.frame = CGRect(x: viewWidth + offset, y: 183, width: 201.5, height: 56)
        landmanLabel.text = "Landman"
        landmanLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 50)
        view.addSubview(landmanLabel)
    }
    
    // ------------------------------------------------------------------------------------------
}
