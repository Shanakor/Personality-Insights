//
//  EmptyTableViewController.swift
//  Personality Insights
//
//  Created by Niklas Rammerstorfer on 02.03.18.
//  Copyright © 2018 Niklas Rammerstorfer. All rights reserved.
//

import UIKit
import TwitterKit

class EmptyTableViewController: UIViewController {

    // MARK: Constants

    struct ButtonColors{
        static let Enabled = "#7ED321"
        static let Disabled = "#E3E3E3"
    }

    // MARK: IBOutlets
    
    @IBOutlet weak var startFirstAnalysisButton: UIButton!
    
    // MARK: Properties

    var navigationDelegate: EmptyTableViewControllerDelegate?

    // MARK: IBActions

    @IBAction func startFirstAnalysis(){
        navigationDelegate?.startAnalysis()
    }

    func configureUI(isUserLoaded: Bool) {
        startFirstAnalysisButton.isEnabled = isUserLoaded
        startFirstAnalysisButton.backgroundColor = isUserLoaded ? UIColor(hex: ButtonColors.Enabled) : UIColor(hex: ButtonColors.Disabled)
    }
}
