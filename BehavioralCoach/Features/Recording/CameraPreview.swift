//
//  CameraPreview.swift
//  BehavioralCoach
//
//  TODO (Phase 1 — you implement this):
//
//  A UIViewRepresentable that displays the live camera feed from an
//  AVCaptureSession. This is the SwiftUI bridge for AVCaptureVideoPreviewLayer.
//
//  Suggested shape:
//
//      struct CameraPreview: UIViewRepresentable {
//          let session: AVCaptureSession
//
//          func makeUIView(context: Context) -> PreviewView {
//              let v = PreviewView()
//              v.videoPreviewLayer.session = session
//              v.videoPreviewLayer.videoGravity = .resizeAspectFill
//              return v
//          }
//
//          func updateUIView(_ uiView: PreviewView, context: Context) {}
//      }
//
//      final class PreviewView: UIView {
//          override class var layerClass: AnyClass { AVCaptureVideoPreviewLayer.self }
//          var videoPreviewLayer: AVCaptureVideoPreviewLayer {
//              layer as! AVCaptureVideoPreviewLayer
//          }
//      }
//
//  The trick is using UIView with layerClass = AVCaptureVideoPreviewLayer.self
//  so the view's backing layer IS the preview layer. That avoids the resize /
//  layout bugs you get if you add the preview layer as a sublayer.
//

import SwiftUI
import AVFoundation

// Implement here.
