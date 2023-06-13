//
//  InToTheSeoulApp.swift
//  InToTheSeoul
//
//  Created by 김동현 on 2023/05/31.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct InToTheSeoulApp: App {
    // register app delegate for Firebae setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var pointsModel: PointsModel = PointsModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(pointsModel)
        }
    }
}
