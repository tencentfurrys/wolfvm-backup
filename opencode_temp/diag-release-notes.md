**Diagnostic build — not the fix yet.** Same v2.7.8 port build (compat layer, gamepad/touch untouched), plus an always-on debug HUD in the **top-left corner** that prints the raw input state every frame. Its only job is to find out where the on-screen button input dies on your phone.

## What the HUD shows

```
IPDIAG f=8241 seq=n/a
chk   0 0 0 0 0  0 0 0 0 0  0 0 0 0
dir   0 0 0 0 0  0 0 0 0 0  0 0 0 0
last=0  gp:0n 1n 2n 3n
gp0 pad12-15: 0000
```

- `f=` frame counter — proves the HUD code is alive (should count up constantly).
- `chk` — `keyboard_check()` for the keys **left, up, right, down, A, D, S, Q, F, E, P, Shift, Tab, Enter** (in this column order).
- `dir` — `keyboard_check_direct()` for the same keys.
- `last=` — last key the runner saw.
- `gp:` — gamepad 0–3 connection flags; `gp0 pad12-15` — gamepad 0 dpad buttons.

## What to report back (photo of the HUD is best)

1. Does the HUD appear at all (and does `f=` keep counting)?
2. Press each on-screen button (D-pad + A/D/S/Q/F/E/P) — **do the matching `chk` digits flip to 1 while held?**
3. Do any `dir` digits flip instead?
4. If you have a real controller handy — does `gp:` or `gp0 pad12-15` react to it?

Same signature as the previous port build — install straight over it (uninstall first only if the installer refuses).
