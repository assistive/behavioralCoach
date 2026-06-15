//
//  MetricsAnalyzer.swift
//  BehavioralCoach
//
//  Phase 3: a pure-Swift implementation that computes SpeechMetrics from
//  a transcript string + total duration.
//
//  Phase 5: the body of `compute` is replaced by a call into the C++
//  coach::compute_metrics() function. The public API stays identical
//  so nothing else in the app needs to change when you flip the
//  implementation.
//
//  This is the clean interop boundary: one function, one input type,
//  one output type. Everything above it in the stack treats it as a
//  black box. That's what makes it a good first Swift/C++ bridge
//  exercise — you don't have to worry about partial refactors.
//

import Foundation

enum MetricsAnalyzer {
    /// Compute quantitative metrics from a finished transcript.
    ///
    /// - Parameters:
    ///   - transcript: The full transcribed text of the answer.
    ///   - durationSeconds: Total length of the audio/video in seconds.
    /// - Returns: A `SpeechMetrics` value with all fields populated.
    ///
    /// TODO (Phase 3): implement in Swift.
    ///
    /// Reference behavior:
    ///   - wordsPerMinute = word count / (duration / 60)
    ///   - fillerCount = matches for: um, uh, like, you know, basically,
    ///                                actually, kind of, sort of
    ///     (use case-insensitive word-boundary regex)
    ///   - sentenceCount = count of .!? terminators (naive is fine)
    ///   - avgSentenceWords = wordCount / max(sentenceCount, 1)
    ///   - avgPauseSeconds = not knowable from transcript alone in Phase 3.
    ///     Stub to 0 until Phase 6 adds DSP audio features.
    ///   - longestPauseSeconds = 0 for now (same reason)
    ///   - detectedCodas = regex sweep for phrases listed below
    ///
    /// Vindication phrases to detect:
    ///   "go figure", "turns out", "little did i know", "in hindsight i was right",
    ///   "eventually [someone] [did|came around|agreed]", "the data vindicated"
    ///
    /// Hedge phrases:
    ///   "kind of", "sort of", "i guess", "probably", "maybe", "sometimes"
    ///
    /// Deflection phrases:
    ///   "they ended up", "it just happened", "the team failed",
    ///   "things fell apart", "the project died"
    ///
    /// In Phase 5 this entire body is replaced with:
    ///     let metrics = BehavioralCoachCpp.compute_metrics(transcript, durationSeconds)
    ///     return metrics.toSwift()
    static func compute(transcript: String, durationSeconds: Double) -> SpeechMetrics {
        // Stub — returns empty metrics so Phase 1/2 compiles.
        SpeechMetrics(
            wordsPerMinute: 0,
            avgPauseSeconds: 0,
            longestPauseSeconds: 0,
            fillerCount: 0,
            sentenceCount: 0,
            avgSentenceWords: 0,
            detectedCodas: []
        )
    }
}
