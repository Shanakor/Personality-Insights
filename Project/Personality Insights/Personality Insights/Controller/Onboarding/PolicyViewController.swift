//
//  PolicyViewController.swift
//  Personality Insights
//
//  Created by Niklas Rammerstorfer on 02.03.18.
//  Copyright © 2018 Niklas Rammerstorfer. All rights reserved.
//

import UIKit

class PolicyViewController: UIViewController {

    // MARK: IBOutlets

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    
    // MARK: Properties

    var navigationDelegate: OnboardingNavigationDelegate?

    // MARK: Navigation

    @IBAction func navigateToTwitterLoginScene() {
        navigationDelegate?.navigate(from: .policyScene, to: .twitterLoginScene, animation: .rightToLeft, completion: nil)
    }

    @IBAction func navigateToWelcomeScene() {
        navigationDelegate?.navigate(from: .policyScene, to: .welcomeScene, animation: .leftToRight, completion: nil)
    }
}
