//
// Created by Niklas Rammerstorfer on 22.03.18.
// Copyright (c) 2018 Niklas Rammerstorfer. All rights reserved.
//

import Foundation

struct NetworkErrorConstants {
    struct  TweetDownloading{
        static let Title = "Tweet Network Error"
        static let Message = "Something went wrong while download your tweets."
    }

    struct  TweetUserLoading{
        static let Title = "Tweet Network Error"
        static let Message = "Something went wrong while loading your user info."
    }

    struct Watson{
        static let Title = "Watson Network Error"
        static let Message = "Something went wrong while feeding Watson."
    }
}
