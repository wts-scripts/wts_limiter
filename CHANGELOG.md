# Changelog

## 1.0.0 — 2026-10-15

First public release.

- Speed limiter toggled with a key (default `L`, rebindable in FiveM key settings) or `/togglelimiter`
- Locks your current speed as the limit; released automatically when you leave the vehicle or the resource stops
- km/h or mph
- Built-in dark NUI notifications with the big speed value (green on enable, red on disable), no ox_lib
- Automatically routed through [wts_notify](https://github.com/Wts-scripts/wts_notify) when it is running
- Standalone — no framework required
- English texts by default, French block ready to enable in `config.lua`
