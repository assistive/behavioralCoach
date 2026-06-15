//
//  Question.swift
//  BehavioralCoach
//
//  A single behavioral interview prompt. Static data loaded from
//  Resources/questions.json at launch. Not persisted — if you want
//  to edit the question bank, edit the JSON file.
//

import Foundation

struct Question: Identifiable, Codable, Hashable {
    let id: UUID
    let prompt: String
    let category: Category
    let probeType: ProbeType

    /// What the question is broadly about. Used for filtering and for
    /// giving the LLM coach context about what to look for in the answer.
    enum Category: String, Codable, CaseIterable {
        case failureOwnership   // "tell me about a time you were wrong"
        case conflict           // "tell me about a disagreement"
        case leadership         // "tell me about leading through X"
        case ambiguity          // "tell me about operating with incomplete info"
        case influence          // "tell me about influencing without authority"
        case judgment           // "tell me about a judgment call you'd redo"
    }

    /// What question SHAPE this is. Some prompts are direct; others are
    /// deliberately disguised probes that test for self-awareness ("trojan horse"
    /// questions). The coach treats these differently when scoring an answer.
    enum ProbeType: String, Codable {
        case direct             // question explicitly asks for a failure
        case trojanHorse        // question looks like a success question but is probing for a failure
        case behavioral         // standard STAR-shaped behavioral
    }
}
