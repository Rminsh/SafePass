//
//  AppDelegate.swift
//  TossIt
//
//  Created by armin on 10/26/19.
//  Copyright © 2019 shalchian. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let defaults: UserDefaults = UserDefaults.standard
        if !defaults.bool(forKey: SettingsKeys.isNotFirstRun) {
            defaults.set(true, forKey: SettingsKeys.isNotFirstRun)
            defaults.set(true, forKey: SettingsKeys.includeNumbers)
            defaults.set(true, forKey: SettingsKeys.includePunctuation)
            defaults.set(false, forKey: SettingsKeys.includeSymbols)
            defaults.set(16, forKey: SettingsKeys.lenghtChar)
        }
        
        return true
    }

}

