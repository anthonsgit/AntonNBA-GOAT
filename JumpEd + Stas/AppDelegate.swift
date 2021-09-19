//
//  AppDelegate.swift
//  JumpEd + Stas
//
//  Created by Stanislav Frolov on 30.08.2021.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if var directory: URL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.oak.scp") {
            directory.appendPathComponent("db.realm", isDirectory: true)
            var config = Realm.Configuration()
            config.fileURL = directory
            Realm.Configuration.defaultConfiguration = config
          //  let clear = Realm.Configuration.defaultConfiguration.deleteRealmIfMigrationNeeded = true
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

