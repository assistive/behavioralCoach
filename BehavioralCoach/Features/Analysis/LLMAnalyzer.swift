//
//  LLMAnalyzer.swift
//  BehavioralCoach
//
//  TODO (Phase 3 — do not implement in Phase 1 or 2):
//
//  Uses the Apple Foundation Models framework to generate a Critique
//  from a transcript + question context. Runs entirely on-device via
//  Apple Intelligence.
//
//  Suggested shape:
//
//      import FoundationModels
//
//      final class LLMAnalyzer {
//          enum Error: Swift.Error { case unavailable, generationFailed }
//
//          func critique(
//              transcript: String,
//              question: Question,
//              metrics: SpeechMetrics
//          ) async throws -> Critique {
//              let system = PromptLibrary.coachSystemPrompt(for: question)
//              let user = PromptLibrary.coachUserPrompt(
//                  transcript: transcript,
//                  metrics: metrics
//              )
//
//              let session = LanguageModelSession(instructions: system)
//              let response = try await session.respond(
//                  to: user,
//                  generating: Critique.self  // structured output via @Generable
//              )
//              return response.content
//          }
//      }
//
//  To use `generating: Critique.self` you need to mark Critique as
//  `@Generable` — Apple Foundation Models requires this for structured
//  generation. That may require adding `import FoundationModels` and
//  `@Generable` attribute to the Critique type. Add it when you reach
//  Phase 3; don't add it before, because it's an iOS 18.1+ API and you
//  don't want to tie Phase 1 compilation to it.
//
//  Alternative if @Generable is clunky: have the model return raw JSON
//  text and decode it manually. Less elegant but more portable across
//  Foundation Models API versions.
//

import Foundation

// Implement here in Phase 3.
