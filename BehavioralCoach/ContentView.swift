//
//  ContentView.swift
//  BehavioralCoach
//
//  Root tab view. Two tabs: Practice (QuestionListView) and History.
//
//  Phase 1: only Practice tab matters. History tab can show the
//  placeholder HistoryView until Phase 4.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            QuestionListView()
                .tabItem {
                    Label("Practice", systemImage: "waveform.and.mic")
                }

            HistoryView()
                .tabItem {
                    Label("History", systemImage: "clock.arrow.circlepath")
                }
        }
    }
}

#Preview {
    ContentView()
}
