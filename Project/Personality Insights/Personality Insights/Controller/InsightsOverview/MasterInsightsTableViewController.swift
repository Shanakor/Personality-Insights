//
//  MasterInsightsTableViewController.swift
//  Personality Insights
//
//  Created by Niklas Rammerstorfer on 02.03.18.
//  Copyright © 2018 Niklas Rammerstorfer. All rights reserved.
//

import UIKit
import TwitterKit

class MasterInsightsTableViewController: UIViewController, EmptyTableViewControllerDelegate, InsightsTableViewControllerDelegate {

    // MARK: Constants

    struct SegueIdentifiers{
        static let EmptyTable = "EmbedEmptyTableVC"
        static let InsightsTable = "EmbedInsightsTableVC"
        static let MasterInsightDetail = "ShowMasterInsightDetailVC"
    }

    // MARK: IBOutlets

    @IBOutlet weak var emptyTableContainerView: UIView!
    @IBOutlet weak var tableContainerView: UIView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userInfoActivityIndicator: UIActivityIndicatorView!
    
    // MARK: Properties

    private var userName: String?
    private var selectedTransInsight: TransientInsight?
    private var emptyTableViewController: EmptyTableViewController!
    private var tableViewController: InsightsTableViewController!

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        loadUser()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        configureContainerViews()
    }

    private func configureContainerViews() {
        let insights = CoreDataStackFacade.shared.fetchAllInsightsAsync()
        let transInsights = TransientPersistentConversionBridge.toTransientInsights(insights)
        configureUI(areInsightsEmpty: insights.count == 0)
        tableViewController.transInsights = transInsights
    }

    private func loadUser() {
        let session = TWTRTwitter.sharedInstance().sessionStore.session()
        if let session = session{
            let client = TWTRAPIClient(userID: session.userID)
            client.loadUser(withID: session.userID){
                user, error in

                guard error == nil else{
                    print(error!)
                    return
                }

                self.userName = user!.name
                self.userNameLabel.text = self.userName
                self.userInfoActivityIndicator.stopAnimating()
                self.userNameLabel.isHidden = false
            }
        }
    }

    // MARK: UI Methods

    private func configureUI(areInsightsEmpty: Bool){
        tableContainerView.isHidden = areInsightsEmpty
        emptyTableContainerView.isHidden = !areInsightsEmpty
    }

    // MARK: IBActions

    @IBAction func startAnalysis() {
        performSegue(withIdentifier: SegueIdentifiers.MasterInsightDetail, sender: nil)
    }

    func navigateToDetailVC(transInsight: TransientInsight) {
        selectedTransInsight = transInsight
        performSegue(withIdentifier: SegueIdentifiers.MasterInsightDetail, sender: nil)
    }

    // MARK: Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else{
            return
        }

        switch(identifier){
            case SegueIdentifiers.EmptyTable:
                emptyTableViewController = segue.destination as! EmptyTableViewController
                emptyTableViewController.navigationDelegate = self
            case SegueIdentifiers.InsightsTable:
                tableViewController = segue.destination as! InsightsTableViewController
                tableViewController.navigationDelegate = self
            case SegueIdentifiers.MasterInsightDetail:
                let destVc = segue.destination as! MasterInsightsDetailViewController
                destVc.userName = self.userName
                destVc.transInsight = selectedTransInsight
            default: break
        }
    }
}

protocol EmptyTableViewControllerDelegate{
    func startAnalysis()
}

protocol InsightsTableViewControllerDelegate{
    func navigateToDetailVC(transInsight: TransientInsight)
}
