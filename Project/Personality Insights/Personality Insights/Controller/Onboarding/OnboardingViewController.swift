//
//  OnboardingViewController.swift
//  Personality Insights
//
//  Created by Niklas Rammerstorfer on 02.03.18.
//  Copyright © 2018 Niklas Rammerstorfer. All rights reserved.
//

import UIKit

enum OnboardingScene: String{
    case twitterLoginScene = "TwitterLoginScene"
    case welcomeScene = "WelcomeScene"
    case policyScene = "PolicyScene"
    case insightsScene = "InsightsScene"
}

enum TransitionAnimation{
    case rightToLeft
    case leftToRight
}

class OnboardingViewController: UIViewController, OnboardingNavigationDelegate {

    // MARK: Constants

    struct Identifiers {
        struct Segue {
            static let WelcomeViewController = "EmbedWelcomeVC"
            static let PolicyViewController = "EmbedPolicyVC"
            static let TwitterLoginViewController = "EmbedTwitterLoginVC"
        }

        struct ViewController{
            static let InsightsNavigationController = "InsightsNavigationController"
        }
    }

    struct UserDefaultKeys{
        static let OnboardingRequired = "OnboardingRequired"
        static let OnboardingScene = "OnboardingScene"
    }

    // MARK: IBOutlets
    
    @IBOutlet weak var welcomeContainerView: UIView!
    @IBOutlet weak var policyContainerView: UIView!
    @IBOutlet weak var twitterLoginContainerView: UIView!
    
    // MARK: Properties

    private var welcomeViewController: WelcomeViewController!
    private var policyViewController: PolicyViewController!
    private var twitterLoginViewController: TwitterLoginViewController!
    private var userDefaults = (UIApplication.shared.delegate as! AppDelegate).userDefaults

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        restoreLastViewedOnboardingScene()
    }

    private func restoreLastViewedOnboardingScene() {
        if let onboardingSceneString = userDefaults.string(forKey: UserDefaultKeys.OnboardingScene),
           let onboardingScene = OnboardingScene(rawValue: onboardingSceneString){

            policyContainerView.isHidden = true
            welcomeContainerView.isHidden = true
            twitterLoginContainerView.isHidden = true
            containerView(matching: onboardingScene)!.isHidden = false
        }
    }

    // MARK: Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else{
            return
        }

        switch(identifier){
            case Identifiers.Segue.WelcomeViewController:
                self.welcomeViewController = segue.destination as! WelcomeViewController
                self.welcomeViewController.navigationDelegate = self
            case Identifiers.Segue.PolicyViewController:
                self.policyViewController = segue.destination as! PolicyViewController
                self.policyViewController.navigationDelegate = self
            case Identifiers.Segue.TwitterLoginViewController:
                self.twitterLoginViewController = segue.destination as! TwitterLoginViewController
                self.twitterLoginViewController.navigationDelegate = self
            default:
                return
        }
    }

    func navigate(from originScene: OnboardingScene, to destinationScene: OnboardingScene, animation: TransitionAnimation?, completion: (() -> Void)? = nil) {
        let originContainerView = containerView(matching: originScene)
        let destinationContainerView = containerView(matching: destinationScene)

        if originContainerView != nil && destinationContainerView != nil{
            CustomTransitionController.transition(from: originContainerView!, to: destinationContainerView!, animation: animation!, duration: 0.3, completion: {completion?()})
            userDefaults.set(destinationScene.rawValue, forKey: UserDefaultKeys.OnboardingScene)
        }
        else{
            userDefaults.removeObject(forKey: UserDefaultKeys.OnboardingScene)
            userDefaults.set(false, forKey: UserDefaultKeys.OnboardingRequired)
            presentInsightsViewController()
        }
    }

    private func presentInsightsViewController() {
        // For some reason sometimes when I present the ViewController using #presentSegueWithIdentifier it does not work.
        // I get the warning "attempt to present NavigationController on NavigationController whose view is not in the view hierarchy.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: Identifiers.ViewController.InsightsNavigationController)

        present(vc, animated: true)
    }

    private func containerView(matching scene: OnboardingScene) -> UIView?{
        switch(scene){
            case .welcomeScene:
                return welcomeContainerView
            case .policyScene:
                return policyContainerView
            case .twitterLoginScene:
                return twitterLoginContainerView
            default:
                return nil
        }
    }
}

protocol OnboardingNavigationDelegate{
    func navigate(from originScene: OnboardingScene, to destinationScene: OnboardingScene, animation: TransitionAnimation?, completion: (() -> Void)?)
}
