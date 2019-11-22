//
//  AppDelegate.swift
//  DevigetTest
//
//  Created by Jorge Palacio on 22/11/19.
//  Copyright © 2019 Jorge Palacio. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        rootControllerSetup()

        return true
    }
    
    private func rootControllerSetup() {
        let wireFrame = MasterWireframe()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let splitController: UISplitViewController = storyboard.instantiateViewController(identifier: "InitialViewController")
        let presenter = MasterPresenter(repository: RedditTopRepository(), wireframe: wireFrame)
        for viewController in splitController.viewControllers {
            guard let navigation = viewController as? UINavigationController else {
                continue
            }
            
            navigation.viewControllers.forEach { controller in
                if let details = controller as? DetailsViewController {
                    
                } else if let master = controller as? MasterViewController {
                    master.presenter = presenter
                }
            }
        }
        window?.rootViewController = splitController
    }
}

