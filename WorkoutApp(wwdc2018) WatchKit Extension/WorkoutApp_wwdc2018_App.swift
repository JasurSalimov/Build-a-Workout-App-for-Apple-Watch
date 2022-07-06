//
//  WorkoutApp_wwdc2018_App.swift
//  WorkoutApp(wwdc2018) WatchKit Extension
//
//  Created by Jasur Salimov on 7/6/22.
//

import SwiftUI

@main
struct WorkoutApp_wwdc2018_App: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                StartView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
