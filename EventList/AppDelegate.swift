//
//  AppDelegate.swift
//  EventList
//
//  Created by Mathieu LANOY on 11/01/2017.
//  Copyright © 2017 Mathieu LANOY. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        
        initApp()
        
        window?.makeKeyAndVisible()
        return true
    }

    func initApp() {
        let sharedWebservice = Webservice()
        let loadingController = LoadingEventsViewController.instantiate().load({ (callback) in
            sharedWebservice.load(resource:EventModel.all, completion: callback)
        }) { (events) -> UIViewController in
            let controller = EventsViewController.instantiate()
            controller.configure(events)
            return controller
        }
        window?.rootViewController = loadingController
    }
}

