//
// Created by Niklas Rammerstorfer on 16.03.18.
// Copyright (c) 2018 Niklas Rammerstorfer. All rights reserved.
//

import Foundation

struct Tweet {
    private(set) var text: String

    init?(dict: [String: Any]){
        guard let text = dict[TwitterAPIConstants.TweetJsonKeys.Text] as? String else{
            return nil
        }

        self.text = text
    }

    static func tweets(fromDicts dicts: [[String: Any]]) -> [Tweet] {
        var tweets = [Tweet]()

        for dict in dicts{
            if let tweet = Tweet(dict: dict) {
                tweets.append(tweet)
            }
        }

        return tweets
    }
}
