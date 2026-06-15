//
//  RecordingViewModel.swift
//  BehavioralCoach
//
//  TODO (Phase 1 — you implement this):
//
//  State machine for a single recording session. Owns the VideoRecorder
//  and exposes enough state for RecordingView to render and drive the UI.
//
//  Suggested state enum:
//
//      enum State {
//          case idle               // camera permission not yet requested
//          case configuring        // session starting up
//          case ready              // camera live, ready to record
//          case recording(start: Date)
//          case finishing          // stopRecording() is in flight
//          case finished(videoURL: URL)
//          case error(String)
//      }
//
//  Suggested API:
//
//      @Observable
//      final class RecordingViewModel {
//          let question: Question
//          private(set) var state: State = .idle
//          let recorder = VideoRecorder()
//
//          init(question: Question) { self.question = question }
//
//          func start() async { ... }    // permissions + configure + session start
//          func beginRecording() { ... } // state = .recording
//          func endRecording() async { ... } // state = .finishing → .finished
//      }
//
//  Phase 1 stops at .finished(videoURL:). Phase 2 takes that URL and
//  hands it to the AnalysisViewModel, which runs transcription on it.
//
//  Keep the elapsed-time display in the view, not the VM. Bind it to a
//  Timer or TimelineView rather than mutating @Observable state 60x/sec.
//

import Foundation
import Observation

// Implement here.
