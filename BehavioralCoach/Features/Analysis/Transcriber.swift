//
//  Transcriber.swift
//  BehavioralCoach
//
//  TODO (Phase 2 — do not implement in Phase 1):
//
//  Takes a video file URL, pulls out the audio track, runs it through
//  SFSpeechRecognizer on-device, and returns the transcript.
//
//  Suggested shape:
//
//      final class Transcriber {
//          enum Error: Swift.Error { case notAvailable, notAuthorized, recognitionFailed }
//
//          func transcribe(videoURL: URL) async throws -> String {
//              try await requestAuthorizationIfNeeded()
//              guard let recognizer = SFSpeechRecognizer(locale: .init(identifier: "en-US")),
//                    recognizer.isAvailable,
//                    recognizer.supportsOnDeviceRecognition
//              else { throw Error.notAvailable }
//
//              let request = SFSpeechURLRecognitionRequest(url: videoURL)
//              request.requiresOnDeviceRecognition = true  // ← IMPORTANT, privacy
//              request.shouldReportPartialResults = false
//
//              return try await withCheckedThrowingContinuation { cont in
//                  recognizer.recognitionTask(with: request) { result, error in
//                      if let error = error { cont.resume(throwing: error); return }
//                      if let result = result, result.isFinal {
//                          cont.resume(returning: result.bestTranscription.formattedString)
//                      }
//                  }
//              }
//          }
//
//          private func requestAuthorizationIfNeeded() async throws { ... }
//      }
//
//  IMPORTANT: `requiresOnDeviceRecognition = true` is non-negotiable for
//  this app. If on-device isn't available on the user's device, fail loudly
//  rather than falling back to cloud recognition. Failure stories never
//  leave the phone.
//
//  Note: SFSpeechURLRecognitionRequest can take an .mov file directly —
//  it'll read the audio track automatically. You don't need to manually
//  extract the audio with AVAssetReader.
//

import Foundation
import Speech

// Implement here in Phase 2.
