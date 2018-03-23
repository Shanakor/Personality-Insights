//
// Created by Niklas Rammerstorfer on 21.03.18.
// Copyright (c) 2018 Niklas Rammerstorfer. All rights reserved.
//

import Foundation
import PersonalityInsightsV3

class WatsonAPIController {

    static func feedWatson(with tweets: [Tweet], completion: @escaping (Profile?, Error?) -> Void){
        let personalityInsights = PersonalityInsights(username: WatsonAPIConstants.Credentials.Username,
                password: WatsonAPIConstants.Credentials.Password, version: WatsonAPIConstants.MetaInfo.Version)

        let failure = { error in completion(nil, error)}
        let tweetTexts = tweets.map{ tweet in tweet.text}.joined(separator: "\n")

        personalityInsights.profile(text: tweetTexts, failure: failure){
            profile in

            completion(profile, nil)
        }
    }
}
