//
//  InsightsTableViewController.swift
//  Personality Insights
//
//  Created by Niklas Rammerstorfer on 22.03.18.
//  Copyright © 2018 Niklas Rammerstorfer. All rights reserved.
//

import UIKit

class InsightsTableViewController: UIViewController {

    // MARK: IBOutlets
    
    @IBOutlet weak var tableView: UITableView!

    // MARK: Constants

    struct Identifiers{
        static let Cell = "insightsCell"
    }

    // MARK: Properties

    var navigationDelegate: InsightsTableViewControllerDelegate?
    var transInsights: [TransientInsight]!{
        didSet{
            tableView.reloadData()
        }
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension InsightsTableViewController: UITableViewDataSource, UITableViewDelegate{

    // MARK: DataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transInsights.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let insight = transInsights[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.Cell)!
        cell.textLabel?.text = insight.userName
        cell.detailTextLabel?.text = insight.dateString

        return cell
    }

    // MARK: Delegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationDelegate?.navigateToDetailVC(transInsight: transInsights[indexPath.row])
    }
}
