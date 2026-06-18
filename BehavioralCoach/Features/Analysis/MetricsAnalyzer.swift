//
//  MetricsAnalyzer.swift
//  BehavioralCoach
//
//  Phase 5: the scalar speech metrics (WPM, filler/sentence counts, pause
//  placeholders, avg sentence words) now come from the C++ module via
//  coach::compute_metrics() in BehavioralCoachCpp. The transcript crosses the
//  boundary as a null-terminated UTF-8 C string and a plain POD struct comes
//  back — no std::string/containers in the signature.
//
//  Coda detection (DetectedCoda with phrases/offsets/kind) stays in Swift,
//  because it needs string/array output that doesn't cross the scalar ABI.
//
//  The public API is unchanged, so nothing else in the app needs to change.
//

import Foundation
import BehavioralCoachCpp

enum MetricsAnalyzer {
    /// Compute quantitative metrics from a finished transcript.
    ///
    /// - Parameters:
    ///   - transcript: The full transcribed text of the answer.
    ///   - durationSeconds: Total length of the audio/video in seconds.
    /// - Returns: A `SpeechMetrics` value with all fields populated.
    static func compute(transcript: String, durationSeconds: Double) -> SpeechMetrics {
        // Scalars come from the C++ coach::compute_metrics module.
        let c = transcript.withCString { coach.compute_metrics($0, durationSeconds) }

        // Coda detection stays in Swift (needs string/array output).
        var codas: [DetectedCoda] = []
        codas += detect(["go figure", "turns out", "little did i know",
                          "in hindsight i was right", "the data vindicated"],
                         kind: .vindication, in: transcript)
        codas += detect(["kind of", "sort of", "i guess", "probably",
                          "maybe", "sometimes"],
                         kind: .hedge, in: transcript)
        codas += detect(["they ended up", "it just happened", "the team failed",
                          "things fell apart", "the project died"],
                         kind: .deflection, in: transcript)
        codas.sort { $0.charOffset < $1.charOffset }

        return SpeechMetrics(
            wordsPerMinute: c.wordsPerMinute,
            avgPauseSeconds: c.avgPauseSeconds,
            longestPauseSeconds: c.longestPauseSeconds,
            fillerCount: Int(c.fillerCount),
            sentenceCount: Int(c.sentenceCount),
            avgSentenceWords: c.avgSentenceWords,
            detectedCodas: codas
        )
    }

    // MARK: - Helpers

    /// Build a `[DetectedCoda]` for every word-boundary match of any phrase.
    private static func detect(_ phrases: [String], kind: DetectedCoda.Kind, in text: String) -> [DetectedCoda] {
        var found: [DetectedCoda] = []
        let nsText = text as NSString
        let fullRange = NSRange(location: 0, length: nsText.length)
        for phrase in phrases {
            guard let regex = boundaryRegex(for: phrase) else { continue }
            regex.enumerateMatches(in: text, range: fullRange) { match, _, _ in
                guard let match else { return }
                // Convert UTF-16 match start to a Swift Character index.
                let offset: Int
                if let r = Range(match.range, in: text) {
                    offset = text.distance(from: text.startIndex, to: r.lowerBound)
                } else {
                    offset = match.range.location
                }
                found.append(DetectedCoda(phrase: phrase, charOffset: offset, kind: kind))
            }
        }
        return found
    }

    private static func boundaryRegex(for phrase: String) -> NSRegularExpression? {
        let pattern = "\\b" + NSRegularExpression.escapedPattern(for: phrase) + "\\b"
        return try? NSRegularExpression(pattern: pattern, options: [.caseInsensitive])
    }
}
