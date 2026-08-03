# PrepZone — Runnable Starter (Module 4)

## What this actually is

A **real, runnable Flutter app** implementing the highest-leverage 20% of the
architecture from Modules 1–3: the generic Exam Detail scaffold (renders any
of the 20 tabs for any exam from data, not code), the shared Test Engine
(bilingual question rendering, timer, palette, result), Home, Exam Hub, and
Login. It runs today, on sample in-memory data, with no Firebase project
required.

It is **not** a finished production app — no codebase, from me or anyone,
gets to "1000 exams, live payments, on the App Store" in one pass. Here's
exactly what's between this and that, so nothing is oversold:

## Run it now

```bash
flutter pub get
flutter run
```

Opens on Home → tap an exam → the 20-tab page → tap "Start" under Mock Tests
→ take a 2-question bilingual demo test → see the result screen with the
stamp badge. Toggle EN/हिं/Bilingual in any app bar. Toggle dark mode via
system settings.

## What's genuinely still needed before this is "production-ready"

1. **A real Firebase project.** Run `flutterfire configure`, uncomment the
   `Firebase.initializeApp` line in `main.dart`. Replace `SampleData` calls
   with a `FirestoreExamRepository` implementing the same interface — the
   models in `core/models/` already match the Module 1 schema exactly, so
   this is a repository swap, not a rewrite.
2. **Firestore security rules + Cloud Functions** (Module 2, not yet built) —
   without these, nothing is actually secure or paid-for. This is the next
   thing to build.
3. **PhonePe merchant credentials** — you need a live PhonePe Business
   account; the payment flow can't be wired without your merchant ID/salt key.
4. **Content for 1000+ exams.** This is the single biggest remaining task and
   it's not a coding problem — it's data entry (or licensing a content
   provider). The admin panel (Module 6, not yet built) is what makes this
   feasible without an engineer per exam.
5. **App icons, fonts (Space Grotesk/Inter/IBM Plex Mono actual font files),
   Play Store/App Store developer accounts, signing keys.**

## What to build next (pick one)

- Module 2 — Firestore rules + Cloud Functions (auth, PhonePe, rank calc)
- Module 5 — Test Engine hardening (offline resume, auto-save, negative marking edge cases)
- Module 6 — Admin Panel (the thing that lets non-engineers add exam #4 through #1000)
