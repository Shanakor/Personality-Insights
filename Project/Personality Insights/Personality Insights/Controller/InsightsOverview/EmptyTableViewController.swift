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

    // MARK: IBOutlets
    
    @IBOutlet weak var startFirstAnalysisButton: UIButton!
    
    // MARK: Properties

    var navigationDelegate: EmptyTableViewControllerDelegate?

    // MARK: IBActions

    @IBAction func startFirstAnalysis(){
        navigationDelegate?.startAnalysis()
    }
}
