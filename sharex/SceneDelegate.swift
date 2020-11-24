//
//  SceneDelegate.swift
//  sharex
//
//  Created by Amr Moussa on 18/11/2020.
//  Copyright © 2020 Amr Moussa. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


  
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        configureNavigationBar()
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = createTabbar()
        window?.makeKeyAndVisible()
        
    
        
        
    }

    func createTabbar() -> UITabBarController{
        let tabbar = UITabBarController()
        UITabBar.appearance().tintColor = .systemOrange
        tabbar.viewControllers = [createHomeNC(),createGroupNC(),createMessageNC(),createProfileNC()]
        
        return tabbar
            
    }
    
    func createHomeNC() -> UINavigationController {
        let homeVC = HomeVC()
        homeVC.title = "Home"
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: TabbarImages.homeTabbarItemImage, tag: 0)
        
        return UINavigationController(rootViewController: homeVC)
    }
    
    func createGroupNC() -> UINavigationController {
        let groupVC = GroupsVS()
        groupVC.title = "Group"
        groupVC.tabBarItem = UITabBarItem(title: "Community", image: TabbarImages.groupTabbarItemImage, tag: 1)
        
        return UINavigationController(rootViewController: groupVC)
        
    }
    
    func createMessageNC() -> UINavigationController {
        let messageVC = MessagesVC()
        messageVC.title = "Messages"
        messageVC.tabBarItem = UITabBarItem(title: "Chat", image: TabbarImages.chatTabbarItemImage, tag: 2)
        
        return UINavigationController(rootViewController: messageVC)
    }
    
    func createProfileNC() -> UINavigationController {
        let profileVC = ProfileVC()
        profileVC.title = "Profile"
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: TabbarImages.profileTabbarItemImage, tag: 3)
        
        return UINavigationController(rootViewController: profileVC)
    }
  
    
    fileprivate func configureNavigationBar() {
         //UINavigationBar.appearance().tintColor = .orange
        if #available(iOS 13.0, *){

            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.backgroundColor = .systemBackground
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.orange]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.orange]
            
            UINavigationBar.appearance(whenContainedInInstancesOf: [UINavigationController.self]).standardAppearance = navBarAppearance
            UINavigationBar.appearance(whenContainedInInstancesOf: [UINavigationController.self]).scrollEdgeAppearance = navBarAppearance
            
        }
        
      }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

