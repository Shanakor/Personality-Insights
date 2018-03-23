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
    private var session: TWTRSession?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        logInButton = TWTRLogInButton(logInCompletion: {
            session, error in

            self.session = session
        })

        stackView.addArrangedSubview(logInButton)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if session != nil{
            sessionStore.save(session!){
                session, error in

                self.navigationDelegate?.navigate(from: .twitterLoginScene, to: .insightsScene, animation: nil, completion: nil)
            }
        }
    }
}