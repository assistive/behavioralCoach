# On-device smoke test (Phases 1–5)

Everything is compile-verified but has **never been run**. This checklist exercises the
whole stack on a real device in the order features were built, so a failure points at a
specific phase. Do it once end-to-end before building anything new.

## Prerequisites

- **Physical iPhone** (15 Pro or later) — the Simulator has no camera, so Phase 1 can't be tested there.
- **iOS 26+** with **Apple Intelligence enabled** (Settings → Apple Intelligence & Siri) — required for the coaching critique (Phase 3). On 18.1–18.x the app runs but the critique shows "coaching unavailable" by design.
- Run from **Xcode → Run (⌘R)** on the device (trust the developer cert under Settings → General → VPN & Device Management on first launch).
- First launch must let the on-device model finish downloading, or the critique will report unavailable until it does.

## The walkthrough

### 1. Launch & permissions
- [ ] App opens to the **Practice** tab (tab bar: Practice | History).
- [ ] Tap a question → recording screen → **camera + mic permission** prompts appear; grant both.
- ⚠️ Crash on launch ⇒ missing Info.plist usage keys (confirmed present, but verify on the actual target). Denying permission should land you on the error state with a **Retry** button, not a crash.

### 2. Record (Phase 1)
- [ ] Live **front-camera preview** is visible (not black).
- [ ] Button shows a **red circle** when ready → tap → becomes a **red square + mm:ss counter** that ticks up.
- [ ] Speak ~30–60s, tap stop → brief **"Saving…"** → auto-navigates to **Review**.
- ⚠️ Black preview / stuck on a spinner ⇒ `VideoRecorder.configure()` failed. No navigation after stop ⇒ the `stopRecording()` continuation didn't resume.

### 3. Replay (Phase 1)
- [ ] On Review, the captured video **plays back with audio**.
- ⚠️ Blank player ⇒ bad file URL from the recorder.

### 4. Transcription (Phase 2)
- [ ] Below the player: **"Transcribing…"** then a **Transcript** section with your words.
- ⚠️ A Speech-recognition permission prompt should appear the first time. Stuck on "Transcribing…" or an error label ⇒ auth not granted, or on-device recognition unavailable for the locale. "No speech detected" ⇒ audio track wasn't captured (check Phase 2 inputs).

### 5. Delivery metrics (Phase 3 + C++ interop)
- [ ] **"Analyzing delivery…"** → metrics appear: **WPM, sentence count, avg sentence length, filler count**, and any detected **codas**.
- [ ] Sanity-check the numbers against what you said (WPM in the low-100s–200s; filler count roughly right).
- ⚠️ This is the **C++ path** (`coach::compute_metrics`). WPM = 0 ⇒ duration load failed. A crash here implicates the Swift/C++ interop boundary, not the UI.

### 6. Coaching critique (Phase 3, iOS 26 LLM) — **most likely to need tuning**
- [ ] **"Coaching…"** → a critique with **overallNote**, **strengths** (green checks), **issue cards** (kind badge + quoted excerpt + explanation), and possibly a **suggested reframe**.
- ⚠️ **Expect to iterate here.** The biggest risk in the whole app: the model may return prose or markdown-fenced text that doesn't cleanly decode into `Critique`, surfacing as **"Coaching unavailable — <reason>"**. If so, **copy the exact reason text** — the fix is almost always in `LLMAnalyzer` (more robust JSON extraction) or `PromptLibrary` (a firmer "return only JSON" nudge). "Unavailable" can also just mean the model is still downloading — retry after a minute.

### 7. Persistence & History (Phase 4)
- [ ] Back out, open the **History** tab → the session is listed (date, prompt, duration, a line of overallNote).
- [ ] Tap it → detail view → **video replays** and transcript + metrics + critique match what you saw live.
- [ ] **Force-quit and relaunch the app**, reopen the session → it's still there and **the video still plays**. (This is the real test of `RecordingStore` stable storage + path re-resolution — the most likely silent bug.)
- [ ] **Swipe-delete** a row → gone; relaunch → still gone, and its video file is removed.
- ⚠️ Video won't play in detail *after relaunch* (but played live) ⇒ the sandbox-path-changed bug that `RecordingStore.resolve` is meant to handle — check it first.

## After the pass

Note anything that needed a fix (most likely #6). Once the loop holds on-device, the next
real work is the presentation roadmap — vocal tone (audio prosody) and eye contact (Vision
gaze) — see the README.
