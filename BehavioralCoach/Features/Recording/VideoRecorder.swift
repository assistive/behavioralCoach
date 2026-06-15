//
//  VideoRecorder.swift
//  BehavioralCoach
//
//  TODO (Phase 1 — you implement this):
//
//  Owns the AVCaptureSession and handles start/stop recording. Saves the
//  result as a .mov file in the app's Documents directory and returns the URL.
//
//  This is deliberately a thin wrapper. The ViewModel owns all the state;
//  this class just knows how to talk to AVFoundation.
//
//  Suggested shape:
//
//      @Observable
//      final class VideoRecorder: NSObject, AVCaptureFileOutputRecordingDelegate {
//          let session = AVCaptureSession()
//          private let movieOutput = AVCaptureMovieFileOutput()
//          private var startCompletion: ((URL?, Error?) -> Void)?
//
//          func configure() async throws {
//              // 1. Request camera + mic permissions
//              // 2. session.beginConfiguration()
//              // 3. Add front camera input (AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front))
//              // 4. Add mic input (AVCaptureDevice.default(for: .audio))
//              // 5. Add movieOutput
//              // 6. session.commitConfiguration()
//              // 7. session.startRunning() on a background queue
//          }
//
//          func startRecording() throws {
//              let url = URL.documentsDirectory.appending(path: "\(UUID().uuidString).mov")
//              movieOutput.startRecording(to: url, recordingDelegate: self)
//          }
//
//          func stopRecording() async -> URL? {
//              // suspend on a continuation until fileOutput(...didFinishRecordingTo:) fires
//          }
//
//          // AVCaptureFileOutputRecordingDelegate
//          func fileOutput(_ output: AVCaptureFileOutput,
//                          didFinishRecordingTo outputFileURL: URL,
//                          from connections: [AVCaptureConnection],
//                          error: Error?) {
//              // resume the continuation with the URL (or nil if error)
//          }
//      }
//
//  Permissions note: AVCaptureDevice.requestAccess(for: .video) must be
//  called and granted BEFORE you try to add the input, otherwise the add
//  call silently fails and the session produces no frames.
//
//  Threading note: session.startRunning() blocks. Call it from a background
//  Task, never from the main thread.
//

import AVFoundation
import Observation

// Implement here.
