//
//  AppDelegate.swift
//  RIBsPractice
//
//  Created by YD on 5/14/24.
//

import UIKit
import RIBs

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    private var launchRouter: LaunchRouting?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        self.launchRouter = AppRootBuilder(dependency: AppComponent()).build()
        launchRouter?.launch(from: window)
        
        return true
    }
}

