//
//  SpeechMetrics.swift
//  BehavioralCoach
//
//  Quantitative metrics about a spoken answer. In Phase 1–4 these are
//  computed in Swift. In Phase 5 the computation moves into a C++ module
//  (BehavioralCoachCpp/SpeechMetrics.cpp) and this Swift struct becomes a
//  mirror of the C++ `coach::ComputedMetrics` type. The two representations
//  stay Codable-compatible so the JSON shape on disk never changes when
//  you flip the implementation.
//

import Foundation

struct SpeechMetrics: Codable, Hashable {
    /// Speaking rate across the whole answer.
    /// Normal conversational English is 140–180 WPM. Above 200 often reads
    /// as "impatient" or "rushed" to interviewers; below 110 reads as "uncertain."
    var wordsPerMinute: Double

    /// Average pause length in seconds between sentences.
    /// Not necessarily bad — but combined with high WPM, short pauses are a
    /// tempo tell.
    var avgPauseSeconds: Double

    /// Longest single pause in the answer. A single long pause is usually fine
    /// (thinking). Several clustered long pauses suggest the answer wasn't ready.
    var longestPauseSeconds: Double

    /// Count of filler words: "um", "uh", "like", "you know", "basically",
    /// "actually", "kind of", "sort of".
    var fillerCount: Int

    var sentenceCount: Int
    var avgSentenceWords: Double

    /// Detected phrases that might indicate a reframe/vindication reflex.
    /// See `DetectedCoda.Kind` for categories.
    var detectedCodas: [DetectedCoda]
}

struct DetectedCoda: Codable, Hashable, Identifiable {
    let id: UUID
    let phrase: String
    let charOffset: Int     // position in transcript (character index)
    let kind: Kind

    enum Kind: String, Codable {
        /// "go figure", "turns out they did the same thing", "and then X validated me"
        /// — sentence-final beats that quietly reframe a failure as being vindicated.
        case vindication

        /// "kind of", "sort of", "I guess", "probably" — softening language
        /// that distances the speaker from ownership.
        case hedge

        /// "they ended up", "it just happened", "the project fell apart" —
        /// passive or agent-less framing that puts the failure on external forces.
        case deflection
    }

    init(phrase: String, charOffset: Int, kind: Kind) {
        self.id = UUID()
        self.phrase = phrase
        self.charOffset = charOffset
        self.kind = kind
    }
}
