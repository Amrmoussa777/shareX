//
//  AppDelegate.swift
//  sharex
//
//  Created by Amr Moussa on 18/11/2020.
//  Copyright © 2020 Amr Moussa. All rights reserved.
//

import UIKit
import Firebase


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
//        REGISTER FOR REMOTE NOTIFICATION
//        
//        UNUserNotificationCenter.current().delegate = self
//        
//        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
//        UNUserNotificationCenter.current().requestAuthorization(
//          options: authOptions) { _, _ in }
//        
//        application.registerForRemoteNotifications()
//        Messaging.messaging().delegate = self
    
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
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error)
    }
       
    


}

//extension AppDelegate: UNUserNotificationCenterDelegate {
//  func userNotificationCenter(
//    _ center: UNUserNotificationCenter,
//    willPresent notification: UNNotification,
//    withCompletionHandler completionHandler:
//    @escaping (UNNotificationPresentationOptions) -> Void
//  ) {
//    if #available(iOS 14.0, *) {
//        completionHandler([[.banner, .sound]])
//    } else {
//        // Fallback on earlier versions
//    }
//  }
//
//  func userNotificationCenter(_ center: UNUserNotificationCenter,didReceive response: UNNotificationResponse,
//    withCompletionHandler completionHandler: @escaping () -> Void) {
//    completionHandler()
//  }
//
//
//    func application(
//      _ application: UIApplication,
//      didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//      Messaging.messaging().apnsToken = deviceToken
//    }
//}
//
//
//extension AppDelegate: MessagingDelegate {
//  func messaging( _ messaging: Messaging,
//    didReceiveRegistrationToken fcmToken: String?) {
//    let tokenDict = ["token": fcmToken ?? ""]
////    WHEN EBER TOKEN CHANGED.
//    NotificationCenter.default.post(name: Notification.Name("FCMToken"),object: nil,userInfo: tokenDict)
//  }
//}
