//
//  AppDelegate.swift
//  Midia
//
//  Created by Julio Martínez Ballester on 2/25/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard let homeViewController = window?.rootViewController as? HomeViewController else {
            fatalError("Wrong initial setup")
        }

        homeViewController.mediaItems = [Book(bookId: "1", title: "Primer book"), Book(bookId: "2", title: "Second book"), Game(), Game()]
        return true
    }

}

