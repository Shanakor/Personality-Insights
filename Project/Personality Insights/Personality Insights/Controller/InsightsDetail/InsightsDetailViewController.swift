//
//  InsightsDetailViewController.swift
//  Personality Insights
//
//  Created by Niklas Rammerstorfer on 13.03.18.
//  Copyright © 2018 Niklas Rammerstorfer. All rights reserved.
//

import UIKit
import PersonalityInsightsV3

class InsightsDetailViewController: UIViewController {

    // MARK: IBOutlets
    
    @IBOutlet weak var agreeablenessLabel: UILabel!
    @IBOutlet weak var agreeablenessProgressView: UIProgressView!
    @IBOutlet weak var conscientiousnessLabel: UILabel!
    @IBOutlet weak var conscientiousnessProgessView: UIProgressView!
    @IBOutlet weak var opennessLabel: UILabel!
    @IBOutlet weak var opennessProgressView: UIProgressView!
    @IBOutlet weak var emotionalRangeLabel: UILabel!
    @IBOutlet weak var emotionalRangeProgessView: UIProgressView!
    @IBOutlet weak var introversionExtraversionLabel: UILabel!
    @IBOutlet weak var introversionExtraversionProgressView: UIProgressView!
    
    // MARK: Properties

    var transientInsight: TransientInsight!{
        didSet {
            configureUI(using: transientInsight)
        }
    }

    private func configureUI(using transInsight: TransientInsight) {
        agreeablenessLabel.text = transInsight.agreeablenessPercentileText
        agreeablenessProgressView.progress = Float(transInsight.agreeablenessPercentile)

        conscientiousnessLabel.text = transInsight.conscientiousnessPercentileText
        conscientiousnessProgessView.progress = Float(transInsight.conscientiousnessPercentile)

        opennessLabel.text = transInsight.opennessPercentileText
        opennessProgressView.progress = Float(transInsight.opennessPercentile)

        emotionalRangeLabel.text = transInsight.emotionalRangePercentileText
        emotionalRangeProgessView.progress = Float(transInsight.emotionalRangePercentile)

        introversionExtraversionLabel.text = transInsight.introversionExtraversionPercentileText
        introversionExtraversionProgressView.progress = Float(transInsight.introversionExtraversionPercentile)
    }
}
