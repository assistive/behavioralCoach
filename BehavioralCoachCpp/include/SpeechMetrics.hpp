//
//  SpeechMetrics.hpp
//  BehavioralCoachCpp
//
//  Phase 5: first Swift/C++ interop boundary. Declares the scalar
//  speech-metric computation. ABI is deliberately POD-only: a const char*
//  in, a plain scalar struct out. No std::string / std::vector / containers
//  cross the boundary. Coda detection stays in Swift.
//

#pragma once

namespace coach {

struct ComputedMetrics {
  double wordsPerMinute;
  double avgPauseSeconds;
  double longestPauseSeconds;
  int    fillerCount;
  int    sentenceCount;
  double avgSentenceWords;
};

// transcript is a null-terminated UTF-8 C string; durationSeconds is total media length.
ComputedMetrics compute_metrics(const char* transcript, double durationSeconds);

}  // namespace coach
