//
// Created by Niklas Rammerstorfer on 06.01.18.
// Copyright (c) 2018 Niklas Rammerstorfer. All rights reserved.
//

import Foundation
import CoreData

class TransientPersistentConversionBridge {

    // MARK: TransientInsight

    static func toTransientInsight(_ insight: Insight) -> TransientInsight{
        return TransientInsight(opennessPercentile: insight.opennessPercentile,
                agreeablenessPercentile: insight.agreeablenessPercentile,
                introversionExtraversionPercentile: insight.introversionExtraversionPercentile,
                conscientiousnessPercentile: insight.conscientiousnessPercentile,
                emotionalRangePercentile: insight.emotionalRangePercentile,
                userName: insight.userName!,
                date: Date(timeIntervalSince1970: insight.date!.timeIntervalSince1970))
    }

    static func toTransientInsights(_ insights: [Insight]) -> [TransientInsight]{
        var transInsights = [TransientInsight]()

        for insight in insights{
            transInsights.append(toTransientInsight(insight))
        }

        return transInsights
    }

    // MARK: Insight

    static func toInsight(_ transientInsight: TransientInsight, context: NSManagedObjectContext) -> Insight{
        return Insight(from: transientInsight, context: context)
    }
}
