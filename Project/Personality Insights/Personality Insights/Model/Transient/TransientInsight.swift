//
// Created by Niklas Rammerstorfer on 22.03.18.
// Copyright (c) 2018 Niklas Rammerstorfer. All rights reserved.
//

import Foundation
import PersonalityInsightsV3

struct TransientInsight {

    // MARK: Constants

    struct ProfilePersonalityKeys {
        static let Agreeableness = "Agreeableness"
        static let Conscientiousness = "Conscientiousness"
        static let Openness = "Openness"
        static let EmotionalRange = "Emotional range"
        static let IntroversionExtraversion = "Extraversion"
    }

    private var dateFormatter: DateFormatter{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"

        return dateFormatter
    }

    // MARK: Properties

    private(set) var opennessPercentile: Double
    private(set) var agreeablenessPercentile: Double
    private(set) var introversionExtraversionPercentile: Double
    private(set) var conscientiousnessPercentile: Double
    private(set) var emotionalRangePercentile: Double
    private(set) var userName: String
    private(set) var date: Date

    // MARK: Initialization

    init(opennessPercentile: Double, agreeablenessPercentile: Double, introversionExtraversionPercentile: Double,
         conscientiousnessPercentile: Double, emotionalRangePercentile: Double, userName: String, date: Date){

        self.opennessPercentile = opennessPercentile
        self.agreeablenessPercentile = agreeablenessPercentile
        self.introversionExtraversionPercentile = introversionExtraversionPercentile
        self.conscientiousnessPercentile = conscientiousnessPercentile
        self.emotionalRangePercentile = emotionalRangePercentile
        self.userName = userName
        self.date = date
    }

    init(from profile: Profile, userName: String, date: Date){
        let traits = profile.personality

        let agreeablenessTrait = traits[traits.index(where: {$0.name == ProfilePersonalityKeys.Agreeableness})!]
        let agreeablenessPercentile = agreeablenessTrait.percentile

        let conscientiousnessTrait = traits[traits.index(where: {$0.name == ProfilePersonalityKeys.Conscientiousness})!]
        let conscientiousnessPercentile = conscientiousnessTrait.percentile

        let opennessTrait = traits[traits.index(where: {$0.name == ProfilePersonalityKeys.Openness})!]
        let opennessPercentile = opennessTrait.percentile

        let emotionalRangeTrait = traits[traits.index(where: {$0.name == ProfilePersonalityKeys.EmotionalRange})!]
        let emotionalRangePercentile = emotionalRangeTrait.percentile

        let introversionExtraversionTrait = traits[traits.index(where: {$0.name == ProfilePersonalityKeys.IntroversionExtraversion})!]
        let introversionExtraversionPercentile = introversionExtraversionTrait.percentile

        self.init(opennessPercentile: opennessPercentile, agreeablenessPercentile: agreeablenessPercentile,
                introversionExtraversionPercentile: introversionExtraversionPercentile, conscientiousnessPercentile: conscientiousnessPercentile,
                emotionalRangePercentile: emotionalRangePercentile, userName: userName, date: date)
    }

    // MARK: Convenience Properties

    private func percentileText(percentile: Double) -> String{
        return String(Int(round(percentile * 100))) + "%"
    }

    var agreeablenessPercentileText: String{
        return percentileText(percentile: agreeablenessPercentile)
    }

    var conscientiousnessPercentileText: String{
        return percentileText(percentile: conscientiousnessPercentile)
    }

    var opennessPercentileText: String{
        return percentileText(percentile: opennessPercentile)
    }

    var emotionalRangePercentileText: String{
        return percentileText(percentile: emotionalRangePercentile)
    }

    var introversionExtraversionPercentileText: String{
        return percentileText(percentile: introversionExtraversionPercentile)
    }

    var dateString: String{
        return dateFormatter.string(from: self.date)
    }
}
