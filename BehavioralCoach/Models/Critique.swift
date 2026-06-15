//
//  Critique.swift
//  BehavioralCoach
//
//  The LLM's assessment of a practice answer. Structured output from
//  Apple Intelligence Foundation Models framework — the coach returns a
//  JSON object matching this shape, we decode it, and the Analysis screen
//  renders it.
//
//  Keep this type stable: it's also what shows up in history replay. If
//  you change it, think about backward compat for old sessions.
//

import Foundation

struct Critique: Codable, Hashable {
    /// One or two sentences summarizing the overall impression.
    /// This is what shows up at the top of the Analysis screen.
    var overallNote: String

    /// Things the speaker did well. Usually 1–3 items.
    /// Important: the coach is tuned to be specific here, not generic.
    /// "Good story structure" is useless. "You named the specific
    /// assumption you had wrong in sentence 3" is useful.
    var strengths: [String]

    /// Specific issues to fix, with excerpts from the transcript.
    /// Ordered by severity — most important first.
    var issues: [Issue]

    /// If the coach thinks there's a cleaner way to tell the same story,
    /// it provides a suggested rewrite. Optional because sometimes the
    /// answer is fine and the issue is elsewhere.
    var suggestedReframe: String?

    struct Issue: Codable, Hashable, Identifiable {
        var id = UUID()
        let kind: Kind
        let excerpt: String
        let explanation: String

        private enum CodingKeys: String, CodingKey {
            case kind, excerpt, explanation
        }
    }

    enum Kind: String, Codable {
        /// Story ends with a beat that softens the failure or vindicates
        /// the speaker's original position. The #1 thing this app exists
        /// to catch.
        case vindicationCoda

        /// Answer describes what went wrong but never states what the
        /// speaker updated, learned, or now does differently. The "update"
        /// is the payload in a failure-ownership question; missing it is
        /// the most common reason these answers fall flat.
        case missingUpdate

        /// Answer went on too long — lost the interviewer's attention before
        /// reaching the point.
        case tooLong

        /// Answer was too thin — didn't provide enough context to evaluate.
        case tooShort

        /// Passive voice in places where ownership matters.
        /// ("The project fell apart" vs "I made the call to shelve it.")
        case passiveVoice

        /// Abstract story without concrete specifics. No numbers, no names,
        /// no concrete decisions.
        case missingSpecificity

        /// Speaker performed the "but actually I was right" move somewhere
        /// in the middle of the story, not just at the end.
        case reframeReflex
    }
}
