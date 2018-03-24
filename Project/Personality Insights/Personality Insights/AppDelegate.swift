//
//  AppDelegate.swift
//  Personality Insights
//
//  Created by Niklas Rammerstorfer on 24.01.18.
//  Copyright © 2018 Niklas Rammerstorfer. All rights reserved.
//

import UIKit
import TwitterKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let userDefaults = UserDefaults(suiteName: "productionUserDefaults")!
    let coreDataStack = CoreDataStack(modelName: "Model")!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        swapInitialViewControllerToOnboardingIfNeeded()
        
        TWTRTwitter.sharedInstance().start(withConsumerKey: TwitterAPIConstants.Credentials.ConsumerKey,
                                           consumerSecret: TwitterAPIConstants.Credentials.ConsumerSecret)
        
        return true
    }
    
    private func swapInitialViewControllerToOnboardingIfNeeded() {
        if let onboardingRequiredObject = userDefaults.object(forKey: OnboardingViewController.UserDefaultKeys.OnboardingRequired),
            let onboardingRequired = onboardingRequiredObject as? Bool,
            onboardingRequired == false{
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "InsightsNavigationController")
            
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        
        do {
            try coreDataStack.saveMainContext()
        } catch {
            print("Error while saving.")
        }
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        do {
            try coreDataStack.saveMainContext()
        } catch {
            print("Error while saving.")
        }
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return TWTRTwitter.sharedInstance().application(app, open: url, options: options)
    }
}
