//
//  AnalysisViewModel.swift
//  BehavioralCoach
//
//  TODO (Phase 2+ — stub it out for Phase 1):
//
//  Orchestrates the full analysis pipeline for a finished recording:
//
//      videoURL  →  Transcriber     →  transcript
//                   MetricsAnalyzer  →  SpeechMetrics
//                   LLMAnalyzer      →  Critique
//                   ↓
//                   Save Session to SwiftData
//                   ↓
//                   Present on AnalysisView
//
//  Suggested shape:
//
//      @Observable
//      final class AnalysisViewModel {
//          enum Phase { case transcribing, computing, coaching, done, failed(String) }
//
//          private(set) var phase: Phase = .transcribing
//          private(set) var transcript: String = ""
//          private(set) var metrics: SpeechMetrics?
//          private(set) var critique: Critique?
//
//          func analyze(videoURL: URL, question: Question) async { ... }
//      }
//
//  Phase 1 can skip this entirely — the Phase 1 AnalysisView just shows
//  the replay video and a "saved" message. Start building this in Phase 2
//  once Transcriber exists.
//

import Foundation
import Observation

// Implement here starting in Phase 2.
