//
//  InitialViewController.swift
//  JTL
//
//  Created by Jacob Landman on 11/29/16.
//  Copyright © 2016 Jacob Landman. All rights reserved.
//

import UIKit
import SafariServices
import AudioToolbox
import AVFoundation

class InitialViewController: UIViewController {

    // PARAMETERS
    // ------------------------------------------------------------------------------------------
    var jacobLabel: UILabel!
    var taylorLabel: UILabel!
    var landmanLabel: UILabel!
    
    var iosButton: UIButton!
    var facebookButton: UIButton!
    var linkedinButton: UIButton!
    var resumeButton: UIButton!
    var myAlertSound: SystemSoundID?
    var playSound: Bool = true
    var bellButtonItem: UIBarButtonItem!
    
    var buttonTapped: Bool = false
    
    
    // METHODS
    // ------------------------------------------------------------------------------------------
    // This method only gets called once. We will make the labels here and add them as subviews
    
    override func loadView() {
        super.loadView()
        
        makeButtons()
        makeLabels()
    }
    
    // ------------------------------------------------------------------------------------------
    // here I will add the auto layout constraints now that the buttons are created
    // the labels are already constrained by the CGRects
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addConstraints()
    }
    
    
    // ------------------------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        if let playSounds = defaults.object(forKey: "playSound") as? Bool {
            playSound = playSounds
        } else {
            playSound = true
        }
        
        if (playSound) {
            bellButtonItem = UIBarButtonItem(image: UIImage(named: "bell-7"), style: .plain, target: self, action: #selector(bellTapped))
        } else {
            bellButtonItem = UIBarButtonItem(image: UIImage(named: "bell-off-7"), style: .plain, target: self, action: #selector(bellTapped))
        }
        
        navigationItem.rightBarButtonItem = bellButtonItem
        // Animate the labels to move in
        animateLabels()

    }
    
    // ------------------------------------------------------------------------------------------

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // ------------------------------------------------------------------------------------------
    
    func tappedIOSExperience(_ sender: Any) {
        buttonTapped = true
        performSegue(withIdentifier: "segueToIOS", sender: self)
        
    }
    
    // ------------------------------------------------------------------------------------------
    // if the user taps the facebook button, they will be redirected to my facebook
    
    func tappedFacebook(_ sender: Any) {
        buttonTapped = true
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
    // if the user taps the linkedIn button, they will be redirected to my linkedIn profile
    
    func tappedLinkedIn(_ sender: Any) {
        buttonTapped = true
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
    
    func tappedResume(_ sender: Any) {
        buttonTapped = true
        performSegue(withIdentifier: "segueToTab", sender: self)
    }
    
    // ------------------------------------------------------------------------------------------
    // animate the labels so that they move into the view
    
    func animateLabels() {

        // try to create my own sound object
        
        if (playSound) {
            if let url = URL(string: "/System/Library/Audio/UISounds/Swish.caf") {
                myAlertSound = 0
                AudioServicesCreateSystemSoundID(url as CFURL, &myAlertSound!)
                AudioServicesPlaySystemSound(myAlertSound!)
            }
        }
       
        UIView.animate(withDuration: 1, delay: 0, options: [], animations: { [unowned self] in self.jacobLabel.transform = CGAffineTransform(translationX: -self.view.frame.size.width, y: 0) }, completion: { [unowned self] _ in
            if let alertSound = self.myAlertSound {
                if !self.buttonTapped {
                    AudioServicesPlaySystemSound(alertSound)
                }
            }
        })
        
        UIView.animate(withDuration: 1, delay: 1, options: [], animations: { [unowned self] in self.taylorLabel.transform = CGAffineTransform(translationX: -self.view.frame.size.width, y: 0) }, completion: { [unowned self] _ in
            if let alertSound = self.myAlertSound {
                if !self.buttonTapped {
                    AudioServicesPlaySystemSound(alertSound)
                }
            }
        })
        
        UIView.animate(withDuration: 1, delay: 2, options: [], animations: { [unowned self] in self.landmanLabel.transform = CGAffineTransform(translationX: -self.view.frame.size.width, y: 0); AudioServicesPlaySystemSound(0) }, completion: nil)
        
        // now remove the sound object if it was created. We know it was created if the myAlertSound variable is not nil
        // we need to delay for 3 seconds to make sure the sounds have been played already
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) { [unowned self] in
            if let alertSound = self.myAlertSound {
                AudioServicesDisposeSystemSoundID(alertSound)
                print("AudioID was deleted")
            }
        }
    }
    
    // ------------------------------------------------------------------------------------------
    // create all the labels and offset them off the screen
    // they will be animated in when the view loads
    
    func makeLabels() {
        
        // the size of the screen is in points
        let sizeOfScreen: CGSize = UIScreen.main.bounds.size

        let xOffset: CGFloat = 20.0
        let yOffset: CGFloat = 30.0
        let viewWidth: CGFloat = sizeOfScreen.width
        let scaleFactor: CGFloat = 0.9
        
        let labelHeight: CGFloat = scaleFactor * 0.33 * ((0.33 * sizeOfScreen.height) - yOffset)
        
        let labelStartingPosition: CGFloat = labelHeight + yOffset
        
        jacobLabel = UILabel()
        jacobLabel.frame = CGRect(x: viewWidth + xOffset, y: labelStartingPosition, width: viewWidth, height: labelHeight)
        jacobLabel.text = "Jacob"
        jacobLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: labelHeight)
        view.addSubview(jacobLabel)
        
        taylorLabel = UILabel()
        taylorLabel.frame = CGRect(x: viewWidth + xOffset, y: labelStartingPosition + 1 * (labelHeight - 2), width: viewWidth, height: labelHeight)
        taylorLabel.text = "Taylor"
        taylorLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: labelHeight)
        view.addSubview(taylorLabel)
        
        landmanLabel = UILabel()
        landmanLabel.frame = CGRect(x: viewWidth + xOffset, y: labelStartingPosition + 2 * (labelHeight - 2), width: viewWidth, height: labelHeight)
        landmanLabel.text = "Landman"
        landmanLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: labelHeight)
        view.addSubview(landmanLabel)
    }
    
    // ------------------------------------------------------------------------------------------
    // add all the buttons to the view
    
    func makeButtons() {
        
        // make the buttons of type .system so that the text highlights when tapped
        
        iosButton = UIButton(type: .system) as UIButton
        iosButton.translatesAutoresizingMaskIntoConstraints = false
        iosButton.setTitle("  iOS Experience  ", for: .normal)
        iosButton.setTitleColor(self.view.tintColor, for: .normal)
        iosButton.addTarget(self, action: #selector(tappedIOSExperience(_:)), for: .touchUpInside)
        iosButton.layer.borderWidth = 1.0
        iosButton.layer.borderColor = self.view.tintColor.cgColor
        iosButton.layer.cornerRadius = 10
        view.addSubview(iosButton)
        
        facebookButton = UIButton(type: .system) as UIButton
        facebookButton.translatesAutoresizingMaskIntoConstraints = false
        facebookButton.setTitle("Facebook", for: .normal)
        facebookButton.setTitleColor(self.view.tintColor, for: .normal)
        facebookButton.addTarget(self, action: #selector(tappedFacebook(_:)), for: .touchUpInside)
        facebookButton.showsTouchWhenHighlighted = true
        facebookButton.layer.borderWidth = 1.0
        facebookButton.layer.borderColor = self.view.tintColor.cgColor
        facebookButton.layer.cornerRadius = 10
        view.addSubview(facebookButton)
        
        linkedinButton = UIButton(type: .system) as UIButton
        linkedinButton.translatesAutoresizingMaskIntoConstraints = false
        linkedinButton.setTitle("LinkedIn", for: .normal)
        linkedinButton.setTitleColor(self.view.tintColor, for: .normal)
        linkedinButton.addTarget(self, action: #selector(tappedLinkedIn(_:)), for: .touchUpInside)
        linkedinButton.showsTouchWhenHighlighted = true
        linkedinButton.layer.borderWidth = 1.0
        linkedinButton.layer.borderColor = self.view.tintColor.cgColor
        linkedinButton.layer.cornerRadius = 10
        view.addSubview(linkedinButton)
        
        resumeButton = UIButton(type: .system) as UIButton
        resumeButton.translatesAutoresizingMaskIntoConstraints = false
        let eAcute: Character = "\u{E9}"
        resumeButton.setTitle("Resum".appending(String(eAcute)), for: .normal)
        resumeButton.setTitleColor(self.view.tintColor, for: .normal)
        resumeButton.addTarget(self, action: #selector(tappedResume(_:)), for: .touchUpInside)
        resumeButton.showsTouchWhenHighlighted = true
        resumeButton.layer.borderWidth = 1.0
        resumeButton.layer.borderColor = self.view.tintColor.cgColor
        resumeButton.layer.cornerRadius = 10
        view.addSubview(resumeButton)
        
    }
    
    // ------------------------------------------------------------------------------------------
    // add all the constraints for the buttons and labels
    
    func addConstraints() {
        
        // the size of the screen is in points
        
        let offsetFromBottom: CGFloat = 60
        let distanceBetween: CGFloat = 20
        
        // iOS button constraints
        NSLayoutConstraint(item: resumeButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0.5 * view.frame.height).isActive = true
        NSLayoutConstraint(item: resumeButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0).isActive = true
        
        // facebook button constraints
        NSLayoutConstraint(item: facebookButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: facebookButton, attribute: .width, relatedBy: .equal, toItem: resumeButton, attribute: .width, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: facebookButton, attribute: .height, relatedBy: .equal, toItem: resumeButton, attribute: .height, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: facebookButton, attribute: .top, relatedBy: .equal, toItem: resumeButton, attribute: .bottom, multiplier: 1.0, constant: distanceBetween).isActive = true
        
        // linkedin button constraints
        NSLayoutConstraint(item: linkedinButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: linkedinButton, attribute: .width, relatedBy: .equal, toItem: resumeButton, attribute: .width, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: linkedinButton, attribute: .height, relatedBy: .equal, toItem: resumeButton, attribute: .height, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: linkedinButton, attribute: .top, relatedBy: .equal, toItem: facebookButton, attribute: .bottom, multiplier: 1.0, constant: distanceBetween).isActive = true
        
        // resume button constraints
        NSLayoutConstraint(item: iosButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: iosButton, attribute: .width, relatedBy: .equal, toItem: resumeButton, attribute: .width, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: iosButton, attribute: .height, relatedBy: .equal, toItem: resumeButton, attribute: .height, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: iosButton, attribute: .top, relatedBy: .equal, toItem: linkedinButton, attribute: .bottom, multiplier: 1.0, constant: distanceBetween).isActive = true
        NSLayoutConstraint(item: iosButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: -offsetFromBottom).isActive = true
    }
    
    // ------------------------------------------------------------------------------------------
    
    func bellTapped() {
        
        if (playSound) {
            print("turning sound off")
            bellButtonItem.image = UIImage(named: "bell-off-7")
            playSound = false
        } else {
            print("turning sound on")
            bellButtonItem.image = UIImage(named: "bell-7")
            playSound = true
        }
        
        let defaults = UserDefaults.standard
        defaults.set(playSound, forKey: "playSound")
        
    }
    
    // ------------------------------------------------------------------------------------------

}
