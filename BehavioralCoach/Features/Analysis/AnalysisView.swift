//
//  AnalysisView.swift
//  BehavioralCoach
//
//  Phase 1: stub. Just shows "recording saved" + a replay player.
//  Phase 2: adds transcript section.
//  Phase 3: adds critique section (strengths, issues with excerpts).
//  Phase 4: this screen is also reached from History via SessionDetailView.
//  Phase 5: metrics section shows speaking rate, pauses, codas from C++ analyzer.
//
//  Design principle: this screen is READ-ONLY. The user watches their video
//  and reads the critique. No editing, no re-recording from here. If they
//  want to try again, they go back to QuestionListView and pick the same
//  question again — history preserves the old session.
//

import SwiftUI

struct AnalysisView: View {
    // In Phase 1 this takes just a videoURL.
    // In Phase 4 this takes a Session so it can be reopened from history.
    let videoURL: URL

    var body: some View {
        Text("AnalysisView — implement in Phase 1 (just video replay)")
            .foregroundStyle(.secondary)
    }
}
