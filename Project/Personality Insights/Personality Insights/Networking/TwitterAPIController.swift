//
// Created by Niklas Rammerstorfer on 20.03.18.
// Copyright (c) 2018 Niklas Rammerstorfer. All rights reserved.
//

import Foundation
import TwitterKit

class TwitterAPIController {

    static func downloadTweets(userID: String, completion: @escaping ([Tweet]?, Error?) -> Void){
        let client = TWTRAPIClient(userID: userID)
        let params = [TwitterAPIConstants.RequestParamKeys.UserID: userID]
        var clientError : NSError?
        let request = client.urlRequest(withMethod: "GET", urlString: TwitterAPIConstants.EndPoints.Timeline, parameters: params, error: &clientError)

        client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
            guard connectionError == nil else{
                completion(nil, connectionError)
                return
            }

            do {
                let jsonDicts = try JSONSerialization.jsonObject(with: data!, options: []) as! [[String: Any]]
                completion(Tweet.tweets(fromDicts: jsonDicts), nil)
            } catch let jsonError as NSError {
                print("json error: \(jsonError.localizedDescription)")
            }
        }
    }
}
