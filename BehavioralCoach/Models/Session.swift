//
//  Session.swift
//  BehavioralCoach
//
//  A single practice session: one question, one video recording, one
//  transcript, one set of metrics, one critique. Persisted via SwiftData.
//
//  Design note: metrics and critique are stored as JSON blobs rather than
//  as SwiftData @Model types. Reason: the metrics struct is a mirror of a
//  C++ type (Phase 5) and the critique is a value type we get back from
//  the LLM. Neither needs to be queryable independently — we only ever
//  load them in the context of their parent Session. JSON keeps the
//  @Model layer clean and lets us evolve those types without migrations.
//

import Foundation
import SwiftData

@Model
final class Session {
    @Attribute(.unique) var id: UUID
    var startedAt: Date
    var durationSeconds: Double

    // Denormalized question fields — we copy these from Question at creation
    // time rather than holding a relationship. Question is static data from
    // JSON, not a SwiftData model, so we can't have a @Relationship to it,
    // and snapshotting means the session still makes sense if we later
    // rewrite a question in the JSON file.
    var questionPrompt: String
    var questionCategory: String
    var questionProbeType: String

    var videoFileURL: URL?

    // Phase 2 populates this
    var transcript: String

    // Phase 3 populates this (JSON-encoded Critique)
    var critiqueJSON: Data?

    // Phase 5 populates this (JSON-encoded SpeechMetrics)
    var metricsJSON: Data?

    init(
        question: Question,
        startedAt: Date = .now,
        durationSeconds: Double = 0,
        videoFileURL: URL? = nil,
        transcript: String = ""
    ) {
        self.id = UUID()
        self.startedAt = startedAt
        self.durationSeconds = durationSeconds
        self.questionPrompt = question.prompt
        self.questionCategory = question.category.rawValue
        self.questionProbeType = question.probeType.rawValue
        self.videoFileURL = videoFileURL
        self.transcript = transcript
    }
}

// MARK: - Typed accessors for the JSON blobs

extension Session {
    var metrics: SpeechMetrics? {
        get {
            guard let data = metricsJSON else { return nil }
            return try? JSONDecoder().decode(SpeechMetrics.self, from: data)
        }
        set {
            metricsJSON = newValue.flatMap { try? JSONEncoder().encode($0) }
        }
    }

    var critique: Critique? {
        get {
            guard let data = critiqueJSON else { return nil }
            return try? JSONDecoder().decode(Critique.self, from: data)
        }
        set {
            critiqueJSON = newValue.flatMap { try? JSONEncoder().encode($0) }
        }
    }
}
