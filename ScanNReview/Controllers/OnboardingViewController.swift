//
//  OnboardingViewController.swift
//  ScanNReview
//
//  Created by Tushar  Verma on 8/4/18.
//  Copyright © 2018 Tushar Verma. All rights reserved.
//

import UIKit
import paper_onboarding

class OnboardingViewController: UIViewController {
    
    private static let titleFont = UIFont(name: "Nunito-Bold", size: 36.0) ?? UIFont.boldSystemFont(ofSize: 36.0)
    private static let descriptionFont = UIFont(name: "OpenSans-Regular", size: 14.0) ?? UIFont.systemFont(ofSize: 14.0)

    @IBOutlet weak var skipButton: UIButton!
    
    
    //Variables
    var userData = UserDefaults.standard
    
    fileprivate let items = [
        OnboardingItemInfo(informationImage:#imageLiteral(resourceName: "logoBook"),
                           title: "Get Started",
                           description: "Steps to get book reviews",
                           pageIcon: #imageLiteral(resourceName: "Shopping-cart") ,
                           color: UIColor(red:0.95, green:0.36, blue:0.36, alpha:1.0),
                           titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
        
        OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "search"),
                           title: "Take a picture",
                           description: "Using the camera take a snapshot of books ISBN number and barcode",
                           pageIcon: #imageLiteral(resourceName: "Key"),
                           color: UIColor(red:0.16, green:0.09, blue:0.45, alpha:1.0),
                           titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
        
        OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "result"),
                           title: "Get results",
                           description: "After taking a pic you will be provided with reviews helping you make the choice of whether to buy/read the book",
                           pageIcon: #imageLiteral(resourceName: "Wallet"),
                           color: UIColor(red:0.95, green:0.02, blue:0.45, alpha:1.0),
                           titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
        
        ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        skipButton.isHidden = true
        
        setupPaperOnboardingView()
        
        view.bringSubview(toFront: skipButton)

        // Do any additional setup after loading the view.
    }

    private func setupPaperOnboardingView() {
        let onboarding = PaperOnboarding()
        onboarding.delegate = self
        onboarding.dataSource = self
        onboarding.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(onboarding)
        
        // Add constraints
        for attribute: NSLayoutAttribute in [.left, .right, .top, .bottom] {
            let constraint = NSLayoutConstraint(item: onboarding,
                                                attribute: attribute,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: attribute,
                                                multiplier: 1,
                                                constant: 0)
            view.addConstraint(constraint)
        }
    }
    
    //Actions
    @IBAction func skipButtonPressed(_ sender: UIButton) {
        userData.set(true, forKey: "OnboardingCompleted")
        userData.synchronize()
    }
}

extension OnboardingViewController {
    
    @IBAction func skipButtonTapped(_: UIButton) {
        print(#function)
    }
}

// MARK: PaperOnboardingDelegate

extension OnboardingViewController: PaperOnboardingDelegate {
    
    func onboardingWillTransitonToIndex(_ index: Int) {
        skipButton.isHidden = index == 2 ? false : true
    }
    
    func onboardingDidTransitonToIndex(_: Int) {
    }
    
    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
    }
}

// MARK: PaperOnboardingDataSource

extension OnboardingViewController: PaperOnboardingDataSource {
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        return items[index]
    }
    
    func onboardingItemsCount() -> Int {
        return 3
    }
}






