//
//  AppDelegate.swift
//  WeatherForecast
//
//  Created by Tha Le on 2/25/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = Navigator.shared.window
        window?.makeKeyAndVisible()
        Navigator.shared.showWeatherForecastScreen()
        return true
    }
}

