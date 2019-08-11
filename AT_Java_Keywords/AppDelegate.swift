//
//  AppDelegate.swift
//  AT_Java_Keywords
//
//  Created by Carlos Henrique on 06/08/19.
//  Copyright © 2019 Carlos Henrique. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var quizFlowController: QuizFlowController?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        handleFirstPresentation()
        return true
    }

    private func handleFirstPresentation() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController()
        guard let navigationController = window?.rootViewController as? UINavigationController else { return }
        navigationController.navigationBar.isHidden = true
        
        
        presentQuizChallenge(from: navigationController)
        window?.makeKeyAndVisible()
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension AppDelegate {
    
    // MARK: - Present Words Quiz Challenge
    private func presentQuizChallenge(from navigationController: UINavigationController) {
        quizFlowController = QuizFlowController(navigationController: navigationController, quizFactory: self)
        quizFlowController?.delegate = self
        quizFlowController?.start()
    }

}

extension AppDelegate: QuizFactory {
    func makeWordsQuiz() -> WordsViewController {
        let viewModel = WordsViewModel()
        return WordsViewController(viewModel: viewModel)
    }
}

extension AppDelegate: QuizFlowControllerDelegate { }
