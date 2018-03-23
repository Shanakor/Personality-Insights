//
//  InsightsLoadingViewController.swift
//  Personality Insights
//
//  Created by Niklas Rammerstorfer on 16.03.18.
//  Copyright © 2018 Niklas Rammerstorfer. All rights reserved.
//

import UIKit
import TwitterKit
import PersonalityInsightsV3

class InsightsLoadingViewController: UIViewController {

    // MARK: IBOutlets
    
    @IBOutlet weak var tweetsActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var watsonActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tweetCheckmark: UIImageView!
    @IBOutlet weak var watsonCheckmark: UIImageView!
    
    // MARK: Properties

    var userName: String!
    var delegate: InsightsLoadingViewControllerDelegate?
    private let coreDataStackFacade = CoreDataStackFacade.shared

    // MARK: Download Routine

    func startDownloadRoutine() {
        downloadTweets{
            tweets, error in

            guard error == nil else{
                self.presentAlertDialogForTweetDownloadingError(error: error!)
                return
            }

            DispatchQueue.main.async{
                self.setUIToTweetStepFinished()
            }

            self.feedWatson(with: tweets!){
                profile, error in

                guard error == nil else{
                    self.presentAlertDialogForWatsonError(error: error!)
                    return
                }

                let transientInsight = TransientInsight(from: profile!, userName: self.userName, date: Date())
                self.persistProfileAsync(transientInsight: transientInsight)

                DispatchQueue.main.async {
                    self.setUIToWatsonStepFinished()
                    self.delegate?.navigateToDetailViewController(transientInsight: transientInsight)
                }
            }
        }
    }

    private func feedWatson(with tweets: [Tweet], completion: @escaping (Profile?, Error?) -> Void) {
        WatsonAPIController.feedWatson(with: tweets, completion: completion)
    }

    private func downloadTweets(completion: @escaping ([Tweet]?, Error?) -> Void) {
        if let session = TWTRTwitter.sharedInstance().sessionStore.session(){
            TwitterAPIController.downloadTweets(userID: session.userID, completion: completion)
        }
    }

    // MARK: Error Handling

    private func presentAlertDialogForTweetDownloadingError(error: Error) {
        let alertController = UIAlertController(title: NetworkErrorConstants.TweetDownloading.Title,
                message: NetworkErrorConstants.TweetDownloading.Message + "\n\(error.localizedDescription)",
                preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: {
            action in

            self.dismiss(animated: true)
        }))

        self.present(alertController, animated: true)
    }

    private func presentAlertDialogForWatsonError(error: Error) {
        let alertController = UIAlertController(title: NetworkErrorConstants.Watson.Title,
                message: error.localizedDescription,
                preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: {
            action in

            self.dismiss(animated: true)
        }))

        self.present(alertController, animated: true)
    }

    // MARK: UI methods

    private func setUIToTweetStepFinished() {
        self.tweetsActivityIndicator.stopAnimating()
        self.tweetCheckmark.isHidden = false
    }

    private func setUIToWatsonStepFinished() {
        self.watsonActivityIndicator.stopAnimating()
        self.watsonCheckmark.isHidden = false
    }

    // MARK: Persistence

    private func persistProfileAsync(transientInsight: TransientInsight) {
        coreDataStackFacade.performBackgroundBatchOperation{
            context in

            let _ = TransientPersistentConversionBridge.toInsight(transientInsight, context: context)
            self.coreDataStackFacade.saveBackgroundContext()
        }
    }
}
