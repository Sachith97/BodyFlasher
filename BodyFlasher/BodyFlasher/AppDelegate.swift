//
//  AppDelegate.swift
//  BodyFlasher
//
//  Created by Sachith Harshamal on 2023-05-07.
//

import UIKit
import HealthKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let healthStore = HKHealthStore()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        requestHealthKitAuthorization()
        
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

    func requestHealthKitAuthorization() {
        if (!checkAuthorizationStatus()) {
            // check if heart rate data is available on the device
            guard HKHealthStore.isHealthDataAvailable() else {
                print("Heart rate data is not available.")
                return
            }
            // define the heart rate type
            guard let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate) else {
                print("Unable to create heart rate type.")
                return
            }
            // request authorization to access heart rate data
            healthStore.requestAuthorization(toShare: nil, read: [heartRateType]) { (success, error) in
                if success {
                    print("Authorization granted for heart rate data.")
                } else {
                    print("Authorization denied for heart rate data.")
                }
            }
        }
    }
    
    func checkAuthorizationStatus() -> Bool {
        let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate)!

        let authorizationStatus = healthStore.authorizationStatus(for: heartRateType)
        switch authorizationStatus {
        case .notDetermined:
            return false
        case .sharingDenied:
            // handle authorization denied case - consider as action given
            return true
        case .sharingAuthorized:
            // heart rate data access already authorized
            return true
        default:
            return false
        }
    }
}

