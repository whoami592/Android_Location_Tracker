# Android Mobile Location Tracker — Bash / Termux

**Coded by Cyber Security Engineer Mr Sabaz Ali Khan**

A consent-based Bash project for reading and locally logging the GPS location of **your own or an explicitly authorized Android device** using Termux and Termux:API.

## Features

- Read current GPS latitude/longitude
- Show accuracy, altitude, speed, bearing, provider
- Generate a Google Maps link
- Save location history locally as CSV
- Continuous local logging at a user-selected interval
- Show basic Android device information
- No hidden operation, no remote exfiltration, no bypass of Android permissions

## Requirements

1. Termux
2. Termux:API companion app
3. Android Location/GPS enabled
4. Location permission granted to Termux:API

Inside Termux:

```bash
pkg update
pkg install termux-api jq coreutils
```

## Run

```bash
chmod +x tracker.sh install.sh
./tracker.sh
```

Or:

```bash
./install.sh
./tracker.sh
```

## Location history

Saved to:

```text
logs/location_history.csv
```

## Important

Use this only on devices you own or where the device owner has explicitly authorized location collection. Android permission prompts are intentionally required by this project.
