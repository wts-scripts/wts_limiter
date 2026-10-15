# wts_limiter

**Standalone speed limiter for FiveM — one key, no framework, no dependency.**

[![Release](https://img.shields.io/github/v/release/Wts-scripts/wts_limiter?style=flat-square)](https://github.com/Wts-scripts/wts_limiter/releases/latest)
[![License: GPL-3.0](https://img.shields.io/badge/license-GPL--3.0-blue?style=flat-square)](LICENSE)
[![Docs](https://img.shields.io/badge/docs-GitBook-purple?style=flat-square)](https://wts-scripts.gitbook.io/wts_scripts-docs)
[![Discord](https://img.shields.io/badge/discord-WTS%20Scripts-5865F2?style=flat-square)](https://discord.gg/79THbUP9xN)

Made by **WTS Scripts** · [Store](https://wts-scripts.tebex.store) · [Documentation](https://wts-scripts.gitbook.io/wts_scripts-docs) · [Discord](https://discord.gg/79THbUP9xN)

> Also available as a free package on the [WTS Scripts store](https://wts-scripts.tebex.store) if you prefer to get update notifications through Tebex/Discord.

Press a key while driving and your current speed becomes the limit — like a real cruise limiter. Press again to release it. A clean dark notification shows the locked speed: green on enable, red on disable.

## Features

- Toggle with a key (default **L**, players can rebind it in *Settings > Key Bindings > FiveM*) or `/togglelimiter`
- Locks the speed you are driving at when you press the key
- Released automatically when you leave the vehicle or the resource stops — no stuck speed cap
- km/h or mph
- Built-in notifications (no ox_lib). If [wts_notify](https://github.com/Wts-scripts/wts_notify) is running, notifications go through it automatically, with the same look as every WTS script
- Standalone: ESX, QBCore, QBox or custom, nothing to configure
- Client-side only, no server script
- English by default, French block ready in `config.lua`

## Installation

1. Put `wts_limiter` in `resources/`.
2. `server.cfg`:
   ```cfg
   ensure wts_limiter
   ```
   If you use [wts_notify](https://github.com/Wts-scripts/wts_notify), start it **before** `wts_limiter`.
3. Get in a car, drive, press **L**.

## Configuration

Everything is in `config.lua`:

| Option | Default | Description |
|---|---|---|
| `Config.Key` | `'L'` | Default key (`'L'`, `'SEMICOLON'`, `'COMMA'`, `'OEM_102'`…) |
| `Config.Unit` | `'kmh'` | `'kmh'` or `'mph'` |
| `Config.NotifyTitle` | `'WTS Limiter'` | Title of the notification |
| `Config.NotifyDuration` | `4000` | Duration in ms |
| `Config.UseWtsNotify` | `true` | Use wts_notify when it is started |
| `Config.Colors` | dark grey / green / red | Background, text, enable and disable colors (hex) |
| `Config.Text` | English | All messages — a French block is ready to uncomment |

## Support

- Bug or idea → [Issues](https://github.com/Wts-scripts/wts_limiter/issues)
- Questions → [Discord](https://discord.gg/79THbUP9xN)

## License

GPL-3.0 — see [LICENSE](LICENSE). You can use, modify and redistribute it, as long as your version stays under the same license and credits WTS Scripts.
