//
//  BehavioralCoachApp.swift
//  BehavioralCoach
//
//  App entry point. Sets up the SwiftData model container and roots
//  the view hierarchy at ContentView.
//

import SwiftUI
import SwiftData

@main
struct BehavioralCoachApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Session.self)
    }
}
