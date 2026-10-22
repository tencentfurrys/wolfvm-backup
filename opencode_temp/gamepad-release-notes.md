# Gamepad build — buttons look identical, input delivery hardened

The on-screen gamepad/buttons look exactly the same as before. What changed is only *how their presses reach the game*: this build patches the native input path in `libyoyo.so` (arm64-v8a) with three fixes, all restoring the behavior of the older v1.0 build where the overlay worked on phones:

1. **Removed the fresh-press gate on an uninitialized 5th argument.** v2.7.8 checks a 5th event field that the Java overlay never fills (leftover register garbage). If that garbage was `> 0`, the entire button press was silently discarded — the exact "buttons do nothing" symptom.
2. **Removed the keymap indirection on key-state writes.** v2.7.8 routes every press through a runtime-initialized keymap table (`IO_Keymap`). If that table was never initialized on the device, all writes landed in one slot and no key ever registered. Writes now go straight to the key's own slot, like v1.0. (The game itself never uses `keyboard_set_map`, so nothing else relies on that table.)
3. **Removed the engine-UI capture skip.** v2.7.8 skips all key-state updates while its internal UI-capture flag is set — a flag that can't meaningfully apply to this game.

## Verifying on your phone

The debug HUD from the diag build is intentionally still included (small readout, top-left).

- Open the game, press any on-screen button.
- The **chk** row must flip to `1y` for the matching key (e.g. pressing left → `37:1y`).
- Once you confirm this works, tell me and I'll ship a clean build without the HUD.

## Device coverage

- **arm64-v8a** (all modern phones): patched.
- **x86_64** (emulators): byte-identical to the older working build — no change needed.
- **armeabi-v7a** (old 32-bit devices): unpatched stock behavior; buttons may not work there. Tell me if you need it and I'll patch that one too.

## Install

If installing over the diag build fails, uninstall the old copy first, then install this APK.
