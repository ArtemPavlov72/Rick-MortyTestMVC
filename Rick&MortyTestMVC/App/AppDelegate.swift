//
//  AppDelegate.swift
//  Rick&MortyTestMVC
//
//  Created by Artem Pavlov on 17.08.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    let navigationBarAppearace = UINavigationBar.appearance()
    navigationBarAppearace.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = UINavigationController(
      rootViewController: MainViewController(collectionViewLayout: UICollectionViewFlowLayout())
    )
    window?.makeKeyAndVisible()
    return true
  }
}
