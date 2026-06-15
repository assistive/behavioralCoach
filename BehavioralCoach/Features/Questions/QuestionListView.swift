//
//  QuestionListView.swift
//  BehavioralCoach
//
//  TODO (Phase 1 — you implement this):
//
//  A list of behavioral prompts, grouped by Question.Category.
//  Tapping a row navigates to RecordingView with the chosen question.
//
//  Suggested shape:
//  - NavigationStack at the top
//  - List with ForEach over Question.Category.allCases
//  - Section per category with a localized header
//  - Each row shows the prompt text; tapping navigates to RecordingView(question:)
//  - A "Random" button in the toolbar that picks any prompt at random
//
//  State:
//  - @State private var store = QuestionsStore()
//  - Navigation can use NavigationStack + NavigationLink(value:) with
//    .navigationDestination(for: Question.self) { RecordingView(question: $0) }
//
//  Keep it simple. No search, no filtering, no favorites in Phase 1.
//

import SwiftUI

struct QuestionListView: View {
    var body: some View {
        Text("QuestionListView — implement in Phase 1")
            .foregroundStyle(.secondary)
    }
}

#Preview {
    QuestionListView()
}
