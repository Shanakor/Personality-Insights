//
//  MasterInsightsDetailViewController.swift
//  Personality Insights
//
//  Created by Niklas Rammerstorfer on 21.03.18.
//  Copyright © 2018 Niklas Rammerstorfer. All rights reserved.
//

import UIKit
import PersonalityInsightsV3

class MasterInsightsDetailViewController: UIViewController, InsightsLoadingViewControllerDelegate {

    // MARK: Constants

    struct SegueIdentifiers{
        static let LoadingViewController = "EmbedInsightsLoadingVC"
        static let DetailViewController = "EmbedInsightsDetailVC"
    }

    // MARK: IBOutlets

    @IBOutlet weak var loadingContainerView: UIView!
    @IBOutlet weak var detailContainerView: UIView!

    // MARK: Properties

    var transInsight: TransientInsight?
    var userName: String!
    private var loadingVC: InsightsLoadingViewController!
    private var detailVC: InsightsDetailViewController!

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        loadingVC.delegate = self

        if transInsight != nil{
            loadingContainerView.isHidden = true
            detailContainerView.isHidden = false
        }
        else{
            loadingVC.startDownloadRoutine()
        }
    }

    // MARK: Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueIdentifier = segue.identifier else{
            return
        }

        if segueIdentifier == SegueIdentifiers.LoadingViewController{
            loadingVC = segue.destination as! InsightsLoadingViewController
            loadingVC.userName = self.userName
        }
        else if segueIdentifier == SegueIdentifiers.DetailViewController{
            detailVC = segue.destination as! InsightsDetailViewController
        }
    }

    func navigateToDetailViewController(transientInsight: TransientInsight) {
        detailVC.transientInsight = transientInsight

        CustomTransitionController.transition(from: loadingContainerView, to: detailContainerView,
                animation: .rightToLeft, duration: 0.3)
    }
}

protocol InsightsLoadingViewControllerDelegate{
    func navigateToDetailViewController(transientInsight: TransientInsight)
}
