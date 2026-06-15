//
//  HistoryView.swift
//  BehavioralCoach
//
//  TODO (Phase 4 — do not implement in Phase 1):
//
//  Lists past Session objects from SwiftData, newest first. Tap to open
//  SessionDetailView.
//
//  Suggested shape:
//
//      struct HistoryView: View {
//          @Query(sort: \Session.startedAt, order: .reverse) private var sessions: [Session]
//
//          var body: some View {
//              NavigationStack {
//                  List(sessions) { session in
//                      NavigationLink(value: session) {
//                          HistoryRow(session: session)
//                      }
//                  }
//                  .navigationDestination(for: Session.self) { SessionDetailView(session: $0) }
//                  .navigationTitle("History")
//              }
//          }
//      }
//
//  HistoryRow shows: date, truncated prompt, duration, and (if available)
//  a 1-sentence pull from critique.overallNote.
//
//  Do NOT show thumbnails in Phase 4 — generating video thumbnails for
//  every row is a surprising amount of work and slows down scroll. Add
//  thumbnails in a later phase if you decide you want them.
//

import SwiftUI

struct HistoryView: View {
    var body: some View {
        Text("HistoryView — implement in Phase 4")
            .foregroundStyle(.secondary)
    }
}
