//
//  RecordingView.swift
//  BehavioralCoach
//
//  TODO (Phase 1 — you implement this):
//
//  The screen the user sees while answering a question. Camera preview
//  on top, the question prompt in a card below it, and a big record /
//  stop button at the bottom.
//
//  Suggested layout:
//
//      VStack {
//          CameraPreview(session: viewModel.recorder.session)
//              .aspectRatio(9/16, contentMode: .fit)
//              .clipShape(RoundedRectangle(cornerRadius: 16))
//
//          Text(viewModel.question.prompt)
//              .font(.headline)
//              .multilineTextAlignment(.center)
//              .padding()
//
//          Spacer()
//
//          RecordButton(state: viewModel.state) { ... }
//              .padding(.bottom, 40)
//      }
//      .task { await viewModel.start() }
//
//  On .finished(videoURL:), navigate to AnalysisView(session: ...).
//  In Phase 1 you can skip analysis and just show a "Recording saved"
//  confirmation + a replay via AVPlayer.
//
//  Record button should:
//   - show a red circle while ready
//   - show a red square while recording + elapsed time counter
//   - be disabled while configuring or finishing
//

import SwiftUI

struct RecordingView: View {
    let question: Question

    var body: some View {
        Text("RecordingView for: \(question.prompt)")
            .padding()
            .foregroundStyle(.secondary)
    }
}

#Preview {
    RecordingView(
        question: Question(
            id: UUID(),
            prompt: "Tell me about a time you were wrong.",
            category: .failureOwnership,
            probeType: .direct
        )
    )
}
