//
//  WelcomeViewController.swift
//  Personality Insights
//
//  Created by Niklas Rammerstorfer on 02.03.18.
//  Copyright © 2018 Niklas Rammerstorfer. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    // MARK: IBOutlets

    @IBOutlet weak var nextButton: UIButton!

    // MARK: Properties

    var navigationDelegate: OnboardingNavigationDelegate?

    // MARK: Navigation
    
    @IBAction func navigateToPolicyScene() {
        navigationDelegate?.navigate(from: .welcomeScene, to: .policyScene, animation: .rightToLeft, completion: nil)
    }
}
