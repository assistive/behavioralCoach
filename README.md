# Behavioral Coach

A native iOS app for practicing behavioral interview answers. Records you on camera, transcribes what you said, and uses on-device Apple Intelligence to critique the delivery — specifically catching the reflexes that tank senior interviews: reframe/vindication codas, missing mistake-ownership, tempo issues, and structural weaknesses.

Everything runs on-device. Nothing leaves the phone. Failure stories are sensitive; they don't belong in anyone's cloud logs.

## Why this exists

Principal/Staff behavioral interviews probe for EQ and self-awareness with a specific question shape — "tell me about a time you were confidently wrong." The failure mode is usually not lack of stories, it's reflexive reframing: stories that end with a vindication beat ("...go figure") that quietly undoes the failure. You can't catch the reflex in the moment; you have to see it on playback.

This tool is that playback, with annotations.

## Requirements

- iOS 18.1+ (Apple Intelligence / Foundation Models framework)
- Device with Apple Intelligence support (iPhone 15 Pro and later, or A17 Pro / M-series iPad)
- Xcode 16+

## Build phases

The project is designed so there's always a working app after each phase. Do not skip ahead — each phase builds on the previous, and Phase 1 alone is already useful for practice (you can record and replay without any analysis).

| Phase | Goal | Est. |
|---|---|---|
| 1 | App shell: questions list → video recording → replay. No transcription, no LLM, no persistence. | 1–2 evenings |
| 2 | Transcription via `SFSpeechRecognizer` at end of recording. | 1 evening |
| 3 | LLM critique via Foundation Models framework. | 1–2 evenings |
| 4 | SwiftData persistence + History tab. | 1 evening |
| 5 | **First Swift/C++ interop boundary.** Metrics computation moves into a C++ module. | 1 evening |
| 6+ | Optional: C++ DSP audio features, whisper.cpp, custom questions, export. | — |

## Directory layout

```
ios-behavioral-coach/
├── BehavioralCoach.xcodeproj/              (you create this in Xcode)
├── BehavioralCoach/
│   ├── BehavioralCoachApp.swift            @main entry, SwiftData container
│   ├── ContentView.swift                   root, TabView: Practice | History
│   │
│   ├── Models/                             data types (no UI, no I/O)
│   │   ├── Question.swift
│   │   ├── Session.swift                   @Model (SwiftData)
│   │   ├── SpeechMetrics.swift             Swift mirror of C++ struct (Phase 5)
│   │   └── Critique.swift
│   │
│   ├── Features/                           one folder per screen/feature
│   │   ├── Questions/
│   │   │   ├── QuestionListView.swift
│   │   │   └── QuestionsStore.swift        loads questions.json
│   │   ├── Recording/
│   │   │   ├── RecordingView.swift         camera preview + controls
│   │   │   ├── RecordingViewModel.swift    @Observable, state machine
│   │   │   ├── VideoRecorder.swift         wraps AVCaptureSession
│   │   │   └── CameraPreview.swift         UIViewRepresentable
│   │   ├── Analysis/
│   │   │   ├── AnalysisView.swift          transcript + metrics + critique
│   │   │   ├── AnalysisViewModel.swift     orchestrates the pipeline
│   │   │   ├── Transcriber.swift           SFSpeechRecognizer on the video's audio track
│   │   │   ├── MetricsAnalyzer.swift       Swift wrapper; calls C++ in Phase 5
│   │   │   └── LLMAnalyzer.swift           Foundation Models framework
│   │   └── History/
│   │       ├── HistoryView.swift
│   │       └── SessionDetailView.swift     AVPlayer replay + results
│   │
│   ├── Services/
│   │   └── PromptLibrary.swift             LLM system prompt for the coach
│   │
│   └── Resources/
│       └── questions.json                  bundled behavioral prompts
│
├── BehavioralCoachCpp/                     (added in Phase 5)
│   ├── include/SpeechMetrics.hpp
│   └── src/SpeechMetrics.cpp
│
└── README.md
```

## Phase 1 setup (do this first)

### Create the Xcode project

1. Xcode → File → New → Project → iOS → App
2. Product name: `BehavioralCoach`
3. Interface: SwiftUI
4. Storage: SwiftData
5. Testing system: Swift Testing (optional but recommended)
6. Minimum deployment: **iOS 18.1**
7. Save the `.xcodeproj` at `ios-behavioral-coach/BehavioralCoach.xcodeproj/` — overwriting is fine, the scaffold files will drop into `BehavioralCoach/` next to it.
8. After project creation, drag the pre-scaffolded `BehavioralCoach/Models`, `BehavioralCoach/Features`, `BehavioralCoach/Services`, and `BehavioralCoach/Resources` folders into the Xcode file navigator. Choose *"Create groups"*, not *"Create folder references"*.

### Info.plist permissions (REQUIRED — app will crash without these)

Project settings → Info tab → add these three keys:

| Key | Value |
|---|---|
| `NSCameraUsageDescription` | *We record you answering so you can watch your own delivery and catch reflexes you can't feel in the moment.* |
| `NSMicrophoneUsageDescription` | *We record audio alongside the video to analyze your speech.* |
| `NSSpeechRecognitionUsageDescription` | *We transcribe your recorded answers on-device so nothing leaves your phone.* |

### Scaffold files

The Swift files in `Models/`, `Features/`, `Services/`, and `Resources/` are pre-written with:

- Data model types fully implemented
- View files as stubs with doc comments describing what each should do
- `questions.json` with 20 real behavioral prompts covering the question types you're most likely to get

Your job in Phase 1 is to fill in the View and ViewModel files. The Models, Services, and Resources are done — don't rewrite them.

## Privacy note

This app does not send anything to the network. No telemetry, no crash reporting, no cloud sync, no account system. Everything — audio, video, transcripts, critiques — lives on the device. Delete the app to delete the data.

The reason this matters: failure stories are sensitive. A story you practice here may reference real people, real projects, real companies. That kind of content does not belong in anyone's server logs, training data, or backup system. On-device is the only safe choice for this category of tool.
