//
// Created by Niklas Rammerstorfer on 15.03.18.
// Copyright (c) 2018 Niklas Rammerstorfer. All rights reserved.
//

import Foundation

struct TwitterAPIConstants {

    // I am openly displaying those keys in GitHub, as I do not think
    // that much bad can happen with only read access.
    struct Credentials{
        static let ConsumerKey = "YVM5z51oWOMSUzwz2IQeRe8jY"
        static let ConsumerSecret = "dk2mfiR2fOPaKQy0C7IL2aMc1VAuZIyWbiX5YYGMUwxeDSWMej"
    }

    struct EndPoints{
        static let Timeline = "https://api.twitter.com/1.1/statuses/user_timeline.json"
    }

    struct RequestParamKeys{
        static let UserID = "user_id"
    }

    struct TweetJsonKeys{
        static let Text = "text"
    }
}
