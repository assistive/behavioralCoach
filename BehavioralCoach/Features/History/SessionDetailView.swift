//
//  SessionDetailView.swift
//  BehavioralCoach
//
//  TODO (Phase 4 — do not implement in Phase 1):
//
//  Read-only view of a past session. Video replay at top, transcript in
//  the middle, critique at the bottom. Same visual structure as
//  AnalysisView — consider factoring shared UI out so they don't diverge.
//
//  Suggested shape:
//
//      struct SessionDetailView: View {
//          let session: Session
//
//          var body: some View {
//              ScrollView {
//                  if let url = session.videoFileURL {
//                      VideoPlayer(player: AVPlayer(url: url))
//                          .aspectRatio(9/16, contentMode: .fit)
//                  }
//                  // Prompt, transcript, metrics, critique sections
//              }
//              .navigationTitle(session.startedAt.formatted(date: .abbreviated, time: .shortened))
//          }
//      }
//

import SwiftUI

struct SessionDetailView: View {
    var body: some View {
        Text("SessionDetailView — implement in Phase 4")
            .foregroundStyle(.secondary)
    }
}
