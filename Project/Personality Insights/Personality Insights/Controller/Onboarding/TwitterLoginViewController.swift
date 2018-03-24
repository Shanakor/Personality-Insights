//
//  TwitterLoginViewController.swift
//  Personality Insights
//
//  Created by Niklas Rammerstorfer on 10.03.18.
//  Copyright © 2018 Niklas Rammerstorfer. All rights reserved.
//

import UIKit
import TwitterKit

class TwitterLoginViewController: UIViewController {

    // MARK: IBOutlets
    
    @IBOutlet weak var stackView: UIStackView!
    
    // MARK: Properties

    var navigationDelegate: OnboardingNavigationDelegate?
    private var sessionStore = TWTRTwitter.sharedInstance().sessionStore
    private var logInButton: TWTRLogInButton!

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        logInButton = TWTRLogInButton(logInCompletion: loginCompletion)
        stackView.addArrangedSubview(logInButton)
    }

    // MARK: Navigation

    lazy var loginCompletion: TWTRLogInCompletion = {
        session, error in

        self.sessionStore.save(session!){
            session, error in

            DispatchQueue.main.async {
                self.navigationDelegate?.navigate(from: .twitterLoginScene, to: .insightsScene, animation: nil, completion: nil)
            }
        }
    }
}
