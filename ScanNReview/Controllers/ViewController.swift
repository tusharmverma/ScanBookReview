//
//  ViewController.swift
//  Scan n Review
//
//  Created by Tushar  Verma on 7/28/18.
//  Copyright © 2018 Tushar Verma. All rights reserved.
//

import UIKit
import Foundation
import BubbleTransition

class ViewController: UIViewController, UIViewControllerTransitioningDelegate{

    @IBOutlet weak var transitionButton: UIButton!
    @IBOutlet weak var logoTitle: UILabel!
    
    // Variables
    
    // MARK: - Properties
    
    let photoHelper = MGPhotoHelper()
    let transition = BubbleTransition()
    
    @IBOutlet weak var tutorialButton: UIButton!
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination
        controller.transitioningDelegate = self
        controller.modalPresentationStyle = .custom
    }
    
    // MARK: UIViewControllerTransitioningDelegate
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = transitionButton.center
        //transition.bubbleColor = transitionButton.backgroundColor!
        return transition
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = transitionButton.center
        transition.bubbleColor = transitionButton.backgroundColor!
        return transition
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientForHomeScreenBackground(colorOne: Colors.kindaOrange, colorTwo: Colors.kindaPurple)
        
        logoTitle.adjustsFontSizeToFitWidth = true
        logoTitle.minimumScaleFactor = 0.2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }

    @IBAction func tutorialButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toTutorialsMenu", sender: self)
    }
    
    
}




