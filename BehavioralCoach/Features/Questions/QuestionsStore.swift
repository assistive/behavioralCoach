//
//  QuestionsStore.swift
//  BehavioralCoach
//
//  Loads the bundled questions.json at launch. No persistence, no
//  mutation — questions are static data that ship with the app.
//
//  In Phase 6 we may add user-authored questions, at which point this
//  class gains a writable store behind the existing read API.
//

import Foundation
import Observation

@Observable
final class QuestionsStore {
    private(set) var questions: [Question] = []
    private(set) var loadError: String?

    init() {
        load()
    }

    func load() {
        guard let url = Bundle.main.url(forResource: "questions", withExtension: "json") else {
            loadError = "questions.json missing from bundle"
            return
        }
        do {
            let data = try Data(contentsOf: url)
            questions = try JSONDecoder().decode([Question].self, from: data)
        } catch {
            loadError = "failed to decode questions.json: \(error.localizedDescription)"
        }
    }

    func questions(in category: Question.Category) -> [Question] {
        questions.filter { $0.category == category }
    }

    func random(in category: Question.Category? = nil) -> Question? {
        let pool = category.map { questions(in: $0) } ?? questions
        return pool.randomElement()
    }
}
